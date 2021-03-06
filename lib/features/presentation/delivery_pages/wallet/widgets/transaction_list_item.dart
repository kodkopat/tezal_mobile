// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/languages/language.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/wallet_detail_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({required this.walletDetail});

  final WalletDetail walletDetail;

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
              _fieldTransactionType(context),
              _fieldTransactionDate(context),
            ],
          ),
          _fieldTransactionPriceText,
        ],
      ),
    );
  }

  Widget _fieldTransactionType(BuildContext context) {
    return CustomRichText(
      title: Lang.of(context).transactionType + ": ",
      text: "${walletDetail.walletActionType}",
    );
  }

  Widget _fieldTransactionDate(BuildContext context) {
    return CustomRichText(
      title: Lang.of(context).transactionDate + ": ",
      text: _generateTransactionDateText(),
    );
  }

  String _generateTransactionDateText() {
    return DateTime.parse(walletDetail.createDate)
        .toIso8601String()
        .split("T")[0]
        .replaceAll("-", "/");
  }

  Widget get _fieldTransactionPriceText {
    return Txt(
      _generateTransactionPriceText(),
      style: AppTxtStyles().subHeading
        ..textColor(
            "${walletDetail.amount}".contains("-") ? Colors.red : Colors.green)
        ..bold(),
    );
  }

  String _generateTransactionPriceText() {
    String priceTxt;
    if (walletDetail.amount == null) {
      priceTxt = " ???????????? ";
    } else {
      var temp;
      if ("${walletDetail.amount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(walletDetail.amount);
      } else {
        temp = "${walletDetail.amount}";
      }

      priceTxt = " $temp " + "??????????";
    }

    return priceTxt.replaceAll("-", "");
  }
}
