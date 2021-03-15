import 'package:flutter/cupertino.dart';
import '../app_localizations.dart';

class Lang {
  BuildContext context;
  Lang(this.context) {
    programName = AppLocalizations.of(context).translate('programName');
    programSlogan = AppLocalizations.of(context).translate('programSlogan');
    home = AppLocalizations.of(context).translate('home');
    search = AppLocalizations.of(context).translate('search');
    basket = AppLocalizations.of(context).translate('basket');
    account = AppLocalizations.of(context).translate('account');
    jobs = AppLocalizations.of(context).translate('jobs');
    order = AppLocalizations.of(context).translate('order');
    commodity = AppLocalizations.of(context).translate('commodity');
    moneyUnit = AppLocalizations.of(context).translate('moneyUnit');
    distance = AppLocalizations.of(context).translate('distance');
    kiloMeter = AppLocalizations.of(context).translate('kiloMeter');
    ok = AppLocalizations.of(context).translate('ok');
    cancel = AppLocalizations.of(context).translate('cancel');
    error = AppLocalizations.of(context).translate('error');
    address = AppLocalizations.of(context).translate('address');
    errorOccurred = AppLocalizations.of(context).translate('errorOccurred');
    products = AppLocalizations.of(context).translate('products');
    yourBasketEmpty = AppLocalizations.of(context).translate('yourBasketEmpty');
    startBuying = AppLocalizations.of(context).translate('startBuying');
    userpage = AppLocalizations.of(context).translate('userpage');
    version = AppLocalizations.of(context).translate("version");
    exit = AppLocalizations.of(context).translate("exit");
    totalPrice = AppLocalizations.of(context).translate("totalPrice");
    totalDiscount = AppLocalizations.of(context).translate("totalDiscount");
    deliveryCost = AppLocalizations.of(context).translate("deliveryCost");
    payable = AppLocalizations.of(context).translate("payable");
    continu = AppLocalizations.of(context).translate("continue");
    pay = AppLocalizations.of(context).translate("pay");
    invoice = AppLocalizations.of(context).translate("invoice");
    userInformation = AppLocalizations.of(context).translate("userInformation");
    name = AppLocalizations.of(context).translate("name");
    phone = AppLocalizations.of(context).translate("phone");
    email = AppLocalizations.of(context).translate("email");
    note = AppLocalizations.of(context).translate("note");
    categories = AppLocalizations.of(context).translate("categories");
    discountedPrice = AppLocalizations.of(context).translate("discountedPrice");
    loginWelcomeText =
        AppLocalizations.of(context).translate("loginWelcomeText");
    loginWelcomeInformation =
        AppLocalizations.of(context).translate("loginWelcomeInformation");
    loginPhone = AppLocalizations.of(context).translate("loginPhone");
    loginPass = AppLocalizations.of(context).translate("loginPass");
    loginPhoneHint = AppLocalizations.of(context).translate("loginPhoneHint");
    loginPass = AppLocalizations.of(context).translate("loginPass");
    loginPassHint = AppLocalizations.of(context).translate("loginPassHint");
    login = AppLocalizations.of(context).translate("login");
    register = AppLocalizations.of(context).translate("register");
    loginProgress = AppLocalizations.of(context).translate("loginProgress");
    searchHistory = AppLocalizations.of(context).translate("searchHistory");
    clear = AppLocalizations.of(context).translate("clear");
    typeProductName = AppLocalizations.of(context).translate("typeProductName");
    setNoteForOrder = AppLocalizations.of(context).translate("setNoteForOrder");
    market = AppLocalizations.of(context).translate("market");
    deliveryAddress = AppLocalizations.of(context).translate("deliveryAddress");
    newAddress = AppLocalizations.of(context).translate("newAddress");
    paymentType = AppLocalizations.of(context).translate("paymentType");
    online = AppLocalizations.of(context).translate("online");
    pos = AppLocalizations.of(context).translate("pos");
    cash = AppLocalizations.of(context).translate("cash");
    wallet = AppLocalizations.of(context).translate("wallet");
    paymentType = AppLocalizations.of(context).translate("wallet");
    payWithCardOnline =
        AppLocalizations.of(context).translate("payWithCardOnline");
    payWithPos = AppLocalizations.of(context).translate("payWithPos");
    payWithCash = AppLocalizations.of(context).translate("payWithCash");
    payWithWallet = AppLocalizations.of(context).translate("payWithWallet");
    orderSuccessfully =
        AppLocalizations.of(context).translate("orderSuccessfully");
    continueShopping =
        AppLocalizations.of(context).translate("continueShopping");
    westAzerbaijan = AppLocalizations.of(context).translate("westAzerbaijan");
    urmia = AppLocalizations.of(context).translate("urmia");
    province = AppLocalizations.of(context).translate("province");
    city = AppLocalizations.of(context).translate("city");
    description = AppLocalizations.of(context).translate("description");
    isdefault = AppLocalizations.of(context).translate("default");
    save = AppLocalizations.of(context).translate("save");
    profile = AppLocalizations.of(context).translate("profile");
    privateInfo = AppLocalizations.of(context).translate("privateInfo");
    marketInfo = AppLocalizations.of(context).translate("marketInfo");
    previousOrders = AppLocalizations.of(context).translate("previousOrders");
    aboutUs = AppLocalizations.of(context).translate("aboutUs");
    invalidMail = AppLocalizations.of(context).translate("invalidMail");
    invalidName = AppLocalizations.of(context).translate("invalidName");
    marketProducts = AppLocalizations.of(context).translate("marketProducts");
    marketAddProducts =
        AppLocalizations.of(context).translate("marketAddProducts");
    question = AppLocalizations.of(context).translate("question");
    deleteQuestion = AppLocalizations.of(context).translate("deleteQuestion");
    productDetail = AppLocalizations.of(context).translate("productDetail");
  }
  String programName;
  String programSlogan;
  String home;
  String search;
  String basket;
  String account;
  String jobs;
  String order;
  String commodity;
  String moneyUnit;
  String distance;
  String kiloMeter;
  String ok;
  String cancel;
  String error;
  String errorOccurred;
  String products;
  String yourBasketEmpty;
  String startBuying;
  String userpage;
  String version;
  String address;
  String exit;
  String invoice;
  String totalPrice;
  String totalDiscount;
  String deliveryCost;
  String payable;
  String continu;
  String pay;
  String userInformation;
  String name;
  String phone;
  String email;
  String discountedPrice;
  String loginWelcomeText;
  String loginWelcomeInformation;
  String loginPhone;
  String loginPhoneHint;
  String loginPass;
  String loginPassHint;
  String login;
  String register;
  String loginProgress;
  String note;
  String setNoteForOrder;
  String categories;
  String searchHistory;
  String clear;
  String typeProductName;
  String market;
  String deliveryAddress;
  String newAddress;
  String paymentType;
  String online;
  String pos;
  String cash;
  String wallet;
  String payWithCardOnline;
  String payWithPos;
  String payWithCash;
  String payWithWallet;
  String orderSuccessfully;
  String continueShopping;
  String westAzerbaijan;
  String urmia;
  String province;
  String city;
  String description;
  String isdefault;
  String save;
  String profile;
  String privateInfo;
  String marketInfo;
  String previousOrders;
  String aboutUs;
  String invalidMail;
  String invalidName;
  String marketProducts;
  String marketAddProducts;
  String question;
  String deleteQuestion;
  String productDetail;
}
