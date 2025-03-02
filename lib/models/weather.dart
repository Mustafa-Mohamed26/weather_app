class Weather{
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      id: int.parse(json['id']),
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}