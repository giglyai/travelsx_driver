import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/main.dart';
import 'package:travelx_driver/search-rides/screens/booking_registration/repository/booking_registration_repo.dart';
import 'package:travelx_driver/shared/api_client/api_client.dart';
import 'package:travelx_driver/shared/constants/app_name/app_name.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/text_form_field/custom_textform_field.dart';
import 'package:travelx_driver/user/account/enitity/upload.dart';

class BookingRegistrationState extends Equatable {
  final FileState<String> selfie;
  final FileState<String> exteriorFront;
  final FileState<String> exteriorRight;
  final FileState<String> exteriorLeft;
  final FileState<String> exteriorRear;
  final bool isValidInput;

  final ApiStatus uploadDocApiStatus;

  const BookingRegistrationState({
    required this.selfie,
    required this.exteriorFront,
    required this.exteriorRight,
    required this.exteriorLeft,
    required this.exteriorRear,
    required this.isValidInput,
    required this.uploadDocApiStatus,
  });

  static BookingRegistrationState init() => BookingRegistrationState(
        selfie: FileState.initial(type: 'selfie'),
        exteriorFront: FileState.initial(type: 'exterior_front'),
        exteriorLeft: FileState.initial(type: 'exterior_left'),
        exteriorRear: FileState.initial(type: 'exterior_rear'),
        exteriorRight: FileState.initial(type: 'exterior_right'),
        isValidInput: false,
        uploadDocApiStatus: ApiStatus.init,
      );

  BookingRegistrationState copyWith({
    FileState<String>? selfie,
    FileState<String>? exteriorFront,
    FileState<String>? exteriorRight,
    FileState<String>? exteriorLeft,
    FileState<String>? exteriorRear,
    ApiStatus? uploadDocApiStatus,
  }) {
    bool isValid = (selfie?.file ?? this.selfie.file)?.isNotEmpty == true &&
        (exteriorFront?.file ?? this.exteriorFront.file)?.isNotEmpty == true &&
        (exteriorRight?.file ?? this.exteriorRight.file)?.isNotEmpty == true &&
        (exteriorLeft?.file ?? this.exteriorLeft.file)?.isNotEmpty == true &&
        (exteriorRear?.file ?? this.exteriorRear.file)?.isNotEmpty == true;
    return BookingRegistrationState(
      selfie: selfie ?? this.selfie,
      exteriorFront: exteriorFront ?? this.exteriorFront,
      exteriorRight: exteriorRight ?? this.exteriorRight,
      exteriorLeft: exteriorLeft ?? this.exteriorLeft,
      exteriorRear: exteriorRear ?? this.exteriorRear,
      isValidInput: isValid,
      uploadDocApiStatus: uploadDocApiStatus ?? this.uploadDocApiStatus,
    );
  }

  @override
  List<Object?> get props => [
        uploadDocApiStatus,
        selfie,
        exteriorFront,
        exteriorLeft,
        exteriorRear,
        exteriorRight,
        isValidInput,
      ];
}

class BookingRegistrationCubit extends Cubit<BookingRegistrationState> {
  BookingRegistrationCubit() : super(BookingRegistrationState.init()) {}

  void onSelfieChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          selfie: state.selfie.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onExteriorFrontChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          exteriorFront: state.exteriorFront.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onExteriorRightChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          exteriorRight: state.exteriorRight.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onExteriorLeftChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          exteriorLeft: state.exteriorLeft.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  void onExteriorRearChanged(String? filePath) {
    if (filePath != null) {
      emit(
        state.copyWith(
          exteriorRear: state.exteriorRear.copyWith(
            error: '',
            file: filePath,
          ),
        ),
      );
    }
  }

  Future<void> onSaveCarDataPressed({
    required String registrationNumber,
    required String rideId,
  }) async {
    try {
      emit(
        state.copyWith(
          uploadDocApiStatus: ApiStatus.loading,
        ),
      );
      PostUserData params = PostUserData(
          lpId: int.tryParse(UserRepository.getLpID ?? "") ?? 0,
          userId: int.tryParse(UserRepository.getUserID ?? "") ?? 0,
          phoneNumber: UserRepository.getPhoneNumber,
          user: AppNames.appName,
          vehicleNumber: registrationNumber,
          rideId: rideId);
      final response = await BookingRegistrationRepo.uploadCarDocuments(
        params: params,
        selfie: state.selfie,
        exteriorFront: state.exteriorFront,
        exteriorRight: state.exteriorRight,
        exteriorLeft: state.exteriorLeft,
        exteriorRear: state.exteriorRear,
      );
      if (response['status'] == "success") {
        emit(state.copyWith(
          uploadDocApiStatus: ApiStatus.success,
        ));

        AnywhereDoor.pop(navigatorKey.currentState!.context, result: true);
        AnywhereDoor.pop(navigatorKey.currentState!.context, result: true);
      }
    } catch (e) {
      emit(state.copyWith(
        uploadDocApiStatus: ApiStatus.failure,
      ));
    }
  }
}
