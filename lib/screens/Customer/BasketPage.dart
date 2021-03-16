import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/BasketDetailModel.dart';
import '../../services/AlertService.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import '../../services/RouteBuilderService.dart';
import '../LoginPage.dart';
import 'MainPage.dart';
import 'PaymentPage.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({
    Key key,
    this.isNewWindow,
  }) : super(key: key);
  final bool isNewWindow;
  @override
  _BasketPageState createState() => _BasketPageState(isNewWindow);
}

class _BasketPageState extends State<BasketPage> {
  BasketDetailModel oldData;
  TextEditingController noteController = new TextEditingController();
  final bool isNewWindow;

  _BasketPageState(this.isNewWindow);
  Future<BasketDetailModel> getBasketDetail() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    var adres = DataService.customerBaseaddress + 'basket/GetBasket';
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      oldData = BasketDetailModel.fromJson(json.decode(res.body));
      if (oldData.data != null) noteController.text = oldData.data.note;
      return oldData;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBasketDetail(),
        builder: (context, AsyncSnapshot<BasketDetailModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return res.data == null ||
                    res.data.data == null ||
                    res.data.data.items.length == 0
                ? (isNewWindow ? emptyPage() : emptyPageBody())
                : (isNewWindow
                    ? buildScaffold(res.data, false)
                    : fullpageWidget(res.data, false));
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return res.data.data == null || res.data.data.items.length == 0
                ? (isNewWindow ? emptyPage() : emptyPageBody())
                : (isNewWindow
                    ? buildScaffold(res.data, false)
                    : fullpageWidget(res.data, true));
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget buildScaffold(BasketDetailModel res, bool loading) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          title: Text(
            Lang(context).basket,
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
            IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: FlatColors.white_light,
                ),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: FlatColors.green_dark,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text('title'),
                            )
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Text('content'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(Lang(context).ok),
                            onPressed: () async {
                              await clearBasket();
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                          ),
                          TextButton(
                            child: Text(Lang(context).ok),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                })
          ]),
      body: fullpageWidget(res, loading),
    );
  }

  Stack fullpageWidget(BasketDetailModel res, bool loading) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              products(res.data.items),
              invoice(res.data),
              note(),
              Container(
                height: 80,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 80,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: FlatColors.green_dark,
                child: RaisedButton(
                  onPressed: () async {
                    var res = await updateBasket();
                    if (res) {
                      Navigator.of(context)
                          .push(
                        new MaterialPageRoute(builder: (_) => PaymentPage()),
                      )
                          .then((val) {
                        setState(() {});
                      });
                    }
                  },
                  child: Text(
                    Lang(context).continu,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  color: FlatColors.green_dark,
                ),
              ),
            ),
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
    );
  }

  Future<bool> updateBasket() async {
    var headers = await AuthService.getDefaultHeadersNoLocation();
    var adres = DataService.customerBaseaddress +
        'basket/UpdateBasket?Note=' +
        noteController.text;
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data['success'].toString().toLowerCase() == 'true') return true;
    }
    return false;
  }

  Widget products(List<Item> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15),
          child: Text(
            Lang(context).products,
          ),
        ),
        Container(
            child: Column(
          children: List.generate(items.length, (index) {
            return productItem(items, index);
          }),
        )),
      ],
    );
  }

  Widget productItem(List<Item> items, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.2)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 50,
              child: Image.network(DataService.prefix +
                  DataService.authority +
                  DataService.customerBaseaddress +
                  'product/GetMarketProductPhoto?Id=' +
                  items[index].id),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  items[index].productName,
                ),
              ),
              Row(
                children: items[index].discountedPrice != null ||
                        items[index].discountedPrice > 0
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            items[index].originalPrice.toString() +
                                ' ' +
                                Lang(context).moneyUnit,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            items[index].discountedPrice.toString() +
                                ' ' +
                                Lang(context).moneyUnit,
                          ),
                        ),
                      ]
                    : [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            items[index].discountedPrice.toString() +
                                ' ' +
                                Lang(context).moneyUnit,
                          ),
                        ),
                      ],
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(5),
            child: productController(items[index]),
          )
        ],
      ),
    );
  }

  Widget productController(Item product) {
    if (product.amount == null || product.amount == 0) {
      return Container(
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                await add(product);
              },
              child: Container(
                height: 30,
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
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                await add(product);
              },
              child: Container(
                height: 30,
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
                style: TextStyle(fontSize: 20),
              )),
              decoration: BoxDecoration(
                  color: FlatColors.white_light,
                  border: Border.all(color: FlatColors.green_dark)),
            ),
            InkWell(
              onTap: () {
                remove(product);
              },
              child: Container(
                height: 30,
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

  Widget invoice(Data data) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lang(context).invoice,
          ),
          Column(children: [
            //total price
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(Lang(context).totalPrice),
                    Spacer(),
                    Text(
                      data.totalPrice.toString() +
                          ' ' +
                          Lang(context).moneyUnit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1, color: Colors.grey, spreadRadius: 1)
                  ]),
            ),

            //discount
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(Lang(context).totalDiscount),
                    Spacer(),
                    Text(
                      data.totalDiscount.toString() +
                          ' ' +
                          Lang(context).moneyUnit,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: FlatColors.red_light),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    spreadRadius: 1,
                    offset: Offset(0.0, 0.75))
              ]),
            ),

            //price with discount
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(Lang(context).discountedPrice),
                    Spacer(),
                    Text(
                      data.totalDiscountedPrice.toString() +
                          ' ' +
                          Lang(context).moneyUnit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    spreadRadius: 1,
                    offset: Offset(0.0, 0.75))
              ]),
            ),

            //delivery cost
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(Lang(context).deliveryCost),
                    Spacer(),
                    Text(
                      data.deliveryCost.toString() +
                          ' ' +
                          Lang(context).moneyUnit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    spreadRadius: 1,
                    offset: Offset(0.0, 0.75))
              ]),
            ),

            //payable
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(Lang(context).payable),
                    Spacer(),
                    Text(
                      data.payable.toString() + ' ' + Lang(context).moneyUnit,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey,
                        spreadRadius: 1,
                        offset: Offset(0.0, 0.75))
                  ]),
            ),
          ]),
        ],
      ),
    );
  }

  Widget note() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lang(context).note,
          ),
          Column(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Lang(context).setNoteForOrder),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1, color: Colors.grey, spreadRadius: 1)
                  ]),
            ),
          ]),
        ],
      ),
    );
  }

  Widget emptyPage() {
    return Scaffold(
      body: emptyPageBody(),
    );
  }

  Center emptyPageBody() {
    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.shopping_cart,
              size: 100,
              color: FlatColors.grey_dark,
            ),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: FlatColors.grey_dark)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              Lang(context).yourBasketEmpty,
              style: TextStyle(color: FlatColors.grey_dark, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                if (isNewWindow)
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                else
                  MainPage.setIndex(context, 0);
              },
              child: Container(
                  child: Center(
                      child: Text(
                    Lang(context).startBuying,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                      color: FlatColors.green_dark,
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
        ],
      ),
    ));
  }

  add(Item product) async {
    var isloggedin = await AuthService.isLoggedIn();
    if (isloggedin) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var body = jsonEncode(<String, String>{'Id': product.id, 'Amount': '1'});
      var adres = DataService.customerBaseaddress + 'basket/AddProductToBasket';
      var res = await http.post(Uri.http(DataService.authority, adres),
          headers: headers, body: body);
      if (res.statusCode == 200) {
        setState(() {});
      } else {
        AlertService.showError(
            context, Lang(context).error, Lang(context).errorOccurred, () {
          Navigator.pop(context);
        });
      }
    } else {
      Navigator.push(context, RouteBuilderService.goto(LoginPagePage()));
    }
  }

  remove(Item product) async {
    var isloggedin = await AuthService.isLoggedIn();
    if (isloggedin) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var body = jsonEncode(<String, String>{'Id': product.id, 'Amount': '1'});
      var adres =
          DataService.customerBaseaddress + 'basket/RemoveProductFromBasket';
      var res = await http.post(Uri.http(DataService.authority, adres),
          headers: headers, body: body);
      if (res.statusCode == 200) {
        setState(() {});
      } else {
        AlertService.showError(
            context, Lang(context).error, Lang(context).errorOccurred, () {
          Navigator.pop(context);
        });
      }
    } else {
      Navigator.push(context, RouteBuilderService.goto(LoginPagePage()));
    }
  }

  clearBasket() async {
    var isloggedin = await AuthService.isLoggedIn();
    if (isloggedin) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var adres = DataService.customerBaseaddress + 'basket/emptyBasket';
      var res = await http.get(Uri.http(DataService.authority, adres),
          headers: headers);
      if (res.statusCode == 200) {
        setState(() {});
      } else {
        AlertService.showError(
            context, Lang(context).error, Lang(context).errorOccurred, () {
          Navigator.pop(context);
        });
      }
    } else {
      Navigator.push(context, RouteBuilderService.goto(LoginPagePage()));
    }
  }
}
