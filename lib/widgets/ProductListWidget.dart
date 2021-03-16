import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ProductResponseModel.dart';
import '../screens/Customer/ProductDetail.dart';
import '../services/FlatColors.dart';
import '../services/dataService.dart';

class ProductListWidget extends StatefulWidget {
  String tag;
  ProductListWidget({Key key, @required this.tag}) : super(key: key);
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState(tag);
}

class _ProductListWidgetState extends State<ProductListWidget> {
  String tag;
  Future<ProductResponseModel> model;
  _ProductListWidgetState(this.tag);
  Future<ProductResponseModel> verigetir() async {
    var res = await http
        .get(Uri.http(DataService.customerBaseaddress + "Product/List", ''));
    return ProductResponseModel.fromJson(json.decode(res.body));
  }

  @override
  void initState() {
    super.initState();
    model = verigetir();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: model,
      builder: (context, AsyncSnapshot<ProductResponseModel> urun) {
        return urun.connectionState == ConnectionState.done
            ? Container(
                height: 300,
                child: ListView.builder(
                  itemCount: urun.data.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(urun.data.data[index].id)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7, color: Colors.grey)
                            ]),
                        height: double.infinity,
                        width: 150,
                        child: urun.connectionState == ConnectionState.done
                            ? Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: double.infinity,
                                      child: InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.favorite_border)),
                                    ),
                                    Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: FadeInImage.assetNetwork(
                                              placeholder: "assets/loading.gif",
                                              image: DataService
                                                      .customerBaseaddress +
                                                  'Product/GetPhoto?Id=' +
                                                  urun.data.data[index]
                                                      .productPhoto[0]),
                                        )),
                                    Divider(),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: Text(
                                        urun.data.data[index].name,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      height: 50,
                                      child: urun.data.data[index]
                                                  .discountedPrice ==
                                              null
                                          ? Text(
                                              urun.data.data[index]
                                                  .originalPrice,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  urun.data.data[index]
                                                      .discountedPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                Text(
                                                  urun.data.data[index]
                                                      .originalPrice,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                          minWidth: double.infinity,
                                          child: RaisedButton(
                                            color: FlatColors.orange_light,
                                            onPressed: () {},
                                            child: Text("Sepete Ekle"),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                            : CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              )
            : Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
