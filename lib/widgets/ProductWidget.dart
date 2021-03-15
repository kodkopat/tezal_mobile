import 'package:tezal/models/ProductResponseModel.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  Product product;

  ProductWidget(this.product) {}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 161,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [Text(product.name), Text(product.originalPrice)],
        ),
      ),
    );
  }
}
