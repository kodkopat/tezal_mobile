import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text_input.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/simple_app_bar.dart';
import '../../../../data/models/addresses_result_model.dart';
import '../../../../data/models/cities_result_model.dart';
import '../../../../data/models/provinces_result_model.dart';
import '../../../../data/repositories/customer_address_repository.dart';

class SaveAddressModal extends StatefulWidget {
  const SaveAddressModal({
    Key key,
    this.address,
    @required this.customerAddressRepo,
  }) : super(key: key);

  final Address address;
  final CustomerAddressRepository customerAddressRepo;

  @override
  _SaveAddressModalState createState() => _SaveAddressModalState();
}

class _SaveAddressModalState extends State<SaveAddressModal> {
  String appBarText;

  final formKey = GlobalKey<FormState>();

  var nameCtrl;
  var addressCtrl;
  var descCtrl;

  LocationResult locationResult;

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
    if (widget.address != null) {
      appBarText = "ویرایش آدرس";

      nameCtrl = TextEditingController(text: widget.address.name);
      addressCtrl = TextEditingController(text: widget.address.address);
      descCtrl = TextEditingController();
    } else {
      appBarText = "ثبت آدرس";

      nameCtrl = TextEditingController();
      addressCtrl = TextEditingController();
      descCtrl = TextEditingController();
    }

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

    submitBtnOnTap = () async {
      print("address: ${locationResult.address}\n");
      print("latitude: ${locationResult.latLng.latitude}\n");
      print("longitude: ${locationResult.latLng.longitude}\n");

      if (formKey.currentState.validate()) {
        if (widget.address == null) {
          final result = await widget.customerAddressRepo.saveAddress(
            latitude: "${locationResult.latLng.latitude}",
            longitude: "${locationResult.latLng.longitude}",
            address: addressCtrl.text,
            description: descCtrl.text,
            isDefault: false,
            cityId: selectedCityId,
            name: nameCtrl.text,
          );

          result.fold(
            (l) => null,
            (r) => Routes.sailor.pop(),
          );
        } else {
          final result = await widget.customerAddressRepo.editAddress(
            id: widget.address.id,
            latitude: "${locationResult.latLng.latitude}",
            longitude: "${locationResult.latLng.longitude}",
            address: addressCtrl.text,
            description: descCtrl.text,
            isDefault: false,
            cityId: selectedCityId,
            name: nameCtrl.text,
          );

          result.fold(
            (l) => null,
            (r) => Routes.sailor.pop(),
          );
        }
      }
    };

    locationResult = await showLocationPicker(
      context,
      "AIzaSyBbJbAPiVw28tsQTjo5NTj4VEJh_dXWIqI",
      resultCardConfirmIcon: Icon(
        Feather.check,
        color: Colors.white,
        size: 24,
      ),
      hintText: "جستجوی موقعیت",
      resultCardPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      resultCardAlignment: Alignment.bottomCenter,
      resultCardDecoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4.0),
            blurRadius: 8,
            spreadRadius: 0,
          )
        ],
      ),
      searchBarBoxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4.0),
            blurRadius: 8,
            spreadRadius: 0,
          )
        ],
      ),
    );

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
        text: appBarText,
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
                    CustomTextInput(
                      controller: nameCtrl,
                      validator: AppValidators.name,
                      label: "عنوان",
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
                  ],
                ),
              ),
            ),
    );
  }
}
