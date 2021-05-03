import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/market/wallet_detail_result_model.dart';
import 'widgets/../transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({required this.walletDetails});

  final List<WalletDetail> walletDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: walletDetails.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return TransactionListItem(
          walletDetail: walletDetails[index],
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
