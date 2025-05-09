import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/upload.dart';
import 'package:travelx_driver/user/account/screen/driver_account_details/data/driver_account_data.dart';

import '../../../enitity/profile_model.dart';

class DriverAccountState extends Equatable {
  final ApiStatus uploadDocApiStatus;
  final ApiStatus driverAccountApiStatus;
  FileState<String>? docFront;
  FileState<String>? docBack;
  final GetUserProfileData getUserProfileData;
  final bool isValidInput;
  bool? isSingleDocUpload;
  bool? uploadDocColumnOpened;

  String? documentName;
  DriverAccountState({
    required this.uploadDocApiStatus,
    this.docFront,
    this.docBack,
    required this.driverAccountApiStatus,
    required this.getUserProfileData,
    required this.isValidInput,
    this.isSingleDocUpload,
    this.uploadDocColumnOpened,
    required this.documentName,
  });

  static DriverAccountState init() => DriverAccountState(
        uploadDocApiStatus: ApiStatus.init,
        docFront: FileState.initial(type: ''),
        docBack: FileState.initial(type: ''),
        driverAccountApiStatus: ApiStatus.init,
        getUserProfileData: GetUserProfileData(),
        isValidInput: false,
        isSingleDocUpload: false,
        uploadDocColumnOpened: false,
        documentName: "Select Document",
      );

  DriverAccountState copyWith({
    ApiStatus? uploadDocApiStatus,
    ApiStatus? driverAccountApiStatus,
    FileState<String>? docFront,
    FileState<String>? docBack,
    GetUserProfileData? getUserProfileData,
    String? documentName,
    bool? uploadDocColumnOpened,
  }) {
    bool isValid = false;
    if (isSingleDocUpload == true) {
      isValid = (docFront?.file ?? this.docFront?.file)?.isNotEmpty == true;
    } else if (isSingleDocUpload == false) {
      isValid = (docFront?.file ?? this.docFront?.file)?.isNotEmpty == true &&
          (docBack?.file ?? this.docBack?.file)?.isNotEmpty == true;
    }
    return DriverAccountState(
      documentName: documentName ?? this.documentName,
      uploadDocApiStatus: uploadDocApiStatus ?? this.uploadDocApiStatus,
      docFront: docFront ?? this.docFront,
      docBack: docBack ?? this.docBack,
      driverAccountApiStatus:
          driverAccountApiStatus ?? this.driverAccountApiStatus,
      getUserProfileData: getUserProfileData ?? this.getUserProfileData,
      isValidInput: isValid,
      isSingleDocUpload: isSingleDocUpload,
      uploadDocColumnOpened:
          uploadDocColumnOpened ?? this.uploadDocColumnOpened,
    );
  }

  @override
  List<Object?> get props => [
        uploadDocApiStatus,
        docFront,
        docBack,
        driverAccountApiStatus,
        getUserProfileData,
        isValidInput,
        isSingleDocUpload,
        documentName,
        uploadDocColumnOpened,
      ];
}

class DriverAccountCubit extends Cubit<DriverAccountState> {
  DriverAccountCubit() : super(DriverAccountState.init());

  void onFrontFileChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          docFront: state.docFront?.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onBackFileChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          docBack: state.docBack?.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onDocChanged(bool? docChanged) {
    emit(
      state.copyWith(uploadDocColumnOpened: docChanged),
    );
  }

  void onSetInitialScreen() {
    emit(
      state.copyWith(
          uploadDocColumnOpened: false, documentName: "Select Document"),
    );
  }

  Future<void> onSaveDriverAccountsData({required String docType}) async {
    try {
      emit(
        state.copyWith(
          uploadDocApiStatus: ApiStatus.loading,
        ),
      );
      PostProfileData params = PostProfileData(
          lpId: int.tryParse(UserRepository.getLpID ?? "") ?? 0,
          userId: int.tryParse(UserRepository.getUserID ?? "") ?? 0,
          countryCode: UserRepository.getCountryCode,
          phoneNumber: UserRepository.getPhoneNumber,
          user: AppNames.appName);

      if (docType == "Aadhar") {
        state.docFront = FileState.initial(
            file: state.docFront?.file, type: 'aadhar_front_image');
        state.docBack = FileState.initial(
            file: state.docBack?.file, type: 'aadhar_back_image');
      } else if (docType == "Driving Licence") {
        state.docFront = FileState.initial(
            file: state.docFront?.file, type: 'dl_front_image');
        state.docBack =
            FileState.initial(file: state.docBack?.file, type: 'dl_back_image');
      } else if (docType == "Profile Image") {
        state.docFront = FileState.initial(
            file: state.docFront?.file, type: 'profile_image');
      } else if (docType == "Vehicle Insurance") {
        state.docFront = FileState.initial(
            file: state.docFront?.file, type: 'vehicle_insurance_image');
      } else if (docType == "Vehicle RC") {
        state.docFront = FileState.initial(
            file: state.docFront?.file, type: 'vehicle_rc_image');
      }

      final response = await DriverAccountData.uploadDriverId(
          params: params,
          frontFiles: state.docFront,
          backFiles: state.docBack,
          isSingleDocUpload: state.isSingleDocUpload!);
      if (response['status'] == "success") {
        flushDocData();
        emit(state.copyWith(
          uploadDocApiStatus: ApiStatus.success,
        ));
        state.documentName = "Select Document";
        state.uploadDocColumnOpened = false;
        getProfileData();
      }
    } catch (e) {
      flushDocData();
      emit(state.copyWith(
        uploadDocApiStatus: ApiStatus.failure,
      ));
    }
  }

  Future<void> getProfileData() async {
    try {
      emit(state.copyWith(
        driverAccountApiStatus: ApiStatus.loading,
      ));
      final response = await DriverAccountData.getProfileData(
        lpId: UserRepository.getLpID,
        userId: UserRepository.getUserID,
      );

      if (response['status'] == "success") {
        final getUserProfileData = GetUserProfileData.fromJson(response);
        emit(state.copyWith(
          driverAccountApiStatus: ApiStatus.success,
          getUserProfileData: getUserProfileData,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        driverAccountApiStatus: ApiStatus.failure,
      ));
    }
  }

  void flushDocData() {
    emit(
      state.copyWith(
        docFront: FileState.initial(file: "", type: ""),
        docBack: FileState.initial(
          file: "",
          type: '',
        ),
      ),
    );
  }
}
