import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/search_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../../../data/repositories/customer_search_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/search_box.dart';
import 'widgets/search_market_list.dart';

class SearchPage extends StatefulWidget {
  static const route = "/customer_search";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchRepo = CustomerSearchRepository();
  final marketRepo = CustomerMarketRepository();

  final searchCtrl = TextEditingController();
  var onSearchTap;

  List<Market> markets = [];
  List<String> searchTerms = [];

  bool loading = true;

  void initializeState() async {
    var result = await searchRepo.searchTerms(context);
    result.fold(
      (l) => null,
      (r) {
        searchTerms = r.data;
      },
    );

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar().create(
          context,
          text: "جستجو",
          showBasketBtn: true,
        ),
        body: loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : Stack(
                textDirection: TextDirection.rtl,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 48),
                      child: SearchMarketList(markets: markets),
                    ),
                  ),
                  SearchBox(
                    controller: searchCtrl,
                    onSearchTap: () async {
                      if (searchCtrl.text.trim().isEmpty) {
                        return;
                      }

                      var result = await searchRepo.search(
                        context,
                        term: searchCtrl.text,
                      );

                      result.fold(
                        (l) => null,
                        (r) {
                          if (markets != null) {
                            markets.clear();
                            markets.addAll(r.data.markets);
                          } else {
                            markets = r.data.markets;
                          }

                          setState(() {});
                        },
                      );
                    },
                    terms: searchTerms,
                  ),
                ],
              ),
      ),
    );
  }
}
