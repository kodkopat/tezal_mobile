import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/app_theme.dart';
import 'modal_privacy.dart';
import 'modal_rules.dart';

class AgreementText extends StatelessWidget {
  final textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 0.5,
    fontFamily: 'Yekan',
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "با ورود و یا ثبت‌نام در اپلیکیشن تزآل، شما",
            style: textStyle,
          ),
          TextSpan(
            text: " شرایط و قوانین ",
            style: textStyle.copyWith(color: AppTheme.customerPrimary),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onRulesTap(context),
          ),
          TextSpan(
            text: "استفاده از سرویس‌های تزآل و",
            style: textStyle,
          ),
          TextSpan(
            text: " حریم خصوصی ",
            style: textStyle.copyWith(color: AppTheme.customerPrimary),
            recognizer: TapGestureRecognizer()
              ..onTap = () => onPrivacyTap(context),
          ),
          TextSpan(
            text: "آن را می‌پذیرید.",
            style: textStyle,
          ),
        ],
      ),
    );
  }

  void onRulesTap(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => RulesModal(),
    );
  }

  void onPrivacyTap(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => PrivacyModal(),
    );
  }
}
