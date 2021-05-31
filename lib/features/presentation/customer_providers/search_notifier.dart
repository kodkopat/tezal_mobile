import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/customer/search_result_model.dart';
import '../../data/repositories/customer_search_repository.dart';

class CustomerSearchNotifier extends ChangeNotifier {
  static CustomerSearchNotifier? _instance;

  factory CustomerSearchNotifier(
    CustomerSearchRepository customerSearchRepo,
  ) {
    if (_instance == null) {
      _instance =
          CustomerSearchNotifier._privateConstructor(customerSearchRepo);
    }

    return _instance!;
  }

  CustomerSearchNotifier._privateConstructor(this.customerSearchRepo);

  final CustomerSearchRepository customerSearchRepo;

  bool wasFetchSearchTermsCalled = false;
  String? searchTermsErrorMsg;
  List<String> searchTerms = [];

  Future<void> fetchSearchTerms() async {
    if (!wasFetchSearchTermsCalled) {
      wasFetchSearchTermsCalled = true;
      notifyListeners();
    }

    var result = await customerSearchRepo.getSearchTerms();

    result.fold(
      (left) => searchTermsErrorMsg = left.message,
      (right) => searchTerms = right.data,
    );

    notifyListeners();
  }

  Future<void> clearSearchTerms() async {
    var result = await customerSearchRepo.clearSearchTerms();

    result.fold(
      (left) => null,
      (right) {
        searchTermsErrorMsg = null;
        searchTerms = [];
        notifyListeners();
      },
    );
  }

  int? sortListIndex;
  List<String> sortList = [
    "بر اساس فاصله", // distance,
    "بر اساس امتیاز", // score,
    "بر اساس قیمت", // price,
  ];

  int? directionListIndex = 1;
  List<String> directionList = [
    "صعودی", // acsending,
    "نزولی", // descending,
  ];

  String? term;
  String? searchErrorMsg;
  List<Market>? searchResultList;

  Future<void> search(
    BuildContext context, {
    required String term,
    int? sortListIndex,
    int? directionListIndex,
  }) async {
    this.term = term;

    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    bool? distanceAscending;
    if (sortListIndex != null && sortListIndex == 0) {
      distanceAscending = directionListIndex == 0;
    }

    bool? scoreAscescending;
    if (sortListIndex != null && sortListIndex == 1) {
      scoreAscescending = directionListIndex == 0;
    }

    bool? priceAscending;
    if (sortListIndex != null && sortListIndex == 2) {
      priceAscending = directionListIndex == 0;
    }

    var result = await customerSearchRepo.search(
      distanceAscending: distanceAscending,
      scoreAscending: scoreAscescending,
      priceAscending: priceAscending,
      term: term,
    );

    result.fold(
      (left) => searchErrorMsg = left.message,
      (right) => searchResultList = right.data.markets,
    );

    await fetchSearchTerms();

    prgDialog.hide();
    notifyListeners();
  }

  Future<void> refresh(BuildContext context) async {
    await search(context, term: this.term ?? "");
  }
}
