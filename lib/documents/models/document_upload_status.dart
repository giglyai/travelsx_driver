// To parse this JSON data, do
//
//     final documentUploadStatus = documentUploadStatusFromJson(jsonString);

import 'dart:convert';

DocumentUploadStatus documentUploadStatusFromJson(String str) =>
    DocumentUploadStatus.fromJson(json.decode(str));

String documentUploadStatusToJson(DocumentUploadStatus data) =>
    json.encode(data.toJson());

class DocumentUploadStatus {
  String? status;
  String? message;

  DocumentUploadStatus({
    this.status,
    this.message,
  });

  factory DocumentUploadStatus.fromJson(Map<String, dynamic> json) =>
      DocumentUploadStatus(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
