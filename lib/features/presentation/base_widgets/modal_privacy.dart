import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/styles/txt_styles.dart';
import '../../../core/themes/app_theme.dart';
import '../../../core/widgets/custom_future_builder.dart';
import '../../../core/widgets/loading.dart';
import '../../data/models/agreement_result_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../customer_widgets/simple_app_bar.dart';

class PrivacyModal extends StatelessWidget {
  final repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar().create(
        context,
        text: "حریم خصوصی",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomFutureBuilder<Either<Failure, AgreementResultModel>>(
          future: repository.privacyText,
          successBuilder: (context, data) {
            return data.fold(
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
            return AppLoading(color: AppTheme.customerPrimary);
          },
        ),
      ),
    );
  }
}
