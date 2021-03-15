import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/services/FlatColors.dart';

class OrderResult extends StatefulWidget {
  final String orderId;

  const OrderResult({Key key, this.orderId}) : super(key: key);

  @override
  _OrderResultState createState() => _OrderResultState(orderId);
}

class _OrderResultState extends State<OrderResult> {
  final String orderId;

  _OrderResultState(this.orderId);
  @override
  Widget build(BuildContext context) {
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
              color: FlatColors.green_light,
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
              Lang(context).orderSuccessfully,
              style: TextStyle(color: FlatColors.green_light, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Container(
                  child: Center(
                      child: Text(
                    Lang(context).continueShopping,
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
}
