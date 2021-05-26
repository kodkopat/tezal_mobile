import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/customer/search_result_model.dart';
import '../../data/repositories/customer_search_repository.dart';

class SearchNotifier extends ChangeNotifier {
  static SearchNotifier? _instance;

  factory SearchNotifier(
    CustomerSearchRepository customerSearchRepo,
  ) {
    if (_instance == null) {
      _instance = SearchNotifier._privateConstructor(customerSearchRepo);
    }

    return _instance!;
  }

  SearchNotifier._privateConstructor(this.customerSearchRepo);

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

  String? searchErrorMsg;
  List<Market>? searchResultList;

  Future<void> search(BuildContext context, {required String term}) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    notifyListeners();

    var result = await customerSearchRepo.search(term: term);

    result.fold(
      (left) => searchErrorMsg = left.message,
      (right) => searchResultList = right.data.markets,
    );

    await fetchSearchTerms();

    prgDialog.hide();
    notifyListeners();
  }
}
