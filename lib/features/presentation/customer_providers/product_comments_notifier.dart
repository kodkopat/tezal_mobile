import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/customer/add_edit_comment_rate_result_model.dart';
import '../../data/models/customer/comments_result_model.dart';
import '../../data/repositories/customer_product_repository.dart';

// tip: this class must not be a singleton
// because it used for any object of ProductListItem
// then, when it used as singleton in dispose method of
// widgets, this object will be gone!
class ProductCommentsNotifier extends ChangeNotifier {
  ProductCommentsNotifier(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;

  bool wasFetchCommentsCalled = false;
  bool loading = true;
  String? errorMsg;

  int skip = 0;
  int take = 10;
  int? totalCount;
  bool? enableLoadMoreOption;

  List<Comment>? comments;

  Future<void> fetchComments(
    BuildContext context, {
    required String productId,
  }) async {
    if (!wasFetchCommentsCalled) {
      wasFetchCommentsCalled = true;
      notifyListeners();
    }

    if (totalCount == null) {
      var result = await customerProductRepo.getComments(
        productId: productId,
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          totalCount = right.data!.totalCount;
          comments = right.data!.comments;
          enableLoadMoreOption = totalCount != comments!.length;
          skip += take;
        },
      );

      loading = false;
    } else {
      if (totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await customerProductRepo.getComments(
        productId: productId,
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          comments!.addAll(right.data!.comments!);
          enableLoadMoreOption = totalCount != comments!.length;
          skip += take;
        },
      );

      print("commentsListLength: ${comments!.length}\n");
      prgDialog.hide();
    }

    notifyListeners();
  }

  String? addEditCommentRateErrorMsg;
  AddEditCommentRateResultModel? addEditCommentRateResult;

  Future<void> addEditCommentRate(
    BuildContext context, {
    required String comment,
    required String marketProductId,
    required String orderId,
    required int rate,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await customerProductRepo.addEditCommentRate(
      comment: comment,
      marketProductId: marketProductId,
      orderId: orderId,
      rate: rate,
    );

    result.fold(
      (left) => addEditCommentRateErrorMsg = left.message,
      (right) => addEditCommentRateResult = right,
    );

    prgDialog.hide();

    notifyListeners();
  }
}
