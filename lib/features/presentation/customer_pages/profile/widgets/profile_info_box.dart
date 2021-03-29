import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer_profile_result_model.dart';

class ProfileInfoBox extends StatelessWidget {
  const ProfileInfoBox({
    Key key,
    @required this.profileInfo,
  }) : super(key: key);

  final CustomerProfileResultModel profileInfo;

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
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..width(36)
                      ..height(36)
                      ..borderRadius(all: 8)
                      ..background.color(Color(0xffEFEFEF)),
                    child: Icon(
                      Feather.user,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Txt(
                    "${profileInfo.data.name}",
                    style: AppTxtStyles().subHeading..bold(),
                  ),
                ],
              ),
              Parent(
                gesture: Gestures()..onTap(() {}),
                style: ParentStyle()
                  ..width(36)
                  ..height(36)
                  ..borderRadius(all: 18)
                  ..ripple(true),
                child: Icon(
                  Feather.edit_2,
                  color: Colors.black,
                  size: 18,
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

  // Widget get _futureImgFile {
  //   return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
  //     future: repository.photo(marketId: market.id),
  //     successBuilder: (context, data) {
  //       return data.fold(
  //         (l) => SizedBox(),
  //         (r) => Image.memory(
  //           base64Decode(r.data.photos.first),
  //         ),
  //       );
  //     },
  //     errorBuilder: (context, data) => SizedBox(),
  //   );
  // }

  Widget get _fieldEmail => richText(
        title: "ایمیل",
        text: " ${profileInfo.data.email} ",
      );

  Widget get _fieldPhone => richText(
        title: "شماره تماس",
        text: _generatePhoneText(),
      );

  String _generatePhoneText() {
    var phoneText;
    if (profileInfo.data.phone == null) {
      phoneText = " ناموجود ";
    } else {
      phoneText = " ${profileInfo.data.phone} ";
    }

    return phoneText;
  }

  Widget richText({
    @required String title,
    @required String text,
  }) {
    var textStyle = TextStyle(
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
