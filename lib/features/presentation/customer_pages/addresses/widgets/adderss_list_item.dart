// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../data/models/customer/address_model.dart';
import '../../../customer_providers/addresses_notifier.dart';
import '../../address_detail/widgets/modal_remove_address.dart';
import '../../address_save/address_save_page.dart';

class AddressListItem extends StatelessWidget {
  const AddressListItem({
    required this.address,
    required this.onTap,
    required this.addressNotifier,
  });

  final Address address;
  final VoidCallback onTap;
  final AddressesNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()..margin(vertical: 8),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        confirmDismiss: (dismissDirection) async {
          if (dismissDirection == DismissDirection.startToEnd) {
            var result = await showDialog(
              context: context,
              useSafeArea: true,
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (context) {
                return RemoveAddressModal(
                  onAccept: () async {
                    await addressNotifier.removeAddress(
                      addressId: address.id,
                    );
                    Routes.sailor.pop(true);
                  },
                  onDiscard: () {
                    Routes.sailor.pop(false);
                  },
                );
              },
            );
            return result as bool;
          } else if (dismissDirection == DismissDirection.endToStart) {
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
            return false;
          }
        },
        background: Parent(
          style: ParentStyle()
            ..padding(horizontal: 24)
            ..borderRadius(all: 8)
            ..alignmentContent.centerRight()
            ..background.color(Colors.red),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/ic_delete.png",
                color: Colors.white,
                fit: BoxFit.contain,
                width: 24,
                height: 24,
              ),
              SizedBox(height: 4),
              Txt(
                "حذف آدرس",
                style: AppTxtStyles().footNote..textColor(Colors.white),
              ),
            ],
          ),
        ),
        secondaryBackground: Parent(
          style: ParentStyle()
            ..padding(horizontal: 24)
            ..borderRadius(all: 8)
            ..alignmentContent.centerLeft()
            ..background.color(Color(0xffEFEFEF)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/ic_edit.png",
                color: Colors.black,
                fit: BoxFit.contain,
                width: 24,
                height: 24,
              ),
              SizedBox(height: 4),
              Txt("ویرایش آدرس", style: AppTxtStyles().footNote),
            ],
          ),
        ),
        child: Parent(
          style: ParentStyle()
            ..padding(horizontal: 8, vertical: 8)
            ..borderRadius(all: 8)
            ..background.color(Colors.white)
            ..boxShadow(
              color: Colors.black12,
              offset: Offset(0, 3.0),
              blur: 6,
              spread: 0,
            ),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..width(30)
                      ..height(30)
                      ..alignmentContent.center()
                      ..background.color(
                        address.isDefault
                            ? AppTheme.customerPrimary.withOpacity(0.1)
                            : Color(0xffEFEFEF).withOpacity(0.5),
                      )
                      ..borderRadius(all: 8)
                      ..ripple(true),
                    child: Icon(
                      Feather.map_pin,
                      color: address.isDefault
                          ? AppTheme.customerPrimary
                          : Colors.black,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Txt(
                    "${address.name}",
                    style: AppTxtStyles().body..bold(),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _fieldAddress,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _fieldAddress {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
            text: "آدرس" + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text:
                (address.address == null) ? " ذکر نشده " : "${address.address}",
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
