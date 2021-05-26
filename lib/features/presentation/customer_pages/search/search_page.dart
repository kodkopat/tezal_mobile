// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/search_notifier.dart';
import 'widgets/search_box.dart';
import 'widgets/search_market_list.dart';

class SearchPage extends StatelessWidget {
  static const route = "/customer_search";

  final searchCtrl = TextEditingController();
  late final BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    basketNotifier = Provider.of<BasketNotifier>(context, listen: false);

    var searchTermsConsumer = Consumer<SearchNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchSearchTermsCalled) {
          provider.fetchSearchTerms();
        }

        return SearchBox(
          controller: searchCtrl,
          terms: provider.searchTerms,
          onSearchTap: () async {
            if (searchCtrl.text.trim().isNotEmpty) {
              await provider.search(context, term: searchCtrl.text);
            }
          },
          onClearSearchTermsTap: () async {
            await provider.clearSearchTerms();
          },
        );
      },
    );

    var searchConsumer = Consumer<SearchNotifier>(
      builder: (context, provider, child) {
        return provider.searchResultList == null
            ? provider.searchErrorMsg == null
                ? Txt(
                    "نام محصول مورد نظر خود را جستجو کنید",
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : Txt(
                    provider.searchErrorMsg,
                    style: AppTxtStyles().body..alignment.center(),
                  )
            : Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 48),
                  child: SearchMarketList(
                    markets: provider.searchResultList!,
                    basketNotifier: basketNotifier,
                  ),
                ),
              );
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar(context).create(
          text: Lang.of(context).searchPage,
          showBasketBtn: true,
        ),
        body: Stack(
          textDirection: TextDirection.rtl,
          children: [
            searchConsumer,
            searchTermsConsumer,
          ],
        ),
      ),
    );
  }
}
