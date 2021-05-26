import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/repositories/shared_application_repository.dart';

class ContactsStateNotifier extends StateNotifier {
  ContactsStateNotifier(this.sharedApplicationRepo)
      : super(sharedApplicationRepo);

  final SharedApplicationRepository sharedApplicationRepo;

  Future<List<Contact>?> fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      var contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      var contactsTemp = <Contact>[];

      contacts.forEach((element) {
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
      print("contactsLength: ${contactsTemp.length}\n");
      return contactsTemp;
    } else {
      return null;
    }
  }

  String? shareErrorMsg;
  BaseApiResultModel? shareResult;

  Future<void> shareApplication(
    BuildContext context, {
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
  }
}

final contactsProvider = Provider(
  (ref) => ContactsStateNotifier(
    SharedApplicationRepository(),
  ),
);

final contactsFutureProvider = FutureProvider.autoDispose((ref) async {
  var provider = ref.read(contactsProvider);
  return provider.fetchContacts();
});
