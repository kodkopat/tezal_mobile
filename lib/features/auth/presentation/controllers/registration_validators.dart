class AuthValidators {
  static String name(String value) {
    bool emptyCondition = value.trim().isEmpty;
    String emptyTxt = "\u26b9 نام کاربری الزامی است";

    return emptyCondition ? emptyTxt : null;
  }

  static String phone(String value) {
    bool emptyCondition = value.trim().isEmpty;
    String emptyTxt = "\u26b9 شماره موبایل الزامی است";

    bool errorCondition = value.trim().length != 11 && !value.startsWith("09");
    String errorTxt = "\u26b9 شماره موبایل نامعتبر است";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }

  static String pass(String value) {
    bool emptyCondition = value.trim().isEmpty;
    String emptyTxt = "\u26b9 رمز عبور الزامی است";

    bool errorCondition = value.trim().length < 4;
    String errorTxt = "\u26b9 رمز عبور باید بیشتر از ۴ حرف باشد";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }
}
