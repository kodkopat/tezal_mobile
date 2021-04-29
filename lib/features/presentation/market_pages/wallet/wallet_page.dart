// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../data/models/customer/wallet_detail_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  static const route = "/market_wallet";

  @override
  Widget build(BuildContext context) {
    // var walltInfoConsumer = Consumer<WalletNotifier>(
    //   builder: (context, provider, child) {
    //     if (provider.walletInfoResultModel == null) {
    //       provider.fetchWalletInfo();
    //     }

    //     return provider.infoLoading
    //         ? AppLoading()
    //         : provider.walletInfoResultModel == null
    //             ? provider.infoErrorMsg == null
    //                 ? Txt("خطای بارگذاری اطلاعات",
    //                     style: AppTxtStyles().body..alignment.center())
    //                 : Txt(provider.infoErrorMsg!,
    //                     style: AppTxtStyles().body..alignment.center())
    //             : Parent(
    //                 style: ParentStyle()..padding(all: 24),
    //                 child: Column(
    //                   textDirection: TextDirection.rtl,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Txt(
    //                       "موجودی کیف پول",
    //                       style: AppTxtStyles().footNote..alignment.center(),
    //                     ),
    //                     Txt(
    //                       "${intl.NumberFormat("#,000").format(provider.walletInfoResultModel!.data.balance)}",
    //                       style: AppTxtStyles().title
    //                         ..bold()
    //                         ..alignment.center(),
    //                     ),
    //                     SizedBox(height: 16),
    //                     ActionBtn(
    //                       text: "افزودن موجودی",
    //                       onTap: () {
    //                         // Routes.sailor(ChargeWalletPage.route);
    //                       },
    //                       background: AppTheme.customerPrimary,
    //                       textColor: Colors.white,
    //                     ),
    //                   ],
    //                 ),
    //               );
    //   },
    // );
    var walltInfoConsumer = Parent(
      style: ParentStyle()..padding(all: 24),
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Txt(
            "موجودی کیف پول",
            style: AppTxtStyles().footNote..alignment.center(),
          ),
          Txt(
            "${intl.NumberFormat("#,000").format(20000)}",
            style: AppTxtStyles().title
              ..bold()
              ..alignment.center(),
          ),
          SizedBox(height: 16),
          ActionBtn(
            text: "افزودن موجودی",
            onTap: () {
              // Routes.sailor(ChargeWalletPage.route);
            },
          ),
        ],
      ),
    );

    // var walltDetailConsumer = Consumer<WalletNotifier>(
    //   builder: (context, provider, child) {
    //     if (provider.walletDetailList == null) {
    //       provider.walletDetail();
    //     }

    //     return provider.detailLoading
    //         ? AppLoading()
    //         : provider.walletDetailList == null
    //             ? provider.detailErrorMsg == null
    //                 ? Txt("لیست تراکنش‌های شما خالی است",
    //                     style: AppTxtStyles().body..alignment.center())
    //                 : Txt(provider.detailErrorMsg,
    //                     style: AppTxtStyles().body..alignment.center())
    //             : Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   TransactionList(walletDetail: provider.walletDetailList!),
    //                   const SizedBox(height: 8),
    //                   if (provider.enableLoadMoreData!)
    //                     LoadMoreBtn(onTap: () {
    //                       provider.walletDetail();
    //                     })
    //                 ],
    //               );
    //   },
    // );
    var walltDetailConsumer = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TransactionList(
          walletDetail: [
            Detail(
              date: "1399/10/10",
              action: "پرداخت",
              amount: 20000,
              description: "توضیحات",
            ),
            Detail(
              date: "1399/10/10",
              action: "پرداخت",
              amount: 20000,
              description: "توضیحات",
            ),
            Detail(
              date: "1399/10/10",
              action: "پرداخت",
              amount: 20000,
              description: "توضیحات",
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(text: "کیف پول من"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            walltInfoConsumer,
            walltDetailConsumer,
          ],
        ),
      ),
    );
  }

  // return Scaffold(
  //   appBar: SimpleAppBar(context).create(
  //     text: "کیف پول",
  //   ),
  // );
}
