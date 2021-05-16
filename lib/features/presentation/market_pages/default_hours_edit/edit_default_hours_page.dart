// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../data/models/market/market_default_hours_result_model.dart';
import '../../../data/models/market/update_market_default_hours_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/default_hours_notifier.dart';
import 'widgets/edit_default_hours_list.dart';

class EditDefaultHoursPage extends StatefulWidget {
  static const route = "/market_edit_default_hours";

  EditDefaultHoursPage({required this.marketDefaultHours});

  final MarketDefaultHoursResultModel marketDefaultHours;

  @override
  _EditDefaultHoursPageState createState() => _EditDefaultHoursPageState();
}

class _EditDefaultHoursPageState extends State<EditDefaultHoursPage> {
  late List<UpdateMarketDefaultHoursModel> updateMarketDefaultHours;

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();

    updateMarketDefaultHours = [];
    for (int i = 1; i < 8; i++) {
      updateMarketDefaultHours.add(
        UpdateMarketDefaultHoursModel(
          dayOfWeek: i,
          startHour: 0,
          startMinute: 0,
          endHour: 0,
          endMinute: 0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).workingTimesPageEdit,
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            EditMarketDefaultHoursList(
              updateMarketDefaultHours: updateMarketDefaultHours,
              onItemChange: (index, value) {
                setState(() {
                  updateMarketDefaultHours[index] = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ActionBtn(
              text: Lang.of(context).submit,
              onTap: () async {
                var profileNotifier =
                    Provider.of<DefaultHoursNotifier>(context, listen: false);

                // updateMarketDefaultHours.forEach((element) {
                //   print("${element.toJson()}\n");
                // });

                await profileNotifier.updateDefaultHours(
                  context,
                  defaultHours: updateMarketDefaultHours,
                );

                if (profileNotifier.updateDefaultHoursErrorMsg != null) {
                  setState(() {
                    errorTxt = profileNotifier.updateDefaultHoursErrorMsg!;
                    errorVisibility = true;
                  });
                } else {
                  profileNotifier.refreshDefaultHours();
                  Routes.sailor.pop();
                }
              },
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: errorVisibility,
              child: Txt(
                errorTxt,
                style: AppTxtStyles().footNote.clone()
                  ..textColor(Theme.of(context).errorColor)
                  ..alignmentContent.center()
                  ..height(24)
                  ..borderRadius(all: 2)
                  ..padding(horizontal: 4)
                  ..ripple(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
