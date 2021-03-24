import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/addresses_result_model.dart';
import '../../../data/repositories/customer_address_repository.dart';
import 'widgets/address_list.dart';
import 'widgets/modal_save_address.dart';

class AddressesPage extends StatefulWidget {
  static const route = "/customer_addresses";

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final _customerAddressRepo = CustomerAddressRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "آدرس‌های من",
        showBackBtn: true,
      ),
      body: futureBuilder,
      floatingActionButton: fab,
    );
  }

  Widget get futureBuilder {
    return CustomFutureBuilder<Either<Failure, AddressesResultModel>>(
      future: _customerAddressRepo.addresses,
      successBuilder: (context, data) {
        return data.fold(
          (l) => Txt(
            l.message,
            style: AppTxtStyles().body..alignment.center(),
          ),
          (r) => AddressList(
            addresses: r.data,
            customerAddressRepo: _customerAddressRepo,
            onSetAddressDefaultComplete: () => setState(() {}),
            onShowAddressDetailComplete: () => setState(() {}),
            onEditAddressComplete: () => setState(() {}),
            onRemoveAddressComplete: () => setState(() {}),
          ),
        );
      },
      errorBuilder: (context, data) {
        return AppLoading(color: AppTheme.customerPrimary);
      },
    );
  }

  // floating action button
  Widget get fab {
    return FloatingActionButton(
      onPressed: fabOnTap,
      child: Icon(
        Feather.plus,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  void fabOnTap() {
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
    ).then((value) => setState(() {}));
  }
}
