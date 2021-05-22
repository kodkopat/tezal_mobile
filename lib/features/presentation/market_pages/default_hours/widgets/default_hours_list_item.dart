// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../app_localizations.dart';
import '../../../../../core/languages/language.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/market_default_hours_result_model.dart';

class MarketDefaultHoursListItem extends StatelessWidget {
  MarketDefaultHoursListItem({required this.marketDefaultHour});

  final MarketDefaultHour marketDefaultHour;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Parent(
                style: ParentStyle()
                  ..height(48)
                  ..alignmentContent.center()
                  ..background.color(Theme.of(context).primaryColor),
                child: Txt(
                  _generateWeekdayText(context),
                  style: AppTxtStyles().body
                    ..textColor(Colors.white)
                    ..bold(),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    Lang.of(context).from +
                        " " +
                        "${marketDefaultHour.startHour}:${marketDefaultHour.startMinute}",
                    style: AppTxtStyles().body..textAlign.start(),
                  ),
                  SizedBox(width: 8),
                  Txt(
                    Lang.of(context).to +
                        " " +
                        "${marketDefaultHour.endHour}:${marketDefaultHour.endMinute}",
                    style: AppTxtStyles().body..textAlign.start(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generateWeekdayText(BuildContext context) {
    String? countryCode = AppLocalizations.of(context)!.locale.countryCode;

    return countryCode!.toLowerCase() == "fa"
        ? MarketDefaultHour.persianWeekdays["${marketDefaultHour.dayOfWeek}"]!
        : MarketDefaultHour.englishWeekdays["${marketDefaultHour.dayOfWeek}"]!;
  }
}
