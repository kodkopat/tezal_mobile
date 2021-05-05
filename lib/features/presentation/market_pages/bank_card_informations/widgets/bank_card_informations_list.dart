import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import 'bank_card_informations_list_item.dart';

class BankCardInformationsList extends StatelessWidget {
  BankCardInformationsList({required this.texts});

  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: texts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BankCardInformationsListItem(text: texts[index]);
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
