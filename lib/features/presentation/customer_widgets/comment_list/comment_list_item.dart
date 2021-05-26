// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../data/models/customer/comments_result_model.dart';

class CommentListItem extends StatelessWidget {
  CommentListItem({
    required this.comment,
    required this.onTap,
  });

  final Comment comment;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
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
              _fieldUserName,
              _fieldScore,
            ],
          ),
          Divider(
            height: 16,
            thickness: 0.5,
            color: Colors.black12,
          ),
          _fieldComment,
          SizedBox(height: 8),
          _fieldDate,
        ],
      ),
    );
  }

  Widget get _fieldDate {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var dateTxt;
    if (comment.date == null) {
      dateTxt = " ذکر نشده ";
    } else {
      dateTxt = "${(comment.date).toString().split(" ")[0]}";
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: "تاریخ" + ": ",
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

  Widget get _fieldUserName {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var usernameTxt;
    if (comment.customerName == null) {
      usernameTxt = " ذکر نشده ";
    } else {
      usernameTxt = comment.customerName;
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: "کاربر" + ": ",
            style: txtStyle,
          ),
          TextSpan(
            text: usernameTxt,
            style: txtStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldScore {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var scroeTxt;
    if (comment.rate == null) {
      scroeTxt = " ذکر نشده ";
    } else {
      scroeTxt = "${comment.rate}";
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: "امتیاز" + ": ",
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

  Widget get _fieldComment {
    var txtStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    var commentTxt;
    if (comment.comment == null) {
      commentTxt = " ذکر نشده ";
    } else {
      commentTxt = comment.comment;
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(text: commentTxt, style: txtStyle),
    );
  }
}
