import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/comments_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_widgets/comment_list/comment_list.dart';

class ProductCommentsPage extends StatefulWidget {
  static const route = "/customer_product_comments";

  ProductCommentsPage({
    Key key,
    @required this.productId,
  }) : super(key: key);

  final String productId;
  final _customerProductRepo = CustomerProductRepository();

  @override
  _ProductCommentsPageState createState() => _ProductCommentsPageState();
}

class _ProductCommentsPageState extends State<ProductCommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "نظرات کاربران",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
        future: widget._customerProductRepo.productComments(
          productId: widget.productId,
          // orderBy: "",
          page: 1,
          // pageSize: 10,
        ),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CommentList(
                commentsResultModel: r,
                enableLoadMore: false,
                showAllCommentOnTap: () {},
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
