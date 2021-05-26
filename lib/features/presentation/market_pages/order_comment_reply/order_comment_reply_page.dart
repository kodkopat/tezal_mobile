// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/market/order_comments_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/order_comments_notifier.dart';
import '../order_comments/widgets/order_comments_list_item.dart';

class OrderCommentReplyPage extends StatefulWidget {
  static const route = "/market_order_comment_reply";

  OrderCommentReplyPage({required this.orderComment});

  final OrderComment orderComment;

  @override
  _OrderCommentReplyPageState createState() => _OrderCommentReplyPageState();
}

class _OrderCommentReplyPageState extends State<OrderCommentReplyPage> {
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
              OrderCommentsListItem(
                comment: widget.orderComment,
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
                    var commentsNotifier = Provider.of<OrderCommentsNotifier>(
                        context,
                        listen: false);

                    await commentsNotifier.replyComment(
                      context,
                      commentId: widget.orderComment.id,
                      reply: commentBoxTxtCtrl.text,
                    );

                    if (commentsNotifier.replyErrorMsg != null) {
                      setState(() {
                        errorTxt = commentsNotifier.replyErrorMsg!;
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
