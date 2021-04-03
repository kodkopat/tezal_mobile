import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sailor/sailor.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../providers/customer_providers/address_notifier.dart';
import '../../address_save/address_save_page.dart';
import 'address_detail_actions_menu_item.dart';
import 'modal_remove_address.dart';

class AddressDetailActionsMenu extends StatelessWidget {
  const AddressDetailActionsMenu({
    @required this.addressId,
    @required this.addressNotifier,
  });

  final String addressId;
  final AddressNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddressDetailActionsMenuItem(
            text: "تنظیم بعنوان پیش‌فرض",
            iconData: Feather.check_square,
            onTap: () async {
              await addressNotifier.setAddressDefault(addressId: addressId);
              Routes.sailor.pop();
            },
          ),
          AddressDetailActionsMenuItem(
            text: "ویرایش اطلاعات آدرس",
            iconData: Feather.edit_3,
            onTap: () {
              Routes.sailor.navigate(
                AddressSavePage.route,
                navigationType: NavigationType.pushReplace,
                params: {
                  "id": null,
                  "name": null,
                  "address": null,
                  "description": null,
                },
              );
            },
          ),
          AddressDetailActionsMenuItem(
            text: "حذف آدرس",
            iconData: Feather.trash_2,
            color: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                useSafeArea: true,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.2),
                builder: (context) {
                  return RemoveAddressModal(
                    onAccept: () async {
                      await addressNotifier.removeAddress(addressId: addressId);
                      Routes.sailor.pop();
                      Routes.sailor.pop();
                    },
                    onDiscard: () {
                      Routes.sailor.pop();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
