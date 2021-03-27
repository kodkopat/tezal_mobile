import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tezal/core/themes/app_theme.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/addresses_result_model.dart';
import '../../../../data/repositories/customer_address_repository.dart';

class AddressListItem extends StatefulWidget {
  const AddressListItem({
    Key key,
    @required this.address,
    @required this.customerAddressRepo,
    @required this.onSetAddressDefault,
    @required this.onRemoveAddress,
    @required this.onEditAddress,
    @required this.onShowAddressDetail,
  }) : super(key: key);

  final Address address;
  final CustomerAddressRepository customerAddressRepo;
  final void Function() onSetAddressDefault;
  final void Function() onRemoveAddress;
  final void Function() onEditAddress;
  final void Function() onShowAddressDetail;

  @override
  _AddressListItemState createState() => _AddressListItemState();
}

class _AddressListItemState extends State<AddressListItem> {
  bool actionsVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()
        ..onTap(() {
          setState(() {
            actionsVisibility = !actionsVisibility;
          });
        }),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 16, vertical: 16)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldName,
                  _fieldAddress,
                ],
              ),
              if (widget.address.isDefault)
                Txt(
                  "آدرس پیش‌فرض",
                  style: AppTxtStyles().footNote
                    ..padding(horizontal: 8, vertical: 4)
                    ..borderRadius(all: 4)
                    ..textColor(AppTheme.customerPrimary)
                    ..background
                        .color(AppTheme.customerPrimary.withOpacity(0.2)),
                ),
            ],
          ),
          if (actionsVisibility)
            Divider(
              color: Colors.black12,
              thickness: 0.5,
              height: 16,
            ),
          if (actionsVisibility)
            Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.address.isDefault)
                  _EditableItem(
                    text: "انتخاب به عنوان پیش‌فرض",
                    iconData: Feather.check_square,
                    color: Colors.black,
                    onTap: widget.onSetAddressDefault,
                  ),
                _EditableItem(
                  text: "جزئیات آدرس",
                  iconData: Feather.file_text,
                  color: Colors.black,
                  onTap: widget.onShowAddressDetail,
                ),
                _EditableItem(
                  text: "ویرایش آدرس",
                  iconData: Feather.edit_3,
                  color: Colors.black,
                  onTap: widget.onEditAddress,
                ),
                _EditableItem(
                  text: "حذف آدرس",
                  iconData: Feather.trash_2,
                  color: Theme.of(context).errorColor,
                  onTap: widget.onRemoveAddress,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget get _fieldName {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: "نام گیرنده" + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text: (widget.address.name == null)
                ? " ذکر نشده "
                : "${widget.address.name}",
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
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
      fontSize: 13,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: "آدرس" + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text: (widget.address.address == null)
                ? " ذکر نشده "
                : "${widget.address.address}",
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableItem extends StatelessWidget {
  const _EditableItem({
    Key key,
    @required this.text,
    @required this.iconData,
    @required this.color,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(36)
        ..borderRadius(all: 4)
        ..ripple(true),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 4),
          Icon(
            iconData,
            color: color,
            size: 18,
          ),
          SizedBox(width: 8),
          Txt(
            text,
            style: AppTxtStyles().body..textColor(color),
          ),
        ],
      ),
    );
  }
}
