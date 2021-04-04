import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../core/exceptions/failure.dart';
import '../../../core/themes/app_theme.dart';
import '../../../core/widgets/custom_future_builder.dart';
import '../../../core/widgets/loading.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../customer_widgets/simple_app_bar.dart';

class RulesModal extends StatelessWidget {
  final repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar().create(
        context,
        text: "قوانین و مقررات",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomFutureBuilder<Either<Failure, BaseApiResultModel>>(
          future: repository.privacyText,
          successBuilder: (context, data) {
            return data.fold(
              (left) {
                // return Txt(
                //   "${left.message}",
                //   style: AppTxtStyles().body..textAlign.justify(),
                // );
                return Html(data: "${left.message}");
              },
              (right) {
                return Html(data: right.data);
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
