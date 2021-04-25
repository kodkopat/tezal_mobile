// ignore: import_of_legacy_library_into_null_safe
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactsNotifier extends ChangeNotifier {
  static ContactsNotifier? _instance;

  factory ContactsNotifier() {
    if (_instance == null) {
      _instance = ContactsNotifier._privateConstructor();
    }

    return _instance!;
  }

  ContactsNotifier._privateConstructor();

  bool loading = true;
  String? errorMsg;
  Iterable<String>? contacts;

  Future<void> fetchContacts() async {
    // contacts = await ContactsService.getContacts();
    loading = false;
    notifyListeners();
  }
}
