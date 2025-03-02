class FiveDaysData {
  String? dateTime;
  int? temp;

  FiveDaysData({this.dateTime, this.temp});

  factory FiveDaysData.fromJson(Map<String, dynamic> json) {
    return FiveDaysData(
      dateTime: json['dt_txt'],
      temp: int.parse(json['temp'],)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': dateTime,
      'temp': temp,
    };
  }
}