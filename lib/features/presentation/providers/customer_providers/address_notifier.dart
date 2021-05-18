import 'package:flutter/material.dart';

import '../../../data/models/customer/address_result_model.dart';
import '../../../data/repositories/customer_address_repository.dart';

class AddressNotifier extends ChangeNotifier {
  AddressNotifier(this.customerAddressRepo);

  final CustomerAddressRepository customerAddressRepo;

  bool detailLoading = true;
  String? detailErrorMsg;
  AddressResultModel? addressResultModel;

  Future<void> fetchDetail({required String addressId}) async {
    var result = await customerAddressRepo.getAddress(
      addressId: addressId,
    );

    result.fold(
      (left) => detailErrorMsg = left.message,
      (right) => addressResultModel = right,
    );

    detailLoading = false;
    notifyListeners();
  }
}
