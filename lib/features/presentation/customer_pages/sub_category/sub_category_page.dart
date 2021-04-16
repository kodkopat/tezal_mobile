// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/sub_category_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/category_notifier.dart';
import 'widgets/sub_category_list.dart';

class SubCategoryPage extends StatelessWidget {
  static const route = "/customer_sub_category";

  const SubCategoryPage({required this.mainCategoryId});

  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    var categoryNotifier =
        Provider.of<CategoryNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "دسته‌بندی",
        showBasketBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, SubCategoryResultModel>>(
        future: categoryNotifier.customerCategoryRepo.subCategories(
          mainCategoryId: mainCategoryId,
        ),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => Txt(
              left.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (right) => SubCategoryList(
              subCategories: right.data!,
              categoryNotifier: categoryNotifier,
            ),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ),
    );
  }
}
