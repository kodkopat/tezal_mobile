// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/wallet_notifier.dart';
import '../wallet_withdrawal/wallet_withdrawal_page.dart';
import '../wallet_withdrawal_requests/wallet_withdrawal_requests_page.dart';
import 'widgets/transaction_list.dart';

class WalletPage extends StatelessWidget {
  static const route = "/market_wallet";

  @override
  Widget build(BuildContext context) {
    var balanceConsumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchBalanceCalled) {
          provider.fetchBalance();
        }

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
                          text: "درخواست برداشت وجه",
                          onTap: () {
                            Routes.sailor(WithdrawalWalletPage.route);
                          },
                        ),
                        SizedBox(height: 16),
                        Txt(
                          "مشاهده درخواست‌های برداشت",
                          gesture: Gestures()
                            ..onTap(() {
                              Routes.sailor(WalletWithdrawalRequestsPage.route);
                            }),
                          style: AppTxtStyles().body
                            ..bold()
                            ..height(47)
                            ..textColor(Theme.of(context).primaryColor)
                            ..alignmentContent.center(true)
                            ..borderRadius(all: 12)
                            ..border(
                              all: 0.5,
                              style: BorderStyle.solid,
                              color: Theme.of(context).primaryColor,
                            )
                            ..ripple(true),
                        ),
                      ],
                    ),
                  );
      },
    );

    var detailsConsumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchDetailsCalled) {
          provider.fetchDetails(context);
        }

        return provider.detailsLoading
            ? Center(child: AppLoading())
            : provider.walletDetails == null
                ? provider.detailsErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.detailsErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TransactionList(walletDetails: provider.walletDetails!),
                      const SizedBox(height: 8),
                      if (provider.detailsEnableLoadMoreData!)
                        LoadMoreBtn(onTap: () {
                          provider.fetchDetails(context);
                        })
                    ],
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(text: "کیف پول من"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            balanceConsumer,
            detailsConsumer,
          ],
        ),
      ),
    );
  }
}
