// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_rating_bar.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../customer_widgets/simple_app_bar.dart';

class MarketCommentPage extends StatelessWidget {
  static const route = "customer_market_comment";

  MarketCommentPage({required this.marketName});

  final String marketName;

  @override
  Widget build(BuildContext context) {
    var ratingBarTxtCtrl = TextEditingController();
    var commentBoxTxtCtrl = TextEditingController();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "بازخورد فروشگاه",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Parent(
          style: ParentStyle()
            ..margin(vertical: 8)
            ..padding(horizontal: 16, top: 8)
            ..background.color(Colors.white)
            ..borderRadius(all: 8)
            ..boxShadow(
              color: Colors.black12,
              offset: Offset(0, 3.0),
              blur: 6,
              spread: 0,
            ),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Txt(
                marketName,
                style: AppTxtStyles().body..bold(),
              ),
              Divider(
                color: Colors.black12,
                thickness: 0.5,
                height: 16,
              ),
              CustomRatingBar(
                labelText: "امتیاز فروشگاه",
                textCtrl: ratingBarTxtCtrl,
              ),
              SizedBox(height: 4),
              CustomTextInput(
                label: "نظر کاربر",
                controller: commentBoxTxtCtrl,
                validator: AppValidators.comment,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                maxLine: 3,
              ),
              SizedBox(height: 16),
              ActionBtn(
                text: "ثبت بازخورد",
                onTap: () {},
                background: AppTheme.customerPrimary,
                textColor: Colors.white,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
