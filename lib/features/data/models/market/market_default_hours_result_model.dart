class MarketDefaultHoursResultModel {
  MarketDefaultHoursResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final success;
  final message;
  final List<MarketDefaultHour>? data;

  factory MarketDefaultHoursResultModel.fromJson(Map<String, dynamic> json) =>
      MarketDefaultHoursResultModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<MarketDefaultHour>.from(
                json["data"].map((x) => MarketDefaultHour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MarketDefaultHour {
  MarketDefaultHour({
    required this.id,
    required this.dayOfWeek,
    required this.endHour,
    required this.endMinute,
    required this.startHour,
    required this.startMinute,
  });

  final id;
  final dayOfWeek;
  final endHour;
  final endMinute;
  final startHour;
  final startMinute;

  static final Map<String, String> persianWeekdays = {
    "0": "شنبه",
    "1": "یکشنبه",
    "2": "دوشنبه",
    "3": "سه‌شنبه",
    "4": "چهارشنبه",
    "5": "پنج‌شنبه",
    "6": "جمعه",
  };

  static final Map<String, String> englishWeekdays = {
    "0": "Monday",
    "1": "Tuesday",
    "2": "Wednesday",
    "3": "Thursday",
    "4": "Friday",
    "5": "Saturday",
    "6": "Sunday",
  };

  factory MarketDefaultHour.fromJson(Map<String, dynamic> json) =>
      MarketDefaultHour(
        id: json["id"],
        dayOfWeek: json["dayOfWeek"],
        endHour: json["endHour"],
        endMinute: json["endMinute"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dayOfWeek": dayOfWeek,
        "endHour": endHour,
        "endMinute": endMinute,
        "startHour": startHour,
        "startMinute": startMinute,
      };
}
