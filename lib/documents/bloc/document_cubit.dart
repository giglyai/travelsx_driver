import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travelx_driver/documents/models/document_status.dart';
import 'package:travelx_driver/documents/models/document_upload_status.dart';
import 'package:travelx_driver/documents/repository/document_repository.dart';
import 'package:travelx_driver/home/models/post_userdata_params.dart';
import 'package:travelx_driver/shared/api_client/api_exception.dart';

import '../../shared/local_storage/log_in_status.dart';
import '../../shared/local_storage/user_repository.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());

  int? getDriverLpId;
  int? driverId;
  LogInStatus getUserData = LogInStatus();

  DocumentUploadStatus? documentUploadStatus;
  DocumentStatus? documentStatus;
  void getUserDetails() async {
    var getLpId = await getUserData.getDriverLpId();
    getDriverLpId = int.tryParse(getLpId ?? '');
    var getDriverId = await getUserData.getDriverID();
    driverId = int.tryParse(getDriverId ?? "");
  }

  Future<void> updateUserDocument({required String imagePath}) async {
    emit(DocumentLoading());
    getUserDetails();
    LogInStatus getUserData = LogInStatus();

    final deviceToken = await getUserData.getDeviceTokenDetails();

    User user = User(userId: driverId ?? 1);
    PostUserDataParams params = PostUserDataParams(
      lpId: int.tryParse(UserRepository.getLpID ?? ""),
      deviceToken: deviceToken,
      user: user,
    );

    try {
      final response = await DocumentsRepository.updateUserDocument(
          params: params, imagePath: imagePath);
      documentUploadStatus = DocumentUploadStatus.fromJson(response);
      if (documentUploadStatus?.status == "success") {
        emit(DocumentSuccess(message: documentUploadStatus?.message ?? ""));
      }
    } on ApiException catch (e) {
      emit(DocumentFailure(message: e.message));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getUserDocDetails() async {
    try {
      emit(DocumentStatusLoading());

      final response = await DocumentsRepository.getDocStatus();
      documentStatus = DocumentStatus.fromJson(response);

      if (documentStatus?.status == "success") {
        emit(DocumentStatusSuccess(documentStatus: documentStatus!));
      }
    } on ApiException catch (e) {
      emit(DocumentStatusFailure(message: e.message));
    }
  }
}
