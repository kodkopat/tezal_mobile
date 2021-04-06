import 'package:flutter/material.dart';
import 'package:tezal/features/data/models/wallet_detail_result_model.dart'
    as wallet;

import 'transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({@required this.walletDetail});

  final List<wallet.Detail> walletDetail;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: walletDetail.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return TransactionListItem(
          walletDetail: walletDetail[index],
        );
      },
    );
  }
}
