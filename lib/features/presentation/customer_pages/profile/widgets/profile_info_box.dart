// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/customer_profile_result_model.dart';

class ProfileInfoBox extends StatelessWidget {
  const ProfileInfoBox({
    required this.profileInfo,
    required this.onEditBtnTap,
  });

  final CustomerProfileResultModel profileInfo;
  final void Function() onEditBtnTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(horizontal: 16, top: 16, bottom: 8)
        ..padding(horizontal: 8, top: 8, bottom: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Parent(
                    style: ParentStyle()
                      ..width(48)
                      ..height(48)
                      ..borderRadius(all: 8)
                      ..alignmentContent.center()
                      ..background.color(Color(0xffEFEFEF)),
                    child: Image.asset(
                      "assets/images/ic_user.png",
                      fit: BoxFit.contain,
                      color: Colors.black,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(width: 8),
                  Txt(
                    "${profileInfo.data!.name}",
                    style: AppTxtStyles().subHeading..bold(),
                  ),
                ],
              ),
              Parent(
                gesture: Gestures()..onTap(onEditBtnTap),
                style: ParentStyle()
                  ..width(48)
                  ..height(48)
                  ..borderRadius(all: 24)
                  ..alignmentContent.center()
                  ..ripple(true),
                child: Image.asset(
                  "assets/images/ic_edit.png",
                  fit: BoxFit.contain,
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 16,
          ),
          _fieldPhone,
          _fieldEmail,
        ],
      ),
    );
  }

  Widget get _fieldEmail => richText(
        title: "ایمیل",
        text: " ${profileInfo.data!.email} ",
      );

  Widget get _fieldPhone => richText(
        title: "شماره تماس",
        text: _generatePhoneText(),
      );

  String _generatePhoneText() {
    var phoneText;
    if (profileInfo.data!.phone == null) {
      phoneText = " ناموجود ";
    } else {
      phoneText = " ${profileInfo.data!.phone} ";
    }

    return phoneText;
  }

  Widget richText({
    required String title,
    required String text,
  }) {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: title + ":",
            style: textStyle,
          ),
          TextSpan(
            text: text,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
