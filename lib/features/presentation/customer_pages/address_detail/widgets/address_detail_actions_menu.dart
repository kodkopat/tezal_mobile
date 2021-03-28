import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'address_detail_actions_menu_item.dart';

class AddressDetailActionsMenu extends StatelessWidget {
  const AddressDetailActionsMenu({
    Key key,
    @required this.onSetDefault,
    @required this.onEdit,
    @required this.onRemove,
  }) : super(key: key);

  final void Function() onSetDefault;
  final void Function() onEdit;
  final void Function() onRemove;

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
            onTap: onSetDefault,
          ),
          AddressDetailActionsMenuItem(
            text: "ویرایش اطلاعات آدرس",
            iconData: Feather.edit_3,
            onTap: onEdit,
          ),
          AddressDetailActionsMenuItem(
            text: "حذف آدرس",
            iconData: Feather.trash_2,
            color: Colors.red,
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}
