// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
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
            ? AppLoading()
            : provider.basketItemList == null
                ? provider.errorMsg == null
                    ? _basketErrorState("اشکال در نمایش سبد خرید")
                    : _basketErrorState("${provider.errorMsg!}")
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        BasketList(
                          basketItems: provider.basketItemList!,
                          basketNotifier: provider,
                          onItemAddToBasket: (index) {
                            provider.addToBasket(
                              productId: provider.basketItemList![index].id,
                            );
                          },
                          onItemRemoveFromBasket: (index) {
                            provider.removeFromBasket(
                              productId: provider.basketItemList![index].id,
                            );
                          },
                        ),
                        SizedBox(height: 8),
                        if (provider.basketItemList!.isNotEmpty)
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
        appBar: SimpleAppBar(context).create(
          text: Lang.of(context).basketPage,
        ),
        body: consumer,
      ),
    );
  }

  Widget _basketErrorState(String errorText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Parent(
          style: ParentStyle()
            ..width(80)
            ..alignmentContent.center(),
          child: AspectRatio(
            aspectRatio: 1 / 2,
            child: Image.asset(
              "assets/images/img_tezal_logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        Txt(
          errorText,
          style: AppTxtStyles().footNote..alignment.center(),
        ),
      ],
    );
  }
}
