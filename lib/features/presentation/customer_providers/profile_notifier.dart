import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
    required File? photo,
  }) async {
    var result;
    if (photo == null) {
      result = await customerRepo.changeCustomerProfileWithoutPhoto(
        name: name,
        email: email,
      );
    } else {
      result = await customerRepo.changeCustomerProfile(
        name: name,
        email: email,
        photo: photo,
      );
    }

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Uint8List? profilePhoto;

  Future<void> getPhoto() async {
    var result = await customerRepo.getPhoto();

    result.fold(
      (left) => null,
      (right) {
        try {
          List<int> list = utf8.encode(right);
          Uint8List bytes = Uint8List.fromList(list);

          String outcome = utf8.decode(bytes);
          print("profilePhoto: $bytes\n");

          profilePhoto = base64Decode(outcome);
        } catch (error) {
          print("profilePhotoError: $error\n");
        }
      },
    );

    notifyListeners();
  }

  void refresh() async {
    await fetchInfo();
  }
}
