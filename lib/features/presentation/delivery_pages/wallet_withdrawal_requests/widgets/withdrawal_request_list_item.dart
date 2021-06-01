// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/withdrawal_requests_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class WithdrawalRequestListItem extends StatelessWidget {
  WithdrawalRequestListItem({required this.withdrawalRequest});

  final WithdrawalRequest withdrawalRequest;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldDate(context),
              _fieldDescription(context),
            ],
          ),
          _fieldAmount,
        ],
      ),
    );
  }

  Widget _fieldDescription(BuildContext context) {
    return CustomRichText(
      title: "توضیحات" + ": ",
      text: "${withdrawalRequest.description}",
    );
  }

  Widget _fieldDate(BuildContext context) {
    return CustomRichText(
      title: "تاریخ" + ": ",
      text: _generateDateText(),
    );
  }

  String _generateDateText() {
    return "${withdrawalRequest.createDate}".split(" ")[0];
  }

  Widget get _fieldAmount {
    return Txt(
      _generateAmount(),
      style: AppTxtStyles().subHeading
        ..textColor("${withdrawalRequest.amount}".contains("-")
            ? Colors.red
            : Colors.green)
        ..bold(),
    );
  }

  String _generateAmount() {
    String priceTxt;
    if (withdrawalRequest.amount == null) {
      priceTxt = " نامشخص ";
    } else {
      var temp;
      if ("${withdrawalRequest.amount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(withdrawalRequest.amount);
      } else {
        temp = "${withdrawalRequest.amount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt.replaceAll("-", "");
  }
}
