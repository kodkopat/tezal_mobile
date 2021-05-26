import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/customer/cities_result_model.dart';
import '../../../data/models/customer/provinces_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../customer_providers/addresses_notifier.dart';
import 'widgets/custom_location_picker.dart';

class AddressSavePage extends StatefulWidget {
  static const route = "/customer_address_save";

  AddressSavePage({
    this.id,
    this.name,
    this.address,
    this.description,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? description;

  @override
  _AddressSavePageState createState() => _AddressSavePageState();
}

class _AddressSavePageState extends State<AddressSavePage> {
  late AddressesNotifier addressNotifier;

  late String appBarText;

  final formKey = GlobalKey<FormState>();

  late var nameCtrl;
  late var addressCtrl;
  late var descCtrl;

  late LatLng locationResult;

  late String selectedProvinceId;
  late List<Province> provincesList;
  late List<String> provincesDropDownValues;
  late String provincesDropDownDefaultValue;
  late void Function(dynamic) provincesDropDownOnChange;

  late String selectedCityId;
  late List<City> citiesList;
  late List<String> citiesDropDownValues;
  late String citiesDropDownDefaultValue;
  late void Function(dynamic) citiesDropDownOnChange;

  late void Function() submitBtnOnTap;
  bool loading = true;

  void initializeState(BuildContext context) async {
    addressNotifier = Provider.of<AddressesNotifier>(context, listen: false);

    if (widget.id != null) {
      appBarText = "ویرایش آدرس";

      nameCtrl = TextEditingController(text: widget.name);
      addressCtrl = TextEditingController(text: widget.address);
      descCtrl = TextEditingController();
    } else {
      appBarText = "ثبت آدرس";

      nameCtrl = TextEditingController();
      addressCtrl = TextEditingController();
      descCtrl = TextEditingController();
    }

    var provinces = await addressNotifier.provinces();
    fillProvinces(provinces);

    var cities = await addressNotifier.cities(selectedProvinceId);
    fillCities(cities);

    provincesDropDownOnChange = (value) async {
      provincesDropDownDefaultValue = value;

      for (int i = 0; i < provincesList.length; i++) {
        if (provincesList[i].name == value) {
          selectedProvinceId = provincesList[i].id;
          break;
        }
      }

      var cities = await addressNotifier.cities(selectedProvinceId);
      fillCities(cities);

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
      if ((formKey.currentState as FormState).validate()) {
        if (widget.id == null) {
          await addressNotifier.addAddress(
            name: nameCtrl.text,
            address: addressCtrl.text,
            description: descCtrl.text,
            isDefault: false,
            cityId: selectedCityId,
            latitude: "${locationResult.latitude}",
            longitude: "${locationResult.longitude}",
          );

          Routes.sailor.pop();
        } else {
          await addressNotifier.editAddress(
            id: widget.id,
            name: nameCtrl.text,
            address: addressCtrl.text,
            description: descCtrl.text,
            isDefault: false,
            cityId: selectedCityId,
            latitude: "${locationResult.latitude}",
            longitude: "${locationResult.longitude}",
          );

          Routes.sailor.pop();
        }
      }
    };

    // locationResult = await showLocationPicker(
    //   context,
    //   "AIzaSyBbJbAPiVw28tsQTjo5NTj4VEJh_dXWIqI",
    //   hintText: "جستجوی موقعیت",
    //   resultCardAlignment: Alignment.bottomCenter,
    //   resultCardPadding: EdgeInsets.symmetric(
    //     horizontal: 16,
    //     vertical: 8,
    //   ),
    //   resultCardConfirmIcon: Icon(
    //     Feather.check,
    //     color: Colors.white,
    //     size: 24,
    //   ),
    // );
    locationResult = await showDialog(
      context: context,
      builder: (context) {
        return CustomLocationPicker();
      },
    );

    setState(() => loading = false);
  }

  void fillProvinces(List<Province> provinces) {
    provincesList = provinces;
    selectedProvinceId = provincesList.first.id;
    provincesDropDownValues = provincesList.map((e) => "${e.name}").toList();
    provincesDropDownDefaultValue = provincesDropDownValues.first;
    setState(() {});
  }

  void fillCities(List<City> cities) {
    citiesList = cities;
    selectedCityId = citiesList.first.id;
    citiesDropDownValues = citiesList.map((e) => "${e.name}").toList();
    citiesDropDownDefaultValue = citiesDropDownValues.first;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initializeState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: loading ? "" : appBarText,
        showBackBtn: true,
      ),
      body: loading
          ? AppLoading()
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
