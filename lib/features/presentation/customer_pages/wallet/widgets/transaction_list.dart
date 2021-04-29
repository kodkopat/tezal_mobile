import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/customer/wallet_detail_result_model.dart'
    as wallet;
import 'widgets/../transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({required this.walletDetail});

  final List<wallet.Detail> walletDetail;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: walletDetail.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return TransactionListItem(
          walletDetail: walletDetail[index],
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
