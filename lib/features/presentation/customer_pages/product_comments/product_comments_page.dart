// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart' hide State;
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/comments_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';

class ProductCommentsPage extends StatefulWidget {
  static const route = "/customer_product_comments";

  ProductCommentsPage({required this.productId});

  final String productId;
  final _customerProductRepo = CustomerProductRepository();

  @override
  _ProductCommentsPageState createState() => _ProductCommentsPageState();
}

class _ProductCommentsPageState extends State<ProductCommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظرات کاربران",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
        future: widget._customerProductRepo.productComments(
          productId: widget.productId,
          page: 1,
        ),
        successBuilder: (context, data) {
          return data!.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CommentList(
                commentsResultModel: r,
                showAllCommentOnTap: () {},
                enableLoadMore: true,
                enableHeader: false,
              ),
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
