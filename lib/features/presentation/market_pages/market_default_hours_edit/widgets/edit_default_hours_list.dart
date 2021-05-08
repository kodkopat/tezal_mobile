import 'package:flutter/material.dart';

import '../../../../../core/widgets/dashed_line_painter.dart';
import '../../../../data/models/market/update_market_default_hours_model.dart';
import 'edit_default_hours_list_item.dart';

class EditMarketDefaultHoursList extends StatelessWidget {
  EditMarketDefaultHoursList({
    required this.updateMarketDefaultHours,
    required this.onItemChange,
  });

  final List<UpdateMarketDefaultHoursModel> updateMarketDefaultHours;
  final void Function(int, UpdateMarketDefaultHoursModel) onItemChange;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: updateMarketDefaultHours.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return EditMarketDefaultHoursListItem(
          updateMarketDefaultHour: updateMarketDefaultHours[index],
          onChange: (value) => onItemChange(index, value),
        );
      },
      separatorBuilder: (context, index) {
        return CustomPaint(painter: DashedLinePainter());
      },
    );
  }
}
