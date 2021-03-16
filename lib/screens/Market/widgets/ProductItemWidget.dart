import 'package:flutter/material.dart';

import '../../../lang/Lang.dart';
import '../../../models/Customer/ProductItemModel.dart';
import '../../../services/DataService.dart';
import '../../../services/FlatColors.dart';

class ProductItemWidget extends StatelessWidget {
  final VoidCallback onAdd, onRemove, onlike, onTap;
  final ProductItemModel product;
  final Axis axis;
  bool liked = false;
  BuildContext context;
  ProductItemWidget({
    this.context,
    @required this.product,
    @required this.axis,
    @required this.onAdd,
    @required this.onRemove,
    @required this.onlike,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return axis == Axis.horizontal
        ? productItemHorizontal(product: product)
        : productItemVertical(product: product);
  }

  add() => onAdd.call();
  remove() => onRemove.call();
  like() => onlike.call();
  tap() => onTap.call();
  Widget productItemVertical(
      {@required ProductItemModel product, bool loading = false}) {
    return product == null
        ? Center(
            child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: FlatColors.green_light.withOpacity(0.2)),
          )
        : GestureDetector(
            onTap: () {
              tap();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              DataService.customerBaseaddress +
                                  'product/GetMarketProductPhoto?Id=' +
                                  product.id,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned.fill(
                              child: Container(
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () async {
                                        like();
                                      },
                                      child: product.liked
                                          ? Icon(
                                              Icons.favorite,
                                              color: FlatColors.red_light,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            product.name,
                          ),
                        ),
                        if (product.discountedPrice != null &&
                            product.discountedPrice > 0)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  product.originalPrice.toString() +
                                      " " +
                                      Lang(context).moneyUnit,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  product.discountedPrice.toString() +
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
                              product.originalPrice.toString() +
                                  " " +
                                  Lang(context).moneyUnit,
                              style: TextStyle(color: FlatColors.green_light),
                            ),
                          )
                      ],
                    ),
                    productControllerVertical(product),
                    if (product.discountRate != null &&
                        product.discountRate > 0)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                product.discountRate.toString() + ' %',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            color: FlatColors.green_light.withOpacity(0.75),
                          ),
                        ),
                      ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: Colors.grey.shade300)),
              ),
            ),
          );
  }

  Widget productControllerVertical(ProductItemModel product) {
    if (product.amount == null || product.amount == 0) {
      return GestureDetector(
        onTap: () {
          tap();
        },
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await add();
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
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          tap();
        },
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await add();
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
                onTap: () {
                  remove();
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
        ),
      );
    }
  }

  Widget productItemHorizontal(
      {ProductItemModel product, bool loading = false}) {
    return product == null
        ? Container(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
            color: FlatColors.green_light.withOpacity(0.2))
        : GestureDetector(
            onTap: () {
              tap();
            },
            child: Container(
              height: 50,
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        DataService.prefix +
                            DataService.authority +
                            DataService.customerBaseaddress +
                            'product/GetMarketProductPhoto?Id=' +
                            product.id,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          product.name,
                        ),
                      ),
                      if (product.discountedPrice != null &&
                          product.discountedPrice > 0)
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product.originalPrice.toString() +
                                    " " +
                                    Lang(context).moneyUnit,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text(
                                product.discountedPrice.toString() +
                                    " " +
                                    Lang(context).moneyUnit,
                                style: TextStyle(color: FlatColors.green_light),
                              )
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            product.originalPrice.toString() +
                                " " +
                                Lang(context).moneyUnit,
                            style: TextStyle(color: FlatColors.green_light),
                          ),
                        ),
                      Spacer(),
                      productControllerHorizontal(product)
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: Colors.grey.shade300)),
            ),
          );
  }

  Widget productControllerHorizontal(ProductItemModel product) {
    if (product.amount == null || product.amount == 0) {
      return Container(
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                await add();
              },
              child: Container(
                width: 30,
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
                await add();
              },
              child: Container(
                width: 30,
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
                style: TextStyle(fontSize: 30),
              )),
              decoration: BoxDecoration(
                  color: FlatColors.white_light,
                  border: Border.all(color: FlatColors.green_dark)),
            ),
            InkWell(
              onTap: () {
                remove();
              },
              child: Container(
                width: 30,
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
}
