import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/models/Customer/ProductItemModel.dart';
import 'package:tezal/models/Market/MarketProductsModel.dart';
import 'package:tezal/screens/Customer/ProductDetail.dart';
import 'package:tezal/screens/Customer/widgets/ProductItemWidget.dart';
import 'package:tezal/screens/LoginPage.dart';
import 'package:tezal/services/AlertService.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:http/http.dart' as http;
import 'package:tezal/services/RouteBuilderService.dart';
import 'CategoryDetailPage.dart';

class MarketDetailPage extends StatefulWidget {
  final String id;
  const MarketDetailPage({@required this.id});

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState(id);
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  MarketProductsModel oldData;
  String id;
  _MarketDetailPageState(this.id);

  Future<MarketProductsModel> getMaerketDetail() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    var adres =
        DataService.marketBaseaddress + 'Product/GetMarketProduct/?Id=$id';
         print(adres);
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);

    if (res.statusCode == 200) {
      oldData = MarketProductsModel.fromJson(json.decode(res.body));
      print(oldData);
      return oldData;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMaerketDetail(),
        builder: (context, AsyncSnapshot<MarketProductsModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return buildScaffold(res.data, false);
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return buildScaffold(oldData, true);
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: FlatColors.white_light,
                  elevation: 0,
                ),
                backgroundColor: FlatColors.white_light,
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget buildScaffold(MarketProductsModel res, bool loading) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Lang(context).market,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            // AppbarBasketIcon(
            //   context: context,
            //   count: res.data.basketCount,
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(
            //       new MaterialPageRoute(
            //           builder: (_) => BasketPage(
            //                 isNewWindow: true,
            //               )),
            //     )
            //         .then((val) {
            //       setState(() {
            //         id = id;
            //       });
            //     });
            //   },
            // )
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(DataService.prefix +
                                DataService.authority +
                                DataService.marketBaseaddress +
                                'market/GetPhoto/?Id=' +
                                id),
                          ))),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                        ),
                      )),
                    ],
                  ),
                  Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         res.data.name + " (" + res.data.address + ")",
                      //         style: TextStyle(
                      //             fontSize: 25,
                      //             color: FlatColors.midnight_dark),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 5),
                      //         child: Row(
                      //           children: [
                      //             Icon(
                      //               Icons.store,
                      //               color: FlatColors.green_light,
                      //             ),
                      //             Text(
                      //               res.data.distance.toString() +
                      //                   " " +
                      //                   Lang(context).kiloMeter,
                      //               style: TextStyle(
                      //                   color: FlatColors.green_light,
                      //                   fontSize: 12),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 5),
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         Icons.delivery_dining,
                            //         color: FlatColors.green_light,
                            //       ),
                            //       Text(
                            //         res.data.deliveryCost.toString() +
                            //             " " +
                            //             Lang(context).moneyUnit,
                            //         style: TextStyle(
                            //             color: FlatColors.green_light,
                            //             fontSize: 12),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 5),
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         Icons.star_border_rounded,
                            //         color: res.data.score <= 100 &&
                            //                 res.data.score >= 80
                            //             ? FlatColors.green_light
                            //             : (res.data.score < 80 &&
                            //                     res.data.score >= 60
                            //                 ? FlatColors.orange_light
                            //                 : FlatColors.red_light),
                            //       ),
                            //       Text(
                            //         res.data.score.toString() + "/100",
                            //         style: TextStyle(
                            //             color: res.data.score <= 100 &&
                            //                     res.data.score >= 80
                            //                 ? FlatColors.green_light
                            //                 : (res.data.score < 80 &&
                            //                         res.data.score >= 60
                            //                     ? FlatColors.orange_light
                            //                     : FlatColors.red_light),
                            //             fontSize: 12),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      Lang(context).categories,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 25,
                      childAspectRatio: 0.85,
                      children: List.generate(
                        res.data.categories.length,
                        (index) {
                          return item(res.data.categories[index]);
                        },
                      )),
                  categories(res.data.categories)
                ],
              ),
            ),
            if (loading)
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  color: FlatColors.green_light.withOpacity(0.2)),
          ],
        ));
  }

  Widget categories(List<Category> categories) {
    return Column(
      children: List.generate(categories.length, (index) {
        return productList(categories[index]);
      }),
    );
  }

  Widget productList(Category category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            category.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            primary: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(category.products.length, (index) {
              return Container(
                width: 150,
                child: ProductItemWidget(
                  context: context,
                  axis: Axis.vertical,
                  product: ProductItemModel.fromJson(
                      category.products[index].toJson()),
                  onTap: () async {
                    Navigator.of(context)
                        .push(
                          new MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetail(category.products[index].id)),
                        )
                        .then((val) => setState(() {}));
                  },
                  // onlike: () async {
                  //   if (!await AuthService.mustLogin(context)) return;
                  //   var headers =
                  //       await AuthService.getDefaultHeadersNoLocation();

                  //   var adres = DataService.customerBaseaddress +
                  //       (category.products[index].liked
                  //           ? 'product/unlike?Id='
                  //           : 'product/like?Id=') +
                  //       category.products[index].id;
                  //   var res = await http.get(
                  //       Uri.http(DataService.authority, adres),
                  //       headers: headers);
                  //   if (res.statusCode == 200) {
                  //     setState(() {});
                  //   } else {
                  //     AlertService.showError(context, Lang(context).error,
                  //         Lang(context).errorOccurred, () {
                  //       Navigator.pop(context);
                  //     });
                  //   }
                  // },
                  onAdd: () async {
                    var headers =
                        await AuthService.getDefaultHeadersNoLocation();
                    var body = jsonEncode(<String, String>{
                      'Id': category.products[index].id,
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
                        AlertService.showError(context, Lang(context).error,
                            Lang(context).errorOccurred, () {
                          Navigator.pop(context);
                        });
                      }
                    } else {
                      Navigator.push(
                          context, RouteBuilderService.goto(LoginPagePage()));
                    }
                  },
                  onRemove: () async {
                    var headers =
                        await AuthService.getDefaultHeadersNoLocation();
                    var body = jsonEncode(<String, String>{
                      'Id': category.products[index].id,
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
                        AlertService.showError(context, Lang(context).error,
                            Lang(context).errorOccurred, () {
                          Navigator.pop(context);
                        });
                      }
                    } else {
                      Navigator.push(
                          context, RouteBuilderService.goto(LoginPagePage()));
                    }
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget item(Category category) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  DataService.prefix +
                      DataService.authority +
                      DataService.customerBaseaddress +
                      "category/GetPhoto?Id=" +
                      category.id,
                  fit: BoxFit.fill,
                )),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: FlatColors.grey_dark,
                    blurRadius: 3,
                  )
                ]),
          ),
          Align(
            child: Text(
              category.name,
              style: TextStyle(color: Colors.grey.shade800),
            ),
            alignment: Alignment.bottomCenter,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    RouteBuilderService.goto(CategoryDetailPage(
                      marketId: id,
                      mainCategoryId: category.id,
                    )));
              },
            ),
          )
        ],
      ),
    );
  }
}
