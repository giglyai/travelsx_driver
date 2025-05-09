// To parse this JSON data, do
//
//     final documentStatus = documentStatusFromJson(jsonString);

import 'dart:convert';

DocumentStatus documentStatusFromJson(String str) =>
    DocumentStatus.fromJson(json.decode(str));

String documentStatusToJson(DocumentStatus data) => json.encode(data.toJson());

class DocumentStatus {
  String? status;
  List<Datum>? data;

  DocumentStatus({
    this.status,
    this.data,
  });

  factory DocumentStatus.fromJson(Map<String, dynamic> json) => DocumentStatus(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? doc;
  bool? status;

  Datum({
    this.doc,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        doc: json["doc"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "doc": doc,
        "status": status,
      };
}
