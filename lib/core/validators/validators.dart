import '../utils/is_numeric.dart';

class AppValidators {
  static String? name(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 نام کاربری الزامی است";

    return emptyCondition ? emptyTxt : null;
  }

  static String? address(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 آدرس الزامی است";

    return emptyCondition ? emptyTxt : null;
  }

  static String? description(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 توضیحات الزامی است";

    return emptyCondition ? emptyTxt : null;
  }

  static String? phone(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 شماره موبایل الزامی است";

    bool errorCondition = value.trim().length != 11 || !value.startsWith("09");
    String errorTxt = "\u26b9 شماره موبایل نامعتبر است";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }

  static String? email(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 ایمیل الزامی است";

    bool errorCondition = !value.contains(".") || !value.contains("@");
    String errorTxt = "\u26b9 ایمیل نامعتبر است";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }

  static String? numeric(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 مبلغ وارد شده نامعتبر است";

    return emptyCondition ? emptyTxt : null;
  }

  static String? shaba(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 شماره شبا الزامی است";

    bool errorCondition = !value.isNumeric();
    String errorTxt = "\u26b9 شماره شبا نامعتبر است";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }

  static String? pass(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 رمز عبور الزامی است";

    bool errorCondition = value.trim().length < 4;
    String errorTxt = "\u26b9 رمز عبور باید شامل ۴ عدد باشد";

    return emptyCondition
        ? emptyTxt
        : errorCondition
            ? errorTxt
            : null;
  }

  static String? comment(String? value) {
    bool emptyCondition = value!.trim().isEmpty;
    String emptyTxt = "\u26b9 متن نظر الزامی است";

    return emptyCondition ? emptyTxt : null;
  }
}
