import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/models/market/product_comments_result_model.dart';
import '../../data/repositories/market_product_repository.dart';

class ProductCommentsNotifier extends ChangeNotifier {
  ProductCommentsNotifier(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  bool wasFetchCommentsCalled = false;
  bool loading = true;
  String? errorMsg;

  int skip = 0;
  int take = 10;
  int? totalCount;
  bool? enableLoadMoreOptions;

  List<ProductComment>? productComments;

  Future<void> fetchComments(BuildContext context,
      {required String marketProductId}) async {
    if (!wasFetchCommentsCalled) {
      wasFetchCommentsCalled = true;
      notifyListeners();
    }

    if (totalCount == null) {
      var result = await marketProductRepo.getProductComments(
        marketProductId: marketProductId,
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          totalCount = right.data!.totalCount;
          productComments = right.data!.result;
          enableLoadMoreOptions = totalCount != productComments!.length;
          skip += take;
        },
      );

      loading = false;
    } else {
      if (totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketProductRepo.getProductComments(
        marketProductId: marketProductId,
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          productComments!.addAll(right.data!.result!);
          enableLoadMoreOptions = totalCount != productComments!.length;
          skip += take;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  String? replyErrorMsg;
  BaseApiResultModel? replyResult;

  Future<void> replyComment(
    BuildContext context, {
    required String commentId,
    required String reply,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketProductRepo.replyProductComments(
      commentId: commentId,
      reply: reply,
    );

    result.fold(
      (left) => replyErrorMsg = left.message,
      (right) => replyResult = right.data,
    );

    prgDialog.hide();
    _refresh(context);
  }

  void _refresh(BuildContext context) async {
    wasFetchCommentsCalled = false;
    loading = true;
    errorMsg = null;
    skip = 0;
    take = 10;
    totalCount = null;
    enableLoadMoreOptions = null;
    productComments = null;

    notifyListeners();
  }
}
