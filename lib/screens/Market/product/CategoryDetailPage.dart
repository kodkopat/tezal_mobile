import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/models/Customer/CategoryDetailModel.dart';
import 'package:tezal/models/Customer/ProductItemModel.dart';
import 'package:tezal/screens/Customer/ProductDetail.dart';
import 'package:tezal/screens/Customer/widgets/AppbarBasketIcon.dart';
import 'package:tezal/screens/LoginPage.dart';
import 'package:tezal/services/AlertService.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:http/http.dart' as http;
import 'package:tezal/services/RouteBuilderService.dart';
import '../../../models/Customer/CategoryDetailModel.dart';

import '../widgets/ProductItemWidget.dart';

class CategoryDetailPage extends StatefulWidget {
  final String marketId;
  final String mainCategoryId;
  final String subCategoryId;
  CategoryDetailPage(
      {Key key, this.marketId, this.mainCategoryId, this.subCategoryId})
      : super(key: key);
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState(
      marketId: marketId,
      mainCategoryId: mainCategoryId,
      subCategoryId: subCategoryId);
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  String marketId;
  String mainCategoryId;
  String subCategoryId;
  List<Key> keys;
  CategoryDetailModel oldData;
  Future<CategoryDetailModel> getCustomerCategoryDetail() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();

    var adres = DataService.customerBaseaddress +
        'category/GetCategoryDetail/?MarketId=$marketId&MainCategoryId=$mainCategoryId';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      oldData = CategoryDetailModel.fromJson(json.decode(res.body));
      return oldData;
    }
    return null;
  }

  _CategoryDetailPageState(
      {this.marketId, this.mainCategoryId, this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCustomerCategoryDetail(),
        builder: (context, AsyncSnapshot<CategoryDetailModel> res) {
          if (res.connectionState == ConnectionState.done) {
            keys = List<Key>();
            for (var i = 0;
                i <
                    res.data.data.mainCategories
                        .where((element) => element.selected)
                        .toList()[0]
                        .subCategories
                        .length;
                i++) {
              keys.add(new GlobalKey());
            }

            return buildScaffold(res.data, false);
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return buildScaffold(res.data, true);
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Scaffold buildScaffold(CategoryDetailModel res, bool loading) {
    return Scaffold(
      appBar: AppBar(actions: [
        AppbarBasketIcon(
          context: context,
          count: res.data.basketCount,
          // onTap: () {
          //   Navigator.of(context)
          //       .push(
          //     new MaterialPageRoute(
          //         builder: (_) => BasketPage(
          //               isNewWindow: true,
          //             )),
          //   )
          //       .then((val) {
          //     setState(() {
          //       mainCategoryId = mainCategoryId;
          //     });
          //   });
          // },
        )
      ]),
      body: Stack(
        children: [
          Column(
            children: [
              mainCategories(res.data.mainCategories),
              subCategories(res.data.mainCategories
                  .where((element) => element.selected)
                  .toList()[0]
                  .subCategories),
              prductLists(res.data.mainCategories
                  .where((element) => element.selected)
                  .toList()[0]
                  .subCategories)
            ],
          ),
          if (loading)
            Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: FlatColors.green_light.withOpacity(0.2))
        ],
      ),
    );
  }

  Widget mainCategories(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Container(
        color: Colors.white,
        height: 50,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(categories.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            mainCategoryId = categories[index].id;
                            subCategoryId = '';
                          });
                        },
                        child: Text(
                          categories[index].name,
                          style: TextStyle(
                              color: categories[index].selected
                                  ? FlatColors.midnight_dark
                                  : Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget subCategories(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Container(
        color: Colors.white,
        height: 40,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(categories.length, (index) {
              return InkWell(
                onTap: () {
                  Scrollable.ensureVisible(
                      (keys[index] as GlobalKey).currentContext);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(categories[index].name),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: categories[index].selected
                            ? Colors.green.shade300
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: categories[index].selected
                                ? Colors.green.shade700
                                : FlatColors.grey_dark)),
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget prductLists(List<Category> categorises) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(categorises.length,
              (index) => products(categorises[index], index)),
        ),
      ),
    );
  }

  Widget products(Category categorises, int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        key: keys[index],
        padding: const EdgeInsets.all(10.0),
        child: Text(
          categorises.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.75,
        children: List.generate(categorises.products.length, (index) {
          return ProductItemWidget(
            context: context,
            product:
                ProductItemModel.fromJson(categorises.products[index].toJson()),
            axis: Axis.vertical,
            onTap: () async {
              Navigator.of(context)
                  .push(
                    new MaterialPageRoute(
                        builder: (_) =>
                            ProductDetail(categorises.products[index].id)),
                  )
                  .then((val) => setState(() {}));
            },
            onlike: () async {
              if (!await AuthService.mustLogin(context)) return;
              var headers = await AuthService.getDefaultHeadersNoLocation();

              var adres = DataService.customerBaseaddress +
                  (categorises.products[index].liked
                      ? 'product/unlike?Id='
                      : 'product/like?Id=') +
                  categorises.products[index].id;
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
                'Id': categorises.products[index].id,
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
                'Id': categorises.products[index].id,
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

  gotoBasket() {
    // Navigator.push(context, RouteBuilderService.goto(BasketPage()));
  }
}
