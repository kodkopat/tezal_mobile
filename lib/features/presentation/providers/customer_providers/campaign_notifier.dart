import 'package:flutter/material.dart';

import '../../../data/models/customer/campaign_result_model.dart';
import '../../../data/repositories/customer_campaign_repository.dart';

class CampaignNotifier extends ChangeNotifier {
  static CampaignNotifier? _instance;

  factory CampaignNotifier(
    CustomerCampaignRepository customerCampaignRepo,
  ) {
    if (_instance == null) {
      _instance = CampaignNotifier._privateConstructor(
        customerCampaignRepo: customerCampaignRepo,
      );
    }

    return _instance!;
  }

  CampaignNotifier._privateConstructor({
    required this.customerCampaignRepo,
  });

  final CustomerCampaignRepository customerCampaignRepo;

  bool campaignLoading = true;
  String? campaignErrorMsg;
  List<Campaign>? campaigns;

  Future<void> fetchCampaigns() async {
    var result = await customerCampaignRepo.campaignes;

    result.fold(
      (left) => campaignErrorMsg = left.message,
      (right) => campaigns = right.data,
    );

    campaignLoading = false;
    notifyListeners();
  }
}
