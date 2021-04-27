// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';

class ContactListItem extends StatefulWidget {
  ContactListItem({
    required this.contact,
    required this.iconPath,
    required this.onTap,
  });

  final Contact contact;
  final String iconPath;
  final void Function() onTap;

  @override
  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem>
    with AutomaticKeepAliveClientMixin<ContactListItem> {
  bool checked = false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()
        ..onTap(() {
          widget.onTap();
          setState(() {
            checked = !checked;
          });
        }),
      style: ParentStyle()
        ..padding(horizontal: 16, vertical: 8)
        ..ripple(true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      widget.contact.displayName,
                      style: AppTxtStyles().body
                        ..textAlign.start()
                        ..textColor(Colors.black)
                        ..textOverflow(TextOverflow.fade)
                        ..maxLines(3),
                    ),
                    Txt(
                      "${widget.contact.phones.first.number}",
                      style: AppTxtStyles().footNote
                        ..textAlign.start()
                        ..textColor(Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            checked
                ? "assets/images/ic_check_mark_filled.png"
                : "assets/images/ic_check_mark_empty.png",
            fit: BoxFit.contain,
            color: checked ? AppTheme.customerAccent : Colors.black,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
