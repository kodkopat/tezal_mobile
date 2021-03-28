import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../data/models/addresses_result_model.dart';

class AddressListItem extends StatelessWidget {
  const AddressListItem({
    Key key,
    @required this.address,
    @required this.onTap,
  }) : super(key: key);

  final Address address;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
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
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 16,
          ),
          _fieldAddress,
        ],
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
