import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/api_client/api_exception.dart';
import '../../../shared/local_storage/user_repository.dart';
import '../data/my_agency_data.dart';
import '../entity/my_agency_entity.dart';

part 'my_agency_state.dart';

class MyAgencyCubit extends Cubit<MyAgencyState> {
  MyAgencyCubit() : super(MyAgencyInitial());

  bool isMyAgencyLoading = false;

  Future<void> getMyAgencyCubit() async {
   emit(GetAgencyLoading());

    try {


      final response = await MyAgencyData.getMyAgencyData(
        lpId: UserRepository.getLpID ?? "",
        userId: UserRepository.getUserID ?? "",
        user: "driver-ride",
        limit: 10,
        offset: 0,
      );
      if (response['data'] is String) {
        emit(GetAgencyLocationEmpty(emptyMessage: response['data']));
      } else {
        final myAgency = MyAgency.fromJson(response);
        if (myAgency.status == "success") {
          emit(GetAgencyLocationSuccess(myAgency: myAgency));
        }
      }
    } on ApiException catch (e) {
      emit(MyAgencyFailure(errorMessage: "Something went wrong"));
    } catch (e) {
      log(e.toString());
    }
  }
}
