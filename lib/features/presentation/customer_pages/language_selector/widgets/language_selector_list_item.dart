// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';

class LanguageSelectorListItem extends StatelessWidget {
  const LanguageSelectorListItem({
    required this.languageName,
    required this.selected,
    required this.onTap,
  });

  final String languageName;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..padding(horizontal: 16, vertical: 16)
        ..ripple(true),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            languageName,
            style: AppTxtStyles().body..bold(),
          ),
          Icon(
            selected
                ? Icons.radio_button_on_rounded
                : Icons.radio_button_off_rounded,
            color: selected ? AppTheme.customerPrimary : Colors.black,
            size: 24,
          ),
        ],
      ),
    );
  }
}
