import 'package:cloud_firestore/cloud_firestore.dart';

class SetTaskModel {
  SetTaskModel({
    this.name,
    this.userId,
    this.description,
    this.docId,
    this.subTaskModel,
    this.time,
  });

  String? docId;
  String? userId;
  String? name;
  String? description;
  List<SubTaskModel>? subTaskModel;
  dynamic time;

  SetTaskModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    docId = data["docId"] ?? '';
    userId = data["userId"] ?? '';
    userId = data["time"] ?? '';
    name = data["name"] == null ? null : data["name"];
    description = data["description"] == null ? null : data["description"];
    subTaskModel = data["subTaskModel"] == null ? null : List<SubTaskModel>.from(data["subTaskModel"].map((x) => x));
  }

  SetTaskModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] == null ? null : json["name"];
    name = json["time"] == null ? null : json["time"];
    userId = json["userId"] == null ? null : json["userId"];
    description = json["description"] == null ? null : json["description"];
    docId = json["docId"] == null ? null : json["docId"];
    subTaskModel = json["subTaskModel"] == null ? [] : List<SubTaskModel>.from(json["subTaskModel"].map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTaskModel'] = List<dynamic>.from(subTaskModel?.map((x) => x.toString()) ?? {});
    data['name'] = name;
    data['userId'] = userId;
    data['time'] = time;
    data['description'] = description;
    data['docId'] = docId;
    return data;
  }
}

class SubTaskModel {
  String? description;
  String? name;
  // List<Map<String, dynamic>> subTaskModel;

  SubTaskModel(
    this.name,
    this.description,
    // this.subTaskModel,
  );

  Map<String, dynamic> toMap() => {
        "description": description,
        "name": name,
        // "subTaskModel": subTaskModel == null ? [] : List<dynamic>.from(subTaskModel!.map((x) => x.toString())),
      };
}

class DynamicSubTaskModel {
  String? description;
  String? name;

  DynamicSubTaskModel(
    this.name,
    this.description,
  );

  Map<String, dynamic> toMap() => {
        "description": description,
        "name": name,
      };
}

// class SubTaskModel {
//   SubTaskModel({
//     this.name,
//     this.description,
//   });
//
//   String? name;
//   String? description;
//
//   SubTaskModel.fromDocumentSnapshot(
//     DocumentSnapshot documentSnapshot,
//   ) {
//     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//     name = data["name"] == null ? null : data["name"];
//     description = data["description"] == null ? null : data["description"];
//   }
//
//   SubTaskModel.fromJson(Map<String, dynamic> json) {
//     name = json["name"] == null ? null : json["name"];
//     description = json["description"] == null ? null : json["description"];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['description'] = description;
//     return data;
//   }
// }
