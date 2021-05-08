class UpdateMarketDefaultHoursModel {
  UpdateMarketDefaultHoursModel({
    required this.dayOfWeek,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });

  int dayOfWeek;
  int startHour;
  int startMinute;
  int endHour;
  int endMinute;

  factory UpdateMarketDefaultHoursModel.fromJson(Map<String, dynamic> json) =>
      UpdateMarketDefaultHoursModel(
        dayOfWeek: json["dayOfWeek"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
        endHour: json["endHour"],
        endMinute: json["endMinute"],
      );

  Map<String, dynamic> toJson() => {
        "dayOfWeek": dayOfWeek,
        "startHour": startHour,
        "startMinute": startMinute,
        "endHour": endHour,
        "endMinute": endMinute,
      };
}
