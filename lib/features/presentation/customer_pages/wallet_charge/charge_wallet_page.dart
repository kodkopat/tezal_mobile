// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../customer_providers/wallet_notifier.dart';

class ChargeWalletPage extends StatefulWidget {
  static const route = "/customer_charge_wallet";

  @override
  _ChargeWalletPageState createState() => _ChargeWalletPageState();
}

class _ChargeWalletPageState extends State<ChargeWalletPage> {
  GlobalKey? formKey = GlobalKey<FormState>();
  CustomerWalletNotifier? walletNotifier;
  TextEditingController amountCtrl = TextEditingController();
  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog? prgDialog;

  @override
  void initState() {
    super.initState();
    prgDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
    )..style(
        message: "لطفا کمی صبر کنید",
        textAlign: TextAlign.start,
      );
  }

  @override
  Widget build(BuildContext context) {
    walletNotifier ??=
        Provider.of<CustomerWalletNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "شارژ کیف پول",
        showBackBtn: true,
      ),
      body: Form(
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
              ActionBtn(
                text: "ثبت",
                onTap: () async {
                  if ((formKey!.currentState as FormState).validate()) {
                    prgDialog!.show();

                    var loadBalanceResult =
                        await walletNotifier!.customerWalletRepo.loadBalance(
                      amount: double.parse(amountCtrl.text),
                    );

                    prgDialog!.hide();

                    loadBalanceResult.fold(
                      (left) {
                        setState(() {
                          errorTxt = left.message;
                          errorVisibility = true;
                        });
                      },
                      (right) async {
                        var confirmLoadBalanceResult = await walletNotifier!
                            .customerWalletRepo
                            .loadBalanceConfirmation(
                          id: right.data.transactionId,
                        );

                        confirmLoadBalanceResult.fold(
                          (left) {
                            setState(() {
                              errorTxt = left.message;
                              errorVisibility = true;
                            });
                          },
                          (right) {
                            walletNotifier!.refresh();
                            Routes.sailor.pop();
                          },
                        );
                      },
                    );
                  }
                },
              ),
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
      ),
    );
  }
}
