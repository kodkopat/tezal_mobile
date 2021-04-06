import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tezal/features/data/models/wallet_detail_result_model.dart'
    as wallet;

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({@required this.walletDetail});

  final wallet.Detail walletDetail;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                "${walletDetail.action}",
                style: AppTxtStyles().body,
              ),
              Txt(
                "+${intl.NumberFormat("#,000").format(walletDetail.amount)}",
                style: AppTxtStyles().subHeading
                  ..textColor(AppTheme.customerPrimary)
                  ..textDirection(TextDirection.ltr),
              ),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Txt(
                walletDetail.date.toString().split(" ")[0].replaceAll("-", "/"),
                style: AppTxtStyles().footNote..textColor(Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
