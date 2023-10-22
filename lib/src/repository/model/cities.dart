// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

List<CitiesModel> citiesModelFromJson(String str) => List<CitiesModel>.from(
    json.decode(str).map((x) => CitiesModel.fromJson(x)));

String citiesModelToJson(List<CitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitiesModel {
  final String stateName;

  CitiesModel({
    required this.stateName,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        stateName: json['state_name'],
      );

  Map<String, dynamic> toJson() => {
        'state_name': stateName,
      };
}
