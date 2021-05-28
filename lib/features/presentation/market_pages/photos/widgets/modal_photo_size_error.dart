// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class PhotoSizeErrorModal extends StatelessWidget {
  PhotoSizeErrorModal({required this.onTryAgainBtnTap});

  final VoidCallback onTryAgainBtnTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..height(224)
        ..alignment.center(true)
        ..margin(horizontal: 16)
        ..borderRadius(all: 12)
        ..border(
          style: BorderStyle.solid,
          color: Theme.of(context).dividerColor,
          all: 1,
        )
        ..background.color(Theme.of(context).cardColor)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  "خطای اندازه تصویر!",
                  style: AppTxtStyles().subHeading
                    ..height(48)
                    ..alignmentContent.centerRight()
                    ..margin(right: 16)
                    ..bold(),
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
              indent: 16,
              endIndent: 16,
              height: 0,
            ),
            SizedBox(height: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    "اندازه تصویر انتخاب شده بیش‌تر از حد مجاز است، "
                    "لطفا تصویر دیگری انتخاب کنید.",
                    style: AppTxtStyles().body
                      ..textAlign.right()
                      ..alignment.centerRight()
                      ..padding(horizontal: 16),
                  ),
                  Parent(
                    gesture: Gestures()..onTap(onTryAgainBtnTap),
                    style: ParentStyle()
                      ..height(48)
                      ..alignment.center(true)
                      ..margin(horizontal: 16, bottom: 16)
                      ..alignmentContent.center(true)
                      ..borderRadius(all: 8)
                      ..background.color(Theme.of(context).primaryColor)
                      ..ripple(true),
                    child: Txt(
                      "تلاش مجدد",
                      style: AppTxtStyles().subHeading..textColor(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
