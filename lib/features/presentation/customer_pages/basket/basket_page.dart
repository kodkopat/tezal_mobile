// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/basket_notifier.dart';
import 'widgets/basket_actions_box.dart';
import 'widgets/basket_list.dart';

class BasketPage extends StatelessWidget {
  static const route = "/customer_basket";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<BasketNotifier>(
      builder: (context, provider, child) {
        if (provider.basketItemList == null) {
          provider.fetchBasket();
        }

        return provider.loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.basketItemList == null
                ? provider.errorMsg == null
                    ? Txt(
                        "سبد خرید محصولات شما خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : Txt(
                        "${provider.errorMsg!}",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        BasketList(
                          basketItems: provider.basketItemList!,
                          basketNotifier: provider,
                        ),
                        SizedBox(height: 8),
                        BasketActionsBox(
                          basket: provider.basketResultModel!,
                          basketNotifier: provider,
                        ),
                      ],
                    ),
                  );
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar(context).create(text: "سبد خرید"),
        body: consumer,
      ),
    );
  }
}
