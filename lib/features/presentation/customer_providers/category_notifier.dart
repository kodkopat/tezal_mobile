import 'package:flutter/material.dart';

import '../../data/repositories/customer_category_repository.dart';

class CategoryNotifier extends ChangeNotifier {
  static CategoryNotifier? _instance;

  factory CategoryNotifier(
    CustomerCategoryRepository customerCategoryRepo,
  ) {
    if (_instance == null) {
      _instance = CategoryNotifier._privateConstructor(customerCategoryRepo);
    }

    return _instance!;
  }

  CategoryNotifier._privateConstructor(this.customerCategoryRepo);

  final CustomerCategoryRepository customerCategoryRepo;
}
