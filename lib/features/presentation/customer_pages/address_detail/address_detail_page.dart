import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/address_result_model.dart';
import '../../../data/models/addresses_result_model.dart' as addresses;
import '../../../data/repositories/customer_address_repository.dart';
import 'widgets/address_detail_actions_menu.dart';
import 'widgets/address_detail_menu.dart';
import 'widgets/modal_remove_address.dart';
import 'widgets/modal_save_address.dart';

class AddressDetailPage extends StatelessWidget {
  static const route = "/customer_address_detail";

  AddressDetailPage({
    Key key,
    @required this.addressId,
  }) : super(key: key);

  final String addressId;
  final _customerAddressRepo = CustomerAddressRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "جزئیات آدرس",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, AddressResultModel>>(
        future: _customerAddressRepo.addressDetails(addressId: addressId),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressDetailMenu(address: r.data),
                Divider(
                  color: Colors.black12,
                  thickness: 0.5,
                  height: 0,
                ),
                AddressDetailActionsMenu(
                  onSetDefault: () => onSetAddressDefault(r.data),
                  onEdit: () => onEditAddress(context, r.data),
                  onRemove: () => onRemoveAddress(context, r.data),
                ),
              ],
            ),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ),
    );
  }

  void onSetAddressDefault(Address address) async {
    final result = await _customerAddressRepo.setDefaultAddress(
      addressId: address.id,
    );

    result.fold(
      (l) => null,
      (r) => null,
    );
  }

  void onRemoveAddress(BuildContext context, Address address) {
    var onAccept = () async {
      var result = await _customerAddressRepo.removeAddress(
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
    ).then((value) {});
  }

  void onEditAddress(BuildContext context, Address address) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) {
        return SaveAddressModal(
          customerAddressRepo: _customerAddressRepo,
          address: addresses.Address(
            id: address.id,
            name: address.name,
            address: address.address,
            isDefault: false,
          ),
        );
      },
    ).then((value) {});
  }
}
