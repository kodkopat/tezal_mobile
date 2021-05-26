// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../data/models/customer/address_model.dart';
import '../../../customer_providers/addresses_notifier.dart';

class AddressSelectorListItem extends StatelessWidget {
  const AddressSelectorListItem({
    required this.address,
    required this.onTap,
    required this.addressNotifier,
  });

  final Address address;
  final void Function() onTap;
  final AddressesNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..padding(horizontal: 16, vertical: 16)
        ..ripple(true),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${address.name}",
                style: AppTxtStyles().body..bold(),
              ),
              Icon(
                _isItemSelected
                    ? Icons.radio_button_on_rounded
                    : Icons.radio_button_off_rounded,
                color:
                    _isItemSelected ? AppTheme.customerPrimary : Colors.black,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: 8),
          _fieldAddress,
        ],
      ),
    );
  }

  bool get _isItemSelected {
    return addressNotifier.selectedOrderAddressId == null
        ? address.isDefault
            ? true
            : false
        : addressNotifier.selectedOrderAddressId == address.id
            ? true
            : false;
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
