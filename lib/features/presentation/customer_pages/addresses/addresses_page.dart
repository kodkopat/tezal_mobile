import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/repositories/customer_address_repository.dart';
import 'widgets/address_list.dart';
import 'widgets/modal_save_address.dart';

class AddressesPage extends StatelessWidget {
  static const route = "/customer_addresses";

  AddressesPage({Key key}) : super(key: key);

  final _customerAddressRepo = CustomerAddressRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "آدرس‌های من",
        showBackBtn: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      )
      /*CustomFutureBuilder<Either<Failure, dynamic>>(
        // future: _customerAddressRepo,
        future: Future.value(),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => AddressList(),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ) */
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: true,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.2),
            builder: (context) {
              return SaveAddressModal(
                customerAddressRepo: _customerAddressRepo,
              );
            },
          );
        },
        child: Icon(
          Feather.plus,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
