import 'package:flutter/material.dart';

import '../../../data/repositories/customer_search_repository.dart';

class SearchNotifier extends ChangeNotifier {
  SearchNotifier(
    this.context, {
    required this.customerSearchRepo,
  });

  final BuildContext context;
  final CustomerSearchRepository customerSearchRepo;

  bool loading = true;

  List<String> _searchTerms = [];

  List<String> get searchTerms => _searchTerms;

  void fetchSearchTerms() async {
    var result = await customerSearchRepo.searchTerms(context);

    result.fold(
      (left) {
        return null;
      },
      (right) {
        _searchTerms.addAll(right.data);
      },
    );

    loading = false;

    notifyListeners();
  }
}
