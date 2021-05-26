import 'package:flutter/material.dart';

import '../../data/models/customer/campaign_result_model.dart';
import '../../data/repositories/customer_campaign_repository.dart';

class CampaignNotifier extends ChangeNotifier {
  static CampaignNotifier? _instance;

  factory CampaignNotifier(
    CustomerCampaignRepository customerCampaignRepo,
  ) {
    if (_instance == null) {
      _instance = CampaignNotifier._privateConstructor(customerCampaignRepo);
    }

    return _instance!;
  }

  CampaignNotifier._privateConstructor(this.customerCampaignRepo);

  final CustomerCampaignRepository customerCampaignRepo;

  bool campaignLoading = true;
  String? campaignErrorMsg;
  List<Campaign>? campaigns;

  Future<void> fetchCampaigns() async {
    var result = await customerCampaignRepo.getall();

    result.fold(
      (left) => campaignErrorMsg = left.message,
      (right) => campaigns = right.data,
    );

    campaignLoading = false;
    notifyListeners();
  }

  void refresh() async {
    campaignLoading = true;
    campaignErrorMsg = null;
    campaigns = null;
    notifyListeners();

    await fetchCampaigns();
  }
}
