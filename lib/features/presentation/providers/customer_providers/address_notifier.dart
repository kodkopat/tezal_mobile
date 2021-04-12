import 'package:flutter/material.dart';

import '../../../data/models/address_result_model.dart' hide Address;
import '../../../data/models/addresses_result_model.dart';
import '../../../data/models/cities_result_model.dart';
import '../../../data/models/provinces_result_model.dart';
import '../../../data/repositories/customer_address_repository.dart';

class AddressNotifier extends ChangeNotifier {
  static AddressNotifier? _instance;

  factory AddressNotifier(
    CustomerAddressRepository customerAddressRepo,
  ) {
    if (_instance == null) {
      _instance = AddressNotifier._privateConstructor(
        customerAddressRepo: customerAddressRepo,
      );
    }

    return _instance!;
  }

  AddressNotifier._privateConstructor({
    required this.customerAddressRepo,
  });

  final CustomerAddressRepository customerAddressRepo;

  String? selectedOrderAddressId;

  bool listLoading = true;
  String? listErrorMsg;

  bool detailLoading = true;
  String? detailErrorMsg;

  AddressesResultModel? addressesResultModel;
  List<Address>? addressList;
  AddressResultModel? addressResultModel;

  Future<List<Province>> provinces() async {
    var result = await customerAddressRepo.provinces;
    return result.fold(
      (left) => [],
      (right) => right.data,
    );
  }

  Future<List<City>> cities(String provinceId) async {
    var result = await customerAddressRepo.cities(provinceId: provinceId);
    return result.fold(
      (left) => [],
      (right) => right.data,
    );
  }

  Future<void> fetchAddresses() async {
    var result = await customerAddressRepo.addresses;
    result.fold(
      (left) {
        listErrorMsg = left.message;
      },
      (right) {
        addressesResultModel = right;
        addressList = addressesResultModel!.data;
        addressList!.forEach((e) {
          if (e.isDefault) {
            selectedOrderAddressId = e.id;
          }
        });
      },
    );
    listLoading = false;
    notifyListeners();
  }

  Future<void> fetchDetail({required String addressId}) async {
    var result = await customerAddressRepo.addressDetails(
      addressId: addressId,
    );
    result.fold(
      (left) {
        detailErrorMsg = left.message;
      },
      (right) {
        addressResultModel = right;
      },
    );
    detailLoading = false;
    notifyListeners();
  }

  Future<void> addAddress({
    var latitude,
    var longitude,
    var address,
    var description,
    var isDefault,
    var cityId,
    var name,
  }) async {
    var result = await customerAddressRepo.saveAddress(
      latitude: latitude,
      longitude: longitude,
      address: address,
      description: description,
      isDefault: isDefault,
      cityId: cityId,
      name: name,
    );
    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> removeAddress({required String addressId}) async {
    var result = await customerAddressRepo.removeAddress(
      addressId: addressId,
    );
    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> editAddress({
    var id,
    var latitude,
    var longitude,
    var address,
    var description,
    var isDefault,
    var cityId,
    var name,
  }) async {
    var result = await customerAddressRepo.editAddress(
      id: id,
      latitude: latitude,
      longitude: longitude,
      address: address,
      description: description,
      isDefault: isDefault,
      cityId: cityId,
      name: name,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> setAddressDefault({required String addressId}) async {
    var result = await customerAddressRepo.setDefaultAddress(
      addressId: addressId,
    );
    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  void notify() async {
    notifyListeners();
  }

  void refresh() async {
    await fetchAddresses();
  }
}
