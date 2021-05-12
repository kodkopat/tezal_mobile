import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/repositories/shared_application_repository.dart';

class ContactsNotifier extends ChangeNotifier {
  static ContactsNotifier? _instance;

  factory ContactsNotifier(SharedApplicationRepository sharedApplicationRepo) {
    if (_instance == null) {
      _instance = ContactsNotifier._privateConstructor(sharedApplicationRepo);
    }

    return _instance!;
  }

  ContactsNotifier._privateConstructor(this.sharedApplicationRepo);

  final SharedApplicationRepository sharedApplicationRepo;

  bool loading = true;
  String? errorMsg;
  List<Contact>? contacts;

  Future<void> fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
      print("contactsLength: ${contacts!.length}\n");

      var contactsTemp = <Contact>[];

      contacts!.forEach((element) {
        if (element.phones.isEmpty) {
          // remove contact that have no any phone number
        } else if (element.phones.length > 1) {
          // split contact that have more than one phone number
          for (int i = 0; i < element.phones.length; i++) {
            contactsTemp.add(
              Contact(
                name: element.name,
                displayName: element.displayName,
                phones: [element.phones[i]],
              ),
            );
          }
        } else {
          contactsTemp.add(element);
        }
      });

      contacts = contactsTemp;

      loading = false;
      notifyListeners();
    }
  }

  String? shareErrorMsg;
  BaseApiResultModel? shareResult;

  Future<void> shareApplication({
    required BuildContext context,
    required List<String> contactsJson,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await sharedApplicationRepo.share(
      contactNumbers: contactsJson,
    );

    result.fold(
      (left) => shareErrorMsg = left.message,
      (right) => shareResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }
}
