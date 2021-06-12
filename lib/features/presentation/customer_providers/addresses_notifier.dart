import 'package:flutter/material.dart';

import '../../data/models/customer/address_model.dart';
import '../../data/models/customer/address_result_model.dart';
import '../../data/models/customer/addresses_result_model.dart';
import '../../data/models/customer/cities_result_model.dart';
import '../../data/models/customer/provinces_result_model.dart';
import '../../data/repositories/customer_address_repository.dart';

class AddressesNotifier extends ChangeNotifier {
  static AddressesNotifier? _instance;

  factory AddressesNotifier(
    CustomerAddressRepository customerAddressRepo,
  ) {
    if (_instance == null) {
      _instance = AddressesNotifier._privateConstructor(customerAddressRepo);
    }

    return _instance!;
  }

  AddressesNotifier._privateConstructor(this.customerAddressRepo);

  final CustomerAddressRepository customerAddressRepo;

  String? _selectedOrderAddressId;

  String? get selectedOrderAddressId => _selectedOrderAddressId;

  set selectedOrderAddressId(String? selectedOrderAddressId) {
    _selectedOrderAddressId = selectedOrderAddressId;
    notifyListeners();
  }

  Future<List<Province>> provinces() async {
    var result = await customerAddressRepo.getProvince();
    return result.fold(
      (left) => [],
      (right) => right.data,
    );
  }

  Future<List<City>> cities(String provinceId) async {
    var result = await customerAddressRepo.getCity(provinceId: provinceId);
    return result.fold(
      (left) => [],
      (right) => right.data,
    );
  }

  Address? defaultAddress;

  bool listLoading = true;
  String? listErrorMsg;

  AddressesResultModel? addressesResultModel;
  List<Address>? addressList;
  AddressResultModel? addressResultModel;

  Future<void> fetchAddresses() async {
    var result = await customerAddressRepo.getAddresses();

    result.fold(
      (left) => listErrorMsg = left.message,
      (right) {
        addressesResultModel = right;
        addressList = addressesResultModel!.data;
        addressList!.forEach((e) {
          if (e.isDefault) {
            defaultAddress = e;
            selectedOrderAddressId = e.id;
          }
        });
      },
    );

    listLoading = false;
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
    var result = await customerAddressRepo.save(
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
      (right) => _refresh(),
    );
  }

  Future<void> removeAddress({required String addressId}) async {
    var result = await customerAddressRepo.removeAddress(
      addressId: addressId,
    );

    result.fold(
      (left) => null,
      (right) {
        if (defaultAddress != null) {
          if (defaultAddress!.id == addressId) {
            defaultAddress = null;
          }
        }

        _refresh();
      },
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
    var result = await customerAddressRepo.edit(
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
      (right) => _refresh(),
    );
  }

  Future<void> setAddressDefault({required String addressId}) async {
    var result = await customerAddressRepo.setDefaultAddress(
      addressId: addressId,
    );

    result.fold(
      (left) => null,
      (right) async {
        await fetchAddresses();
      },
    );
  }

  void _refresh() async {
    selectedOrderAddressId = null;
    defaultAddress = null;
    listLoading = true;
    listErrorMsg = null;
    addressesResultModel = null;
    addressList = null;
    addressResultModel = null;

    await fetchAddresses();
  }
}
