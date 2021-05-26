import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../data/models/base_api_result_model.dart';
import '../../data/repositories/shared_application_repository.dart';

class UpdateNotifier extends ChangeNotifier {
  static UpdateNotifier? _instance;

  factory UpdateNotifier(
    SharedApplicationRepository sharedApplicationRepo,
  ) {
    if (_instance == null) {
      _instance = UpdateNotifier._privateConstructor(sharedApplicationRepo);
    }

    return _instance!;
  }

  UpdateNotifier._privateConstructor(this.sharedApplicationRepo);

  final SharedApplicationRepository sharedApplicationRepo;

  bool hasNewVersionLoading = true;
  String? hasNewVersionErrorMsg;
  BaseApiResultModel? hasNewVersionResult;

  Future<void> fetchUpdateInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("appName: $appName\n");
    print("packageName: $packageName\n");
    print("version: $version\n");
    print("buildNumber: $buildNumber\n");

    var result = await sharedApplicationRepo.hasUpdate(version: version);
    result.fold(
      (left) => hasNewVersionErrorMsg = left.message,
      (right) => hasNewVersionResult = right,
    );

    hasNewVersionLoading = false;
    notifyListeners();
  }
}
