import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/market/withdrawal_requests_result_model.dart';
import 'withdrawal_request_list_item.dart';

class WithdrawalRequestList extends StatelessWidget {
  WithdrawalRequestList({required this.withdrawalRequests});

  final List<WithdrawalRequest> withdrawalRequests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: withdrawalRequests.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return WithdrawalRequestListItem(
          withdrawalRequest: withdrawalRequests[index],
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
