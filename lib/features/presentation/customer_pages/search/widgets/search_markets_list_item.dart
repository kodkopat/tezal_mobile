import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/search_result_model.dart';
import '../../../../data/repositories/customer_market_repository.dart';

class SearchResultListItem extends StatelessWidget {
  const SearchResultListItem({
    Key key,
    @required this.market,
    @required this.onTap,
    @required this.repository,
  }) : super(key: key);

  final Market market;
  final void Function() onTap;
  final CustomerMarketRepository repository;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, top: 8, bottom: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                "${market.name}",
                style: AppTxtStyles().heading..bold(),
              ),
              SizedBox(height: 4),
              Txt(
                "${market.products}",
                style: AppTxtStyles().heading..bold(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
