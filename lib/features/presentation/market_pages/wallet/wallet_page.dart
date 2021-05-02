// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/customer/wallet_detail_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/wallet_notifier.dart';
import 'widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  static const route = "/market_wallet";

  @override
  Widget build(BuildContext context) {
    var walletNotifier = Provider.of<WalletNotifier>(context, listen: false);
    walletNotifier.fetchBalance();

    var balanceConsumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        return provider.walletLoading
            ? AppLoading()
            : provider.walletResult == null
                ? provider.walletErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.walletErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Parent(
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
                          "${intl.NumberFormat("#,000").format(provider.walletResult!.data!.balance)}",
                          style: AppTxtStyles().title
                            ..bold()
                            ..alignment.center(),
                        ),
                        SizedBox(height: 16),
                        ActionBtn(
                          text: "واریز وجه به حساب",
                          onTap: () {
                            // Routes.sailor(ChargeWalletPage.route);
                          },
                        ),
                      ],
                    ),
                  );
      },
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
            balanceConsumer,
            walltDetailConsumer,
          ],
        ),
      ),
    );
  }
}
