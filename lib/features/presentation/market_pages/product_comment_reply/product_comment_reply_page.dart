// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/market/product_comments_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/product_comments_notifier.dart';
import '../product_comments/widgets/product_comments_list_item.dart';

class ProductCommentReplyPage extends StatefulWidget {
  static const route = "/market_product_comment_reply";

  ProductCommentReplyPage({required this.productComment});

  final ProductComment productComment;

  @override
  _ProductCommentReplyPageState createState() =>
      _ProductCommentReplyPageState();
}

class _ProductCommentReplyPageState extends State<ProductCommentReplyPage> {
  GlobalKey formKey = GlobalKey<FormState>();

  final commentBoxTxtCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "نظر شما",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ProductCommentsListItem(
                comment: widget.productComment,
                onTap: () {},
              ),
              SizedBox(height: 4),
              CustomTextInput(
                label: "نظر کاربر",
                controller: commentBoxTxtCtrl,
                validator: AppValidators.comment,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                maxLine: 3,
              ),
              SizedBox(height: 16),
              ActionBtn(
                text: "ثبت بازخورد",
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    var productCommentsNotifier =
                        Provider.of<ProductCommentsNotifier>(context,
                            listen: false);

                    await productCommentsNotifier.replyComment(
                      context,
                      commentId: widget.productComment.id,
                      reply: commentBoxTxtCtrl.text,
                    );

                    if (productCommentsNotifier.replyErrorMsg != null) {
                      setState(() {
                        errorTxt = productCommentsNotifier.replyErrorMsg!;
                        errorVisibility = true;
                      });
                    } else {
                      Routes.sailor.pop();
                    }
                  }
                },
              ),
              SizedBox(height: 16),
              Visibility(
                visible: errorVisibility,
                child: Txt(
                  errorTxt,
                  style: AppTxtStyles().footNote.clone()
                    ..textColor(Theme.of(context).errorColor)
                    ..alignmentContent.center()
                    ..height(24)
                    ..borderRadius(all: 2)
                    ..padding(horizontal: 4)
                    ..ripple(true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
