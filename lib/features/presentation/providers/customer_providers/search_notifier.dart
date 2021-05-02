import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/customer/search_result_model.dart';
import '../../../data/repositories/customer_search_repository.dart';

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

  String? searchTermsErrorMsg;
  List<String> searchTerms = [];

  Future<void> fetchSearchTerms(BuildContext context) async {
    var result = await customerSearchRepo.searchTerms(context);

    result.fold(
      (left) => searchTermsErrorMsg = left.message,
      (right) => searchTerms = right.data,
    );

    notifyListeners();
  }

  Future<void> clearSearchTerms(BuildContext context) async {
    var result = await customerSearchRepo.clearSearchTerms(context);

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  String? searchErrorMsg;
  List<Market>? searchResultList;

  Future<void> search(BuildContext context, String term) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    notifyListeners();

    var result = await customerSearchRepo.search(
      context,
      term: term,
    );

    result.fold(
      (left) => searchErrorMsg = left.message,
      (right) => searchResultList = right.data.markets,
    );

    prgDialog.hide();
    notifyListeners();
  }

  void refresh() async {
    searchTermsErrorMsg = null;
    searchTerms = [];
    notifyListeners();
  }
}
