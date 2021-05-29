// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/wallet_notifier.dart';
import 'widgets/withdrawal_request_list.dart';

class WalletWithdrawalRequestsPage extends StatelessWidget {
  static const route = "/wallet_withdrawal_requests_page";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketWalletNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchWithDrawalRequestsCalled) {
          provider.fetchWithDrawalRequests(context);
        }

        return provider.detailsLoading
            ? Center(child: AppLoading())
            : provider.withdrawalRequests == null
                ? provider.withdrawalErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.withdrawalErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WithdrawalRequestList(
                          withdrawalRequests: provider.withdrawalRequests!,
                        ),
                        if (provider.withdrawalEnableLoadMoreData!)
                          LoadMoreBtn(onTap: () {
                            provider.fetchWithDrawalRequests(context);
                          }),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).walletWithdrawalRequests,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
