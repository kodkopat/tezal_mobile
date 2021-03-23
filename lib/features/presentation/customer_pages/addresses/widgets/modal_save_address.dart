import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text_input.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/simple_app_bar.dart';
import '../../../../data/models/cities_result_model.dart';
import '../../../../data/models/provinces_result_model.dart';
import '../../../../data/repositories/customer_address_repository.dart';

class SaveAddressModal extends StatefulWidget {
  const SaveAddressModal({
    Key key,
    @required this.customerAddressRepo,
  }) : super(key: key);

  final CustomerAddressRepository customerAddressRepo;

  @override
  _SaveAddressModalState createState() => _SaveAddressModalState();
}

class _SaveAddressModalState extends State<SaveAddressModal> {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  String selectedProvinceId;
  List<Province> provincesList;
  List<String> provincesDropDownValues;
  String provincesDropDownDefaultValue;
  void Function(dynamic) provincesDropDownOnChange;

  String selectedCityId;
  List<City> citiesList;
  List<String> citiesDropDownValues;
  String citiesDropDownDefaultValue;
  void Function(dynamic) citiesDropDownOnChange;

  void Function() submitBtnOnTap;
  bool loading = true;

  void initializeState() async {
    var provinces = await widget.customerAddressRepo.provinces;
    provinces.fold(
      (l) => {},
      (r) => fillProvinces(r.data),
    );

    var cities = await widget.customerAddressRepo.cities(
      provinceId: selectedProvinceId,
    );
    cities.fold(
      (l) => {},
      (r) => fillCities(r.data),
    );

    provincesDropDownOnChange = (value) async {
      provincesDropDownDefaultValue = value;

      for (int i = 0; i < provincesList.length; i++) {
        if (provincesList[i].name == value) {
          selectedProvinceId = provincesList[i].id;
          break;
        }
      }

      var cities = await widget.customerAddressRepo.cities(
        provinceId: selectedProvinceId,
      );

      cities.fold(
        (l) => {},
        (r) => fillCities(r.data),
      );

      setState(() {});
    };

    citiesDropDownOnChange = (value) {
      citiesDropDownDefaultValue = value;

      for (int i = 0; i < citiesList.length; i++) {
        if (citiesList[i].name == value) {
          selectedCityId = citiesList[i].id;
          break;
        }
      }

      setState(() {});
    };

    submitBtnOnTap = () {
      if (formKey.currentState.validate()) {
        // widget.customerAddressRepo.s
      }
    };

    setState(() => loading = false);
  }

  void fillProvinces(List<Province> provinces) {
    provincesList = provinces;
    selectedProvinceId ??= provincesList.first.id;
    provincesDropDownValues = provincesList.map((e) => e.name).toList();
    provincesDropDownDefaultValue = provincesDropDownValues.first;
    setState(() {});
  }

  void fillCities(List<City> cities) {
    citiesList = cities;
    selectedCityId ??= citiesList.first.id;
    citiesDropDownValues = citiesList.map((e) => e.name).toList();
    citiesDropDownDefaultValue = citiesDropDownValues.first;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "ثبت آدرس جدید",
        showBackBtn: true,
      ),
      body: loading
          ? AppLoading(color: AppTheme.customerPrimary)
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      "",
                      style: AppTxtStyles().body..textAlign.justify(),
                    ),
                    CustomTextInput(
                      controller: nameCtrl,
                      validator: AppValidators.name,
                      label: "نام گیرنده",
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    CustomTextInput(
                      controller: addressCtrl,
                      validator: AppValidators.address,
                      label: "آدرس",
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    CustomTextInput(
                      controller: descCtrl,
                      validator: AppValidators.description,
                      label: "توضیحات",
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    CustomDropDown(
                      label: "استان",
                      defaultValue: provincesDropDownDefaultValue,
                      values: provincesDropDownValues,
                      onChange: provincesDropDownOnChange,
                    ),
                    const SizedBox(height: 8),
                    CustomDropDown(
                      label: "شهر",
                      defaultValue: citiesDropDownDefaultValue,
                      values: citiesDropDownValues,
                      onChange: citiesDropDownOnChange,
                    ),
                    const SizedBox(height: 16),
                    ActionBtn(
                      text: "ثبت",
                      onTap: submitBtnOnTap,
                      background: AppTheme.customerPrimary,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
    );
  }
}