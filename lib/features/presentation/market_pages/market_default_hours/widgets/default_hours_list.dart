import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/market/market_default_hours_result_model.dart';
import 'default_hours_list_item.dart';

class MarketDefaultHoursList extends StatelessWidget {
  MarketDefaultHoursList({required this.marketDefaultHours});

  final List<MarketDefaultHour> marketDefaultHours;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: marketDefaultHours.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return MarketDefaultHoursListItem(
          marketDefaultHour: marketDefaultHours[index],
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
