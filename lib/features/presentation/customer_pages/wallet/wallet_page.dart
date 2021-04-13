// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/wallet_notifier.dart';
import '../wallet_charge/charge_wallet_page.dart';
import 'transaction_list.dart';

class WalletPage extends StatelessWidget {
  static const route = "/customer_wallet";

  @override
  Widget build(BuildContext context) {
    var walltInfoConsumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        if (provider.walletInfoResultModel == null) {
          provider.fetchWalletInfo();
        }

        return provider.infoLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.walletInfoResultModel == null
                ? provider.infoErrorMsg == null
                    ? Txt(
                        "خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : Txt(
                        provider.infoErrorMsg!,
                        style: AppTxtStyles().body..alignment.center(),
                      )
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
                          "${intl.NumberFormat("#,000").format(provider.walletInfoResultModel!.data.balance)}",
                          style: AppTxtStyles().title
                            ..bold()
                            ..alignment.center(),
                        ),
                        SizedBox(height: 16),
                        ActionBtn(
                          text: "افزودن موجودی",
                          onTap: () {
                            Routes.sailor(ChargeWalletPage.route);
                          },
                          background: AppTheme.customerPrimary,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  );
      },
    );

    var walltDetailConsumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        if (provider.walletDetailList == null) {
          provider.walletDetail();
        }

        return provider.detailLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.walletDetailList == null
                ? provider.detailErrorMsg == null
                    ? Txt("لیست تراکنش‌های شما خالی است",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.detailErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TransactionList(walletDetail: provider.walletDetailList!),
                      const SizedBox(height: 8),
                      if (provider.enableLoadMoreData!)
                        LoadMoreBtn(onTap: () {
                          provider.walletDetail();
                        })
                    ],
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "کیف پول من",
        showBackBtn: true,
      ),
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
}
