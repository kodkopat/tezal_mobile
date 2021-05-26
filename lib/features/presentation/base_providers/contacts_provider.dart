import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/repositories/shared_application_repository.dart';

class ContactsStateNotifier extends ChangeNotifier {
  ContactsStateNotifier(this.sharedApplicationRepo);

  final SharedApplicationRepository sharedApplicationRepo;

  bool wasFetchContactsCalled = false;
  bool contactsLoading = true;
  String? contactsErrorMsg;

  int contactsSkip = 0;
  int contactsTake = 10;
  int? contactsTotalCount;
  bool? contactsEnableLoadMoreData;
  List<Contact> allContacts = [];
  List<Contact>? paginatedContacts;

  Future<void> fetchContacts(BuildContext context) async {
    if (await FlutterContacts.requestPermission()) {
      if (!wasFetchContactsCalled) {
        wasFetchContactsCalled = true;
        notifyListeners();
      }

      if (contactsTotalCount == null) {
        var result = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: false,
        );

        result.forEach((element) {
          if (element.phones.isEmpty) {
            // remove contact that have no any phone number
          } else if (element.phones.length > 1) {
            // split contact that have more than one phone number
            for (int i = 0; i < element.phones.length; i++) {
              allContacts.add(
                Contact(
                  name: element.name,
                  displayName: element.displayName,
                  phones: [element.phones[i]],
                ),
              );
            }
          } else {
            allContacts.add(element);
          }
        });

        contactsTotalCount = allContacts.length;
        paginatedContacts =
            allContacts.sublist(contactsSkip, contactsSkip + contactsTake);
        contactsEnableLoadMoreData =
            contactsTotalCount != paginatedContacts!.length;
        contactsSkip += contactsTake;

        contactsLoading = false;
        notifyListeners();
      } else {
        if (contactsTotalCount == 0) return;

        var prgDialog = AppProgressDialog(context).instance;
        await prgDialog.show();

        if (allContacts.length - paginatedContacts!.length >= contactsTake) {
          paginatedContacts!.addAll(
              allContacts.sublist(contactsSkip, contactsSkip + contactsTake));
        } else {
          paginatedContacts!.addAll(allContacts.sublist(contactsSkip,
              contactsSkip + allContacts.length - paginatedContacts!.length));
        }

        contactsEnableLoadMoreData =
            contactsTotalCount != paginatedContacts!.length;

        print("contactsTotalCount: $contactsTotalCount\n");
        print("paginatedContactsCount: ${paginatedContacts!.length}\n");

        contactsSkip += contactsTake;

        await prgDialog.hide();

        notifyListeners();
      }
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

final contactsProvider = ChangeNotifierProvider(
  (ref) => ContactsStateNotifier(
    SharedApplicationRepository(),
  ),
);

// final contactsFutureProvider = FutureProvider.autoDispose((ref) async {
//   var provider = ref.read(contactsProvider);
//   return provider.fetchContacts();
// });
