// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/search_notifier.dart';
import 'widgets/search_box.dart';
import 'widgets/search_market_list.dart';

class SearchPage extends StatelessWidget {
  static const route = "/customer_search";

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchTermsConsumer = Consumer<SearchNotifier>(
      builder: (context, provider, child) {
        if (provider.searchTerms.isEmpty) {
          provider.fetchSearchTerms(context);
        }

        return SearchBox(
          controller: searchCtrl,
          terms: provider.searchTerms,
          onSearchTap: () async {
            if (searchCtrl.text.trim().isNotEmpty) {
              await provider.search(
                context,
                searchCtrl.text,
              );
            }
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
                  ),
                ),
              );
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar(context).create(
          text: "جستجو",
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
