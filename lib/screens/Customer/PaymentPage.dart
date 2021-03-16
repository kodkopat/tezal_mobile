import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/PaymentInfoModel.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import 'NewAddress.dart';
import 'OrderResult.dart';
import 'widgets/AppBarNew.dart';
//import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _paymentMethod = 'online';
  PaymentInfoModel oldData;
  bool updateData = true;
  bool paymentLoading = false;
  Future<PaymentInfoModel> gePaymentInfo() async {
    if (oldData == null || updateData == true) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var adres = DataService.customerBaseaddress + 'basket/GetPaymentInfo';
      var res = await http.get(Uri.http(DataService.authority, adres),
          headers: headers);
      if (res.statusCode == 200) {
        oldData = PaymentInfoModel.fromJson(json.decode(res.body));
      }
    }
    return oldData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gePaymentInfo(),
        builder: (context, AsyncSnapshot<PaymentInfoModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return buildScaffold(res.data, false);
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return buildScaffold(oldData, true);
          } else {
            return Scaffold(
              appBar: AppBarNew(
                title: Lang(context).pay,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Scaffold buildScaffold(PaymentInfoModel model, bool loading) {
    return Scaffold(
      appBar: AppBarNew(
        title: Lang(context).pay,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        Lang(context).deliveryAddress,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              new MaterialPageRoute(
                                  builder: (_) => Newaddress()),
                            )
                                .then((val) {
                              setState(() {
                                oldData = null;
                              });
                            });
                          },
                          child: Text(Lang(context).newAddress))
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.data.address.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          var headers =
                              await AuthService.getDefaultHeadersNoLocation();
                          var adres = DataService.customerBaseaddress +
                              'basket/SelectAdres?Id=' +
                              model.data.address[index].id;
                          await http.get(Uri.http(DataService.authority, adres),
                              headers: headers);
                          setState(() {
                            updateData = true;
                          });
                        },
                        onLongPress: () async {
                          var headers =
                              await AuthService.getDefaultHeadersNoLocation();
                          var adres = DataService.customerBaseaddress +
                              'address/SetDefaultaddress?Id=' +
                              model.data.address[index].id;
                          await http.get(Uri.http(DataService.authority, adres),
                              headers: headers);
                          setState(() {
                            updateData = true;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.data.address[index].name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      model.data.address[index].address,
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                if (model.data.address[index].isSelected)
                                  Icon(
                                    Icons.check,
                                    color: FlatColors.green_light,
                                  ),
                                if (!model.data.address[index].isSelected &&
                                    model.data.address[index].isDefault)
                                  Icon(
                                    Icons.check,
                                    color: Colors.grey.shade500,
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Lang(context).paymentType,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(Lang(context).online),
                          subtitle: Text(Lang(context).payWithCardOnline),
                          value: 'online',
                          groupValue: _paymentMethod,
                          onChanged: (dynamic value) {
                            setState(() {
                              _paymentMethod = value;
                              updateData = false;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(Lang(context).pos),
                          subtitle: Text(Lang(context).payWithPos),
                          value: 'pos',
                          groupValue: _paymentMethod,
                          onChanged: (dynamic value) {
                            setState(() {
                              _paymentMethod = value;
                              updateData = false;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(Lang(context).cash),
                          subtitle: Text(Lang(context).payWithCash),
                          value: 'cash',
                          groupValue: _paymentMethod,
                          onChanged: (dynamic value) {
                            setState(() {
                              _paymentMethod = value;
                              updateData = false;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(Lang(context).wallet),
                          subtitle: Text(Lang(context).payWithWallet),
                          value: 'wallet',
                          groupValue: _paymentMethod,
                          onChanged: (dynamic value) {
                            setState(() {
                              _paymentMethod = value;
                              updateData = false;
                            });
                          },
                        )
                      ],
                    )),
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
                      if (!paymentLoading) {
                        switch (_paymentMethod) {
                          case 'online':
                            await payOnline();
                            break;
                          case 'pos':
                            await pay();
                            break;
                          case 'cash':
                            await pay();
                            break;
                          case 'wallet':
                            await pay();
                            break;
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (paymentLoading)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        if (!paymentLoading)
                          Text(
                            Lang(context).continu,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                      ],
                    ),
                    color: FlatColors.green_dark,
                  ),
                ),
              ),
            ),
          ),
          if (loading && updateData)
            Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: FlatColors.green_light.withOpacity(0.2)),
        ],
      ),
    );
  }

  Future pay() async {
    setState(() {
      paymentLoading = true;
    });
    var headers =
        await AuthService.getDefaultHeadersNoLocation(context: context);
    var adres = DataService.customerBaseaddress +
        'order/save?paymentType=' +
        _paymentMethod;
    var res = await http.get(Uri.http(DataService.authority, adres),
        headers: headers);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      debugPrint(res.body);
      if (data["success"].toString().toLowerCase() == 'true') {
        Navigator.of(context)
            .push(
              new MaterialPageRoute(
                  builder: (_) => OrderResult(
                        orderId: data["data"]["orderId"],
                      )),
            )
            .then(
                (val) => Navigator.popUntil(context, ModalRoute.withName("/")));
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: FlatColors.red_dark,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(Lang(context).error),
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: Text(data["message"].toString()),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(Lang(context).ok),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() {
                      paymentLoading = false;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future payOnline() async {
    // const url = 'https://flutter.dev';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
