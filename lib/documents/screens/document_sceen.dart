import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/documents/bloc/document_cubit.dart';
import 'package:travelx_driver/documents/widgets/document_title_card.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/shared/widgets/ride_back_button/ride_back_button.dart';
import 'package:lottie/lottie.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  late DocumentCubit _documentCubit;

  @override
  void initState() {
    _documentCubit = BlocProvider.of<DocumentCubit>(context);
    _documentCubit.getUserDocDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<DocumentCubit, DocumentState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is DocumentStatusSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RideBackButton(),
                  Center(
                    child: Text(
                      "documents".tr,
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 16 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomSizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 21 * SizeConfig.widthMultiplier!),
                    child: Text(
                      "Driver requirements",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 24 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 21 * SizeConfig.widthMultiplier!),
                    child: Text(
                      "Add your driver details. ",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor.withOpacity(0.62),
                          fontSize: 14 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomSizedBox(
                    height: 49,
                  ),

                  Wrap(
                    children: List.generate(
                      state.documentStatus.data?.length ?? 0,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: DocumentTitleCard(
                          isVarified: state.documentStatus.data?[index].status,
                          onTap: () {
                            if (state.documentStatus.data?[index].status ==
                                false) {
                              Navigator.pushNamed(
                                  context, RouteName.documentUploadScreen);
                            }
                          },
                          title: state.documentStatus.data?[index].doc,
                        ),
                      ),
                    ),
                  ),
                  // DocumentTitleCard(
                  //   isVarified: state.documentStatus.data?.emiratesId,
                  //   onTap: () {
                  //     if (state.documentStatus.data?.emiratesId == false) {
                  //       Navigator.pushNamed(
                  //           context, RouteName.documentUploadScreen);
                  //     }
                  //   },
                  //   title: "Emirates ID",
                  // ),

                  Padding(
                    padding:
                        EdgeInsets.only(left: 21 * SizeConfig.widthMultiplier!),
                    child: Text(
                      "Vehicle requirements",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontSize: 24 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  CustomSizedBox(
                    height: 20,
                  ),
                  DocumentTitleCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.documentUploadScreen);
                    },
                    title: "Company",
                  ),
                  CustomSizedBox(
                    height: 30,
                  ),
                  DocumentTitleCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.documentUploadScreen);
                    },
                    title: "Model",
                  ),
                  CustomSizedBox(
                    height: 30,
                  ),
                  DocumentTitleCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.documentUploadScreen);
                    },
                    title: "License Plate Number",
                  ),
                  CustomSizedBox(
                    height: 37,
                  ),
                  BlueButton(
                    title: "Save",
                    onTap: () {},
                  ),
                  CustomSizedBox(
                    height: 27,
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSizedBox(
                  height: 300,
                ),
                Center(
                  child: Lottie.asset(ImagePath.loadingAnimation,
                      height: 50 * SizeConfig.heightMultiplier!,
                      width: 300 * SizeConfig.widthMultiplier!),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
