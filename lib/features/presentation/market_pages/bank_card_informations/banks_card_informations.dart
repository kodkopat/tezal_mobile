// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../bank_card_informations_add/add_bank_card_informations_page.dart';
import 'widgets/bank_card_informations_list.dart';

class BankCardInformationsPage extends StatefulWidget {
  static const route = "/market_bank_card_informations";

  @override
  _BankCardInformationsPageState createState() =>
      _BankCardInformationsPageState();
}

class _BankCardInformationsPageState extends State<BankCardInformationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "اطلاعات بانکی",
        showBackBtn: true,
      ),
      body: BankCardInformationsList(
        texts: [
          "5022-2910-4918-0183",
          "5022-2910-4918-0184",
          "5022-2910-4918-0185",
          "5022-2910-4918-0186",
          "5022-2910-4918-0187",
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routes.sailor(AddBankCardInformationsPage.route);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
