// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/withdrawal_requests_result_model.dart';

class WithdrawalRequestListItem extends StatelessWidget {
  WithdrawalRequestListItem({required this.withdrawalRequest});

  final WithdrawalRequest withdrawalRequest;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Txt(
        "${withdrawalRequest.description}",
        style: AppTxtStyles().body..textAlign.start(),
      )
      /* Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldTransactionType,
              _fieldTransactionDate,
            ],
          ),
          _fieldTransactionPriceText,
        ],
      ) */
      ,
    );
  }

  // Widget get _fieldTransactionType {
  //   return CustomRichText(
  //     title: "نوع تراکنش: ",
  //     text: "${withdrawalRequest.walletActionType}",
  //   );
  // }

  // Widget get _fieldTransactionDate {
  //   return CustomRichText(
  //     title: "تاریخ تراکنش: ",
  //     text: _generateTransactionDateText(),
  //   );
  // }

  // String _generateTransactionDateText() {
  //   return DateTime.parse(withdrawalRequest.createDate)
  //       .toIso8601String()
  //       .split("T")[0]
  //       .replaceAll("-", "/");
  // }

  // Widget get _fieldTransactionPriceText {
  //   return Txt(
  //     _generateTransactionPriceText(),
  //     style: AppTxtStyles().subHeading
  //       ..textColor("${withdrawalRequest.amount}".contains("-")
  //           ? Colors.red
  //           : Colors.green)
  //       ..bold(),
  //   );
  // }

  // String _generateTransactionPriceText() {
  //   String priceTxt;
  //   if (withdrawalRequest.amount == null) {
  //     priceTxt = " نامشخص ";
  //   } else {
  //     var temp;
  //     if ("${withdrawalRequest.amount}".length >= 3) {
  //       temp = intl.NumberFormat("#,000").format(withdrawalRequest.amount);
  //     } else {
  //       temp = "${withdrawalRequest.amount}";
  //     }

  //     priceTxt = " $temp " + "تومان";
  //   }

  //   return priceTxt.replaceAll("-", "");
  // }
}
