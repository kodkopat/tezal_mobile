import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/search_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../../../data/repositories/customer_search_repository.dart';
import 'widgets/search_box.dart';
import 'widgets/search_result_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchRepo = CustomerSearchRepository();
  final marketRepo = CustomerMarketRepository();

  final searchCtrl = TextEditingController();
  var onSearchTap;

  List<Market> markets = [];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "جستجو"),
        body: loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : Column(
                children: [
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
                          print("r: $r\n");

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
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 0.5,
                    height: 0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SearchResultList(
                        repository: marketRepo,
                        markets: markets,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
