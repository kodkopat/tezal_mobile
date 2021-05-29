import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/models/customer/customer_profile_result_model.dart';
import '../../data/repositories/customer_repository.dart';

class CustomerProfileNotifier extends ChangeNotifier {
  static CustomerProfileNotifier? _instance;

  factory CustomerProfileNotifier(
    CustomerRepository customerRepo,
  ) {
    if (_instance == null) {
      _instance = CustomerProfileNotifier._privateConstructor(customerRepo);
    }

    return _instance!;
  }

  CustomerProfileNotifier._privateConstructor(this.customerRepo);

  final CustomerRepository customerRepo;

  bool loading = true;
  String? errorMsg;
  CustomerProfileResultModel? customerProfile;

  Future<void> fetchInfo() async {
    var result = await customerRepo.getCustomerProfile();

    result.fold(
      (left) => errorMsg = left.message,
      (right) => customerProfile = right,
    );

    loading = false;
    notifyListeners();
  }

  Future<void> editInfo({
    required String name,
    required String email,
    required File photo,
  }) async {
    var result = await customerRepo.changeCustomerProfile(
      name: name,
      email: email,
      photo: photo,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  void refresh() async {
    await fetchInfo();
  }
}
