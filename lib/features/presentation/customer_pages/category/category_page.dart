// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

import '../../customer_widgets/simple_app_bar.dart';

class CategoryPage extends StatelessWidget {
  static const route = "/customer_category";

  CategoryPage({
    required this.marketId,
    required this.mainCategoryId,
  });

  final String marketId;
  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "دسته‌بندی‌‌ها",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: SizedBox(),
    );
  }
}
