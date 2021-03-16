import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/ProductItemModel.dart';
import '../../models/Customer/SearchProductModel.dart';
import '../../services/AlertService.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import '../../services/RouteBuilderService.dart';
import '../LoginPage.dart';
import 'ProductDetail.dart';
import 'widgets/ProductItemWidget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> tags = [];
  String term;
  bool search = false;
  SearchProductModel oldData;
  Future<SearchProductModel> searchProduct(String term) async {
    var headers = await AuthService.getDefaultHeadersNoLocation();

    var adres = DataService.customerBaseaddress + 'search/search?term=$term';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      oldData = SearchProductModel.fromJson(json.decode(res.body));
      return oldData;
    }
    return null;
  }

  Future<List<String>> getHistory() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    List<String> veri = [];
    var adres = DataService.customerBaseaddress + 'search/GetSearchTerms';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data["success"].toString().toLowerCase() == 'true') {
        for (var item in data["data"]) {
          veri.add(item);
        }
      }
    }
    return veri;
  }

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchRow(term),
        if (!search)
          FutureBuilder(
              future: getHistory(),
              builder: (context, AsyncSnapshot<List<String>> res) {
                if (res.connectionState == ConnectionState.done) {
                  return res.data.length > 0
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(Lang(context).searchHistory),
                                  Spacer(),
                                  InkWell(
                                      onTap: () async {
                                        var headers = await AuthService
                                            .getDefaultHeadersNoLocation();

                                        var adres =
                                            DataService.customerBaseaddress +
                                                'search/ClearSearchTerms';
                                        var res = await http.get(
                                            Uri.http(
                                                DataService.authority, adres),
                                            headers: headers);

                                        if (res.statusCode == 200) {
                                          setState(() {
                                            tags = [];
                                          });
                                        }
                                      },
                                      child: Text(
                                        Lang(context).clear,
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ))
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(res.data.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        controller.text = res.data[index];
                                        term = res.data[index];
                                        search = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade400)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(res.data[index]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        )
                      : Container();
                } else {
                  return CircularProgressIndicator();
                }
              }),
        if (search)
          FutureBuilder(
              future: searchProduct(term),
              builder: (context, AsyncSnapshot<SearchProductModel> res) {
                if (res.connectionState == ConnectionState.done) {
                  return buildList(res.data.data.markets, false);
                }
                if (res.connectionState == ConnectionState.waiting &&
                    oldData != null) {
                  return buildList(oldData.data.markets, true);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
      ],
    );
  }

  Widget buildList(List<Market> markets, bool loading) {
    return Expanded(
        child: Stack(
      children: [
        SingleChildScrollView(
          child: prductLists(markets),
        ),
        if (loading)
          Positioned.fill(
            child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: FlatColors.green_light.withOpacity(0.2)),
          )
      ],
    ));
  }

  Column searchHistory(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(Lang(context).searchHistory),
              Spacer(),
              InkWell(
                  onTap: () async {
                    var headers =
                        await AuthService.getDefaultHeadersNoLocation();

                    var adres = DataService.customerBaseaddress +
                        'search/ClearSearchTerms';
                    var res = await http.get(
                        Uri.http(DataService.authority, adres),
                        headers: headers);

                    if (res.statusCode == 200) {
                      setState(() {
                        tags = [];
                      });
                    }
                  },
                  child: Text(
                    Lang(context).clear,
                    style: TextStyle(color: Colors.grey.shade700),
                  ))
            ],
          ),
        ),
        Row(
          children: List.generate(tags.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    controller.text = tags[index];
                    term = tags[index];
                    search = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(tags[index]),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Container searchRow(String tag) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Expanded(
                      child: TextField(
                    controller: controller,
                    onSubmitted: (val) {
                      setState(() {
                        term = val;
                        search = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: Lang(context).typeProductName,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget prductLists(List<Market> markets) {
    return SingleChildScrollView(
      child: Column(
        children:
            List.generate(markets.length, (index) => products(markets[index])),
      ),
    );
  }

  Widget products(Market markets) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          markets.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.75,
        children: List.generate(markets.products.length, (index) {
          return ProductItemWidget(
            context: context,
            product:
                ProductItemModel.fromJson(markets.products[index].toJson()),
            axis: Axis.vertical,
            onTap: () async {
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (_) => ProductDetail(markets.products[index].id)),
              )
                  //.then((val) => setState(() {}))
                  ;
            },
            onlike: () async {
              if (!await AuthService.mustLogin(context)) return;
              var headers = await AuthService.getDefaultHeadersNoLocation();

              var adres = DataService.customerBaseaddress +
                  (markets.products[index].liked
                      ? 'product/unlike?Id='
                      : 'product/like?Id=') +
                  markets.products[index].id;
              var res = await http.get(Uri.http(DataService.authority, adres),
                  headers: headers);
              if (res.statusCode == 200) {
                setState(() {});
              } else {
                AlertService.showError(
                    context, Lang(context).error, Lang(context).errorOccurred,
                    () {
                  Navigator.pop(context);
                });
              }
            },
            onAdd: () async {
              var headers = await AuthService.getDefaultHeadersNoLocation();
              var body = jsonEncode(<String, String>{
                'Id': markets.products[index].id,
                'Amount': '1'
              });
              var isloggedin = await AuthService.isLoggedIn();
              if (isloggedin) {
                var adres = DataService.customerBaseaddress +
                    'basket/AddProductToBasket';
                var res = await http.post(
                    Uri.http(DataService.authority, adres),
                    headers: headers,
                    body: body);
                if (res.statusCode == 200) {
                  setState(() {});
                } else {
                  AlertService.showError(
                      context, Lang(context).error, Lang(context).errorOccurred,
                      () {
                    Navigator.pop(context);
                  });
                }
              } else {
                Navigator.push(
                    context, RouteBuilderService.goto(LoginPagePage()));
              }
            },
            onRemove: () async {
              var headers = await AuthService.getDefaultHeadersNoLocation();
              var body = jsonEncode(<String, String>{
                'Id': markets.products[index].id,
                'Amount': '1'
              });
              var isloggedin = await AuthService.isLoggedIn();
              if (isloggedin) {
                var adres = DataService.customerBaseaddress +
                    'basket/RemoveProductFromBasket';
                var res = await http.post(
                    Uri.http(DataService.authority, adres),
                    headers: headers,
                    body: body);
                if (res.statusCode == 200) {
                  setState(() {});
                } else {
                  AlertService.showError(
                      context, Lang(context).error, Lang(context).errorOccurred,
                      () {
                    Navigator.pop(context);
                  });
                }
              } else {
                Navigator.push(
                    context, RouteBuilderService.goto(LoginPagePage()));
              }
            },
          );
        }),
      )
    ]);
  }
}
