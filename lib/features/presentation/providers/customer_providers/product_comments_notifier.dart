import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/customer/comments_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';

// tip: this class must not be a singleton
// because it used for any object of ProductListItem
// then, when it used as singleton in dispose method of
// widgets, this object will be gone!
class ProductCommentsNotifier extends ChangeNotifier {
  ProductCommentsNotifier(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;

  bool productCommentsLoading = true;
  String? productCommentsErrorMsg;

  bool? enableLoadMoreData;
  int? productCommentsTotalCount;
  int? latestPageIndex;
  List<Comment>? productComments;

  Future<void> fetchProductComments(
    BuildContext context, {
    required String productId,
  }) async {
    if (productCommentsTotalCount == null) {
      var result = await customerProductRepo.productComments(
        productId: productId,
        page: 1,
      );

      result.fold(
        (left) => productCommentsErrorMsg = left.message,
        (right) {
          print("commentResult: ${right.toJson()}\n");
          productCommentsTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          productComments = right.data!.comments!;
          enableLoadMoreData =
              productCommentsTotalCount != productComments!.length;
        },
      );
      productCommentsLoading = false;
    } else {
      if (productCommentsTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await customerProductRepo.productComments(
        productId: productId,
        page: latestPageIndex! + 1,
      );

      result.fold(
        (left) => productCommentsErrorMsg = left.message,
        (right) {
          productCommentsTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          productComments!.addAll(right.data!.comments!);
          enableLoadMoreData =
              productCommentsTotalCount != productComments!.length;
        },
      );

      prgDialog.hide();
    }
    notifyListeners();
  }
}
