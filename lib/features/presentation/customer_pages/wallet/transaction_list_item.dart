// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tezal/features/data/models/wallet_detail_result_model.dart'
    as wallet;
import 'package:tezal/features/presentation/customer_widgets/custom_rich_text.dart';

import '../../../../core/styles/txt_styles.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({required this.walletDetail});

  final wallet.Detail walletDetail;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Row(
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
      ),
    );
  }

  Widget get _fieldTransactionType {
    return CustomRichText(
      title: "نوع تراکنش: ",
      text: "${walletDetail.action}",
    );
  }

  Widget get _fieldTransactionDate {
    return CustomRichText(
      title: "تاریخ تراکنش: ",
      text: _generateTransactionDateText(),
    );
  }

  String _generateTransactionDateText() {
    return walletDetail.date.toString().split(" ")[0].replaceAll("-", "/");
  }

  Widget get _fieldTransactionPriceText {
    return Txt(
      _generateTransactionPriceText(),
      style: AppTxtStyles().subHeading
        ..textColor(
          "${walletDetail.amount}".contains("-") ? Colors.red : Colors.green,
        ),
    );
  }

  String _generateTransactionPriceText() {
    String priceTxt;
    if (walletDetail.amount == null) {
      priceTxt = " نامشخص ";
    } else {
      var temp;
      if ("${walletDetail.amount}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(walletDetail.amount);
      } else {
        temp = "${walletDetail.amount}";
      }

      priceTxt = " $temp " + "تومان";
    }

    return priceTxt.replaceAll("-", "");
  }
}
