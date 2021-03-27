import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/addresses_result_model.dart';
import '../../../../data/repositories/customer_address_repository.dart';
import 'adderss_list_item.dart';
import 'modal_remove_address.dart';
import 'modal_save_address.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    Key key,
    @required this.addresses,
    @required this.customerAddressRepo,
    @required this.onActionsComplete,
  }) : super(key: key);

  final List<Address> addresses;
  final CustomerAddressRepository customerAddressRepo;
  final void Function() onActionsComplete;

  @override
  Widget build(BuildContext context) {
    return addresses.isEmpty
        ? _emptyState
        : ListView.builder(
            itemCount: addresses.length,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemBuilder: (context, index) {
              var address = addresses[index];

              return AddressListItem(
                customerAddressRepo: customerAddressRepo,
                address: address,
                onSetAddressDefault: () => onSetAddressDefault(address),
                onRemoveAddress: () => onRemoveAddress(context, address),
                onEditAddress: () => onEditAddress(context, address),
                onShowAddressDetail: () {},
              );
            },
          );
  }

  void onSetAddressDefault(Address address) async {
    final result = await customerAddressRepo.setDefaultAddress(
      addressId: address.id,
    );

    result.fold(
      (l) => null,
      (r) => onActionsComplete(),
    );
  }

  void onRemoveAddress(BuildContext context, Address address) {
    var onAccept = () async {
      var result = await customerAddressRepo.removeAddress(
        addressId: address.id,
      );

      result.fold((l) => null, (r) => Routes.sailor.pop());
    };

    var onDiscard = () {
      Routes.sailor.pop();
    };

    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) {
        return RemoveAddressModal(
          onAccept: onAccept,
          onDiscard: onDiscard,
        );
      },
    ).then((value) => onActionsComplete());
  }

  void onEditAddress(BuildContext context, Address address) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) {
        return SaveAddressModal(
          customerAddressRepo: customerAddressRepo,
          address: address,
        );
      },
    ).then((value) => onActionsComplete());
  }

  Widget get _emptyState => Txt(
        "لیست‌ آدرس‌های شما خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
