import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/ProductDetailModel.dart';
import '../../models/Customer/ProductItemModel.dart';
import '../../services/AlertService.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import '../../services/RouteBuilderService.dart';
import '../LoginPage.dart';
import 'BasketPage.dart';
import 'widgets/AppBarNew.dart';
import 'widgets/AppbarBasketIcon.dart';

class ProductDetail extends StatefulWidget {
  String id;
  ProductDetail(this.id);
  @override
  _ProductDetailState createState() => _ProductDetailState(id);
}

class _ProductDetailState extends State<ProductDetail> {
  String id;
  _ProductDetailState(this.id);
  ProductDetailModel oldData;
  // Future<ProductDetailModel> model;
  Future<ProductDetailModel> verigetir() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    var adres = DataService.customerBaseaddress + "Product/GetDetail";
    var res = await http.get(Uri.http(DataService.authority, adres, {'Id': id}),
        headers: headers);
    oldData = ProductDetailModel.fromJson(json.decode(res.body));
    return oldData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: verigetir(),
        builder: (context, AsyncSnapshot<ProductDetailModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return buildScaffold(res.data, false);
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return buildScaffold(oldData, true);
          } else {
            return Scaffold(
                appBar: AppBarNew(
                  title: Lang(context).productDetail,
                ),
                backgroundColor: FlatColors.white_light,
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget buildScaffold(ProductDetailModel res, bool loading) {
    return Scaffold(
        appBar: AppBarNew(
          title: Lang(context).productDetail,
          actions: [
            AppbarBasketIcon(
              context: context,
              count: res.data.basketCount,
              onTap: () {
                Navigator.of(context)
                    .push(
                  new MaterialPageRoute(
                      builder: (_) => BasketPage(
                            isNewWindow: true,
                          )),
                )
                    .then((val) {
                  setState(() {
                    id = id;
                  });
                });
              },
            )
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
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(DataService.prefix +
                                DataService.authority +
                                DataService.customerBaseaddress +
                                'product/GetMarketProductPhoto/?Id=' +
                                id),
                          ))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: productControllerVertical(
                            ProductItemModel.fromJson(res.data.toJson())),
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(res.data.marketName +
                                " (" +
                                res.data.marketAddress +
                                ")"),
                          ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Text(
                          res.data.name,
                          style: TextStyle(
                              fontSize: 25, color: FlatColors.midnight_dark),
                        ),
                        Spacer(),
                        if (res.data.discountedPrice != null &&
                            res.data.discountedPrice > 0)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  res.data.originalPrice.toString() +
                                      " " +
                                      Lang(context).moneyUnit,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  res.data.discountedPrice.toString() +
                                      " " +
                                      Lang(context).moneyUnit,
                                  style:
                                      TextStyle(color: FlatColors.green_light),
                                )
                              ],
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              res.data.originalPrice.toString() +
                                  " " +
                                  Lang(context).moneyUnit,
                              style: TextStyle(color: FlatColors.green_light),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(res.data.description),
                  ),
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

  Widget productControllerVertical(ProductItemModel product) {
    if (product.amount == null || product.amount == 0) {
      return Container(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                //add
                var headers = await AuthService.getDefaultHeadersNoLocation();
                var body = jsonEncode(
                    <String, String>{'Id': product.id, 'Amount': '1'});
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
              child: Container(
                width: 30,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: FlatColors.white_light,
                  ),
                ),
                decoration: BoxDecoration(
                    color: FlatColors.green_light,
                    border: Border.all(color: FlatColors.green_dark)),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                //add
                var headers = await AuthService.getDefaultHeadersNoLocation();
                var body = jsonEncode(
                    <String, String>{'Id': product.id, 'Amount': '1'});
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
              child: Container(
                width: 30,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: FlatColors.white_light,
                  ),
                ),
                decoration: BoxDecoration(
                    color: FlatColors.green_light,
                    border: Border.all(color: FlatColors.green_dark)),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              child: Center(
                  child: Text(
                product.amount.toString(),
                style: TextStyle(fontSize: 30),
              )),
              decoration: BoxDecoration(
                  color: FlatColors.white_light,
                  border: Border.all(color: FlatColors.green_dark)),
            ),
            InkWell(
              onTap: () async {
                //remove

                var headers = await AuthService.getDefaultHeadersNoLocation();
                var body = jsonEncode(
                    <String, String>{'Id': product.id, 'Amount': '1'});
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
              child: Container(
                width: 30,
                child: Center(
                  child: Icon(
                    product.amount > 1
                        ? Icons.remove
                        : Icons.delete_outline_outlined,
                    color: product.amount > 1
                        ? FlatColors.white_light
                        : FlatColors.red_dark,
                  ),
                ),
                decoration: BoxDecoration(
                    color: FlatColors.green_light,
                    border: Border.all(color: FlatColors.green_dark)),
              ),
            ),
          ],
        ),
      );
    }
  }
}
