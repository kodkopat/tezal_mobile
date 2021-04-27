// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/styles/txt_styles.dart';
import '../../../core/widgets/custom_future_builder.dart';
import '../../../core/widgets/loading.dart';
import '../../data/models/customer/agreement_result_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../customer_widgets/simple_app_bar.dart';

class RulesModal extends StatelessWidget {
  final repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "قوانین و مقررات",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomFutureBuilder<Either<Failure, AgreementResultModel>>(
          future: repository.privacyText,
          successBuilder: (context, data) {
            return data!.fold(
              (left) {
                return Txt(
                  "${left.message}",
                  style: AppTxtStyles().body..textAlign.justify(),
                );
              },
              (right) {
                return Html(data: right.data.message);
              },
            );
          },
          errorBuilder: (context, error) {
            return AppLoading();
          },
        ),
      ),
    );
  }
}
