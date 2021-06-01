// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../delivery_providers/profile_notifier.dart';
import '../../delivery_providers/wallet_notifier.dart';
import '../../market_providers/wallet_notifier.dart';

class WithdrawalWalletPage extends StatefulWidget {
  static const route = "/delivery_wallet_withdrawal";

  @override
  _WithdrawalWalletPageState createState() => _WithdrawalWalletPageState();
}

class _WithdrawalWalletPageState extends State<WithdrawalWalletPage> {
  GlobalKey? formKey = GlobalKey<FormState>();

  late TextEditingController amountCtrl;
  late TextEditingController descriptionCtrl;
  late TextEditingController shabaCtrl;

  String errorTxt = "";
  bool errorVisibility = false;

  DeliveryProfileNotifier? profileNotifier;
  DeliveryWalletNotifier? walletNotifier;

  @override
  void initState() {
    super.initState();
    amountCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    shabaCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    profileNotifier ??=
        Provider.of<DeliveryProfileNotifier>(context, listen: false);

    walletNotifier ??=
        Provider.of<DeliveryWalletNotifier>(context, listen: false);

    shabaCtrl = TextEditingController(
        // text: "${profileNotifier!.shabaNumber ?? ""}",
        );

    var consumer = Consumer<MarketWalletNotifier>(
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
                  label: Lang.of(context).cost,
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  controller: descriptionCtrl,
                  validator: AppValidators.description,
                  label: Lang.of(context).description,
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                AbsorbPointer(
                  absorbing: true,
                  child: CustomTextInput(
                    controller: shabaCtrl,
                    validator: AppValidators.numeric,
                    label: Lang.of(context).marketProfileShabaNumber,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16),
                ActionBtn(
                  text: Lang.of(context).submit,
                  onTap: _submitOnTap,
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
        text: Lang.of(context).walletWithdrawal,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }

  void _submitOnTap() async {
    if ((formKey!.currentState as FormState).validate()) {
      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var withdrawalReqResult =
          await walletNotifier!.deliveryWalletRepo.withdrawalRequest(
        amount: double.parse(amountCtrl.text),
        description: descriptionCtrl.text,
      );

      prgDialog.hide();

      withdrawalReqResult.fold(
        (left) {
          setState(() {
            errorTxt = left.message;
            errorVisibility = true;
          });
        },
        (right) async {
          walletNotifier!.refresh(context);
          Routes.sailor.pop();
        },
      );
    }
  }
}
