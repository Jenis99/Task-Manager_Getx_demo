
import 'dart:convert';

import 'package:flutter/material.dart';

class TextEditingModel {
  TextEditingModel({
    required this.name,
    required this.description,
  });
  TextEditingController name;
  TextEditingController description;

}


GetTaskModel getTaskModelFromJson(String str) => GetTaskModel.fromJson(json.decode(str));
String getTaskModelToJson(GetTaskModel data) => json.encode(data.toJson());

class GetTaskModel {
  GetTaskModel({
    this.docId,
    this.name,
    this.description,
    this.subTaskModel,
  });
  String? docId;
  String? name;
  String? description;
  List<GetSubTaskModel>? subTaskModel;
  factory GetTaskModel.fromJson(Map<String, dynamic> json) => GetTaskModel(
        docId: json["docId"],
        name: json["name"],
        description: json["description"],
        subTaskModel: json["subTaskModel"] == null
            ? []
            : List<GetSubTaskModel>.from(json["subTaskModel"]!.map((x) => GetSubTaskModel.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "docId": docId,
        "name": name,
        "description": description,
        "subTaskModel": subTaskModel == null ? [] : List<dynamic>.from(subTaskModel!.map((x) => x.toJson())),
      };
}

class GetSubTaskModel {
  GetSubTaskModel({
    this.name,
    this.description,
  });
  String? name;
  String? description;
  factory GetSubTaskModel.fromJson(Map<String, dynamic> json) => GetSubTaskModel(
        name: json["name"],
        description: json["description"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}
