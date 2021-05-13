// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/wallet_notifier.dart';

class WithdrawalWalletPage extends StatefulWidget {
  static const route = "/market_wallet_withdrawal";

  @override
  _WithdrawalWalletPageState createState() => _WithdrawalWalletPageState();
}

class _WithdrawalWalletPageState extends State<WithdrawalWalletPage> {
  GlobalKey? formKey = GlobalKey<FormState>();

  var amountCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<WalletNotifier>(
      builder: (context, provider, child) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                const SizedBox(height: 24),
                CustomTextInput(
                  controller: amountCtrl,
                  validator: AppValidators.numeric,
                  label: "مبلغ",
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  controller: descriptionCtrl,
                  validator: AppValidators.description,
                  label: "توضیحات",
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                ActionBtn(
                  text: "ثبت",
                  onTap: () async {
                    if ((formKey!.currentState as FormState).validate()) {
                      var prgDialog = AppProgressDialog(context).instance;
                      prgDialog.show();

                      var withdrawalReqResult =
                          await provider.marketWalletRepo.withdrawalRequest(
                        amount: double.parse(amountCtrl.text),
                        description: descriptionCtrl.text,
                      );

                      prgDialog.hide();

                      withdrawalReqResult.fold(
                        (left) {
                          setState(() {
                            errorTxt = left.message;
                            errorVisibility = true;

                            // this method must be deleted from this section
                            provider.refresh(context);
                          });
                        },
                        (right) async {
                          provider.refresh(context);
                          Routes.sailor.pop();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
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
        );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "برداشت وجه از حساب",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
