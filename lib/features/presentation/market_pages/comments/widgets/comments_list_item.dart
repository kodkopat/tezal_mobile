// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/languages/language.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/market_comments_result_model.dart';

class CommentsListItem extends StatelessWidget {
  CommentsListItem({
    required this.comment,
    required this.absorbing,
    required this.onTap,
  });

  final MarketComment comment;
  final bool absorbing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: Parent(
        gesture: Gestures()..onTap(onTap),
        style: ParentStyle()
          ..margin(vertical: 8)
          ..borderRadius(all: 8),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (dismissDirection) async {
            if (dismissDirection == DismissDirection.startToEnd) {
              onTap();
            }
          },
          background: Parent(
            style: ParentStyle()
              ..padding(horizontal: 24)
              ..background.color(Color(0xffEFEFEF))
              ..borderRadius(all: 8)
              ..alignmentContent.centerRight(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ic_send_right.png",
                  color: Colors.black,
                  fit: BoxFit.contain,
                  width: 24,
                  height: 24,
                ),
                SizedBox(height: 4),
                Txt("ارسال بازخورد", style: AppTxtStyles().footNote),
              ],
            ),
          ),
          child: Parent(
            style: ParentStyle()
              ..padding(horizontal: 8, vertical: 16)
              ..background.color(Colors.white)
              ..borderRadius(all: 8)
              ..boxShadow(
                color: Colors.black12,
                offset: Offset(0, 3.0),
                blur: 6,
                spread: 0,
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _fieldRate(context),
                    _fieldDate(context),
                  ],
                ),
                SizedBox(height: 8),
                Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Colors.black12,
                ),
                _fieldComment(context),
                _fieldReply,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldDate(BuildContext context) {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var dateTxt;
    if (comment.createDate == null) {
      dateTxt = "-";
    } else {
      dateTxt = "${(comment.createDate).toString().split(" ")[0]}"
          .replaceAll("-", "/");
    }

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: Lang.of(context).date + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text: dateTxt,
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldRate(BuildContext context) {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var scroeTxt;
    if (comment.rate == null) {
      scroeTxt = "-";
    } else {
      scroeTxt = "${comment.rate}";
    }

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: Lang.of(context).rate + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text: scroeTxt,
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldComment(BuildContext context) {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    if (comment.comment == null) {
      return SizedBox();
    } else {
      return Parent(
        style: ParentStyle()
          ..width(MediaQuery.of(context).size.width)
          ..minHeight(48)
          ..margin(vertical: 8)
          ..background.color(Color(0xffEFEFEF))
          ..padding(horizontal: 8, vertical: 8)
          ..borderRadius(all: 4),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: comment.comment,
                    style: txtStyle,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Parent(
                style: ParentStyle()
                  ..width(4)
                  ..background.color(Colors.black12)
                  ..borderRadius(all: 2),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget get _fieldReply {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    if (comment.reply == null) {
      return SizedBox();
    } else {
      return RichText(
        textAlign: TextAlign.right,
        text: TextSpan(text: comment.reply, style: txtStyle),
      );
    }
  }
}
