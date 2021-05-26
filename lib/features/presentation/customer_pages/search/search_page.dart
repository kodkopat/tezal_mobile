// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/search_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/search_box.dart';
import 'widgets/search_drop_down_direction.dart';
import 'widgets/search_drop_down_sort.dart';
import 'widgets/search_market_list.dart';

class SearchPage extends StatelessWidget {
  static const route = "/customer_search";

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var basketNotifier = Provider.of<BasketNotifier>(context, listen: false);

    var consumer = Consumer<SearchNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchSearchTermsCalled) {
          provider.fetchSearchTerms();
        }

        return Stack(
          children: [
            provider.searchResultList == null
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
                      padding: EdgeInsets.only(top: 98),
                      child: SearchMarketList(
                        markets: provider.searchResultList!,
                        basketNotifier: basketNotifier,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SearchDropdownSort(
                      labelText: "فیلتر محصولات",
                      textList: provider.sortList,
                      defaultListIndex: provider.sortListIndex,
                      onIndexChanged: (index) {
                        provider.search(
                          context,
                          term: searchCtrl.text,
                          sortListIndex: index,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SearchDropdownDirection(
                      labelText: "ترتیب نمایش",
                      textList: provider.directionList,
                      defaultListIndex: provider.directionListIndex,
                      onIndexChanged: (index) {
                        provider.search(
                          context,
                          term: searchCtrl.text,
                          directionListIndex: index,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SearchBox(
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
            ),
          ],
        );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).searchPage,
        showBasketBtn: true,
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // to close dropdown lists
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: consumer),
    );
  }
}
