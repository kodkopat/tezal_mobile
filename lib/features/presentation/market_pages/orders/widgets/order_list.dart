import 'package:flutter/material.dart';

import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderListItem();
      },
    );
  }
}
