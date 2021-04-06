import 'package:flutter/material.dart';

import '../../../data/models/customer_profile_result_model.dart';
import '../../../data/repositories/customer_repository.dart';

class ProfileNotifier extends ChangeNotifier {
  static ProfileNotifier _instance;

  factory ProfileNotifier(
    CustomerRepository customerRepo,
  ) {
    if (_instance == null) {
      _instance = ProfileNotifier._privateConstructor(
        customerRepo: customerRepo,
      );
    }

    return _instance;
  }

  ProfileNotifier._privateConstructor({
    this.customerRepo,
  });

  final CustomerRepository customerRepo;

  bool loading = true;
  String errorMsg;
  CustomerProfileResultModel customerProfile;

  Future<void> fetchInfo() async {
    var result = await customerRepo.customerProfile;

    result.fold(
      (left) => errorMsg = left.message,
      (right) => customerProfile = right,
    );

    loading = false;
    notifyListeners();
  }

  Future<void> editInfo({
    @required String name,
    @required String email,
  }) async {
    var result = await customerRepo.editCustomerProfile(
      name: name,
      email: email,
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
