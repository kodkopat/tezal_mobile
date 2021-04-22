enum AppUserType {
  Customer,
  Market,
  Delivery,
}

class AppUserTypeParser {
  static const _customerKey = "customer";
  static const _marketKey = "market";
  static const _deliveryKey = "delivery";

  static AppUserType fromString(String userType) {
    if (userType.trim().isEmpty) return AppUserType.Customer;

    switch (userType.toLowerCase()) {
      case _customerKey:
        return AppUserType.Customer;
      case _marketKey:
        return AppUserType.Market;
      case _deliveryKey:
        return AppUserType.Delivery;
      default:
        return AppUserType.Customer;
    }
  }
}
