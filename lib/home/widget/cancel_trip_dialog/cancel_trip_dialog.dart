import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/utilities.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/widgets/buttons/blue_button.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/size_config/size_config.dart';


class CancelTripDialog extends StatefulWidget {
  final Function(String? cancelReason) onSubmit;
  final Function()? onCancel;
  const CancelTripDialog({super.key, required this.onSubmit, this.onCancel});

  @override
  State<CancelTripDialog> createState() => _CancelTripDialogState();
}

class _CancelTripDialogState extends State<CancelTripDialog> {
  int? selectedIndex;

  String? cancelReason;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: 320 * SizeConfig.widthMultiplier!,
        child: Padding(
          padding: EdgeInsets.only(
              left: 18.0 * SizeConfig.widthMultiplier!,
              top: 22 * SizeConfig.heightMultiplier!,
              right: 20 * SizeConfig.widthMultiplier!,
              bottom: 20 * SizeConfig.heightMultiplier!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reason for cancelling",
                    style: TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontSize: 16 * SizeConfig.textMultiplier!,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AnywhereDoor.pop(context);
                      if (widget.onCancel != null) {
                        widget.onCancel!();
                      }
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w600,
                        fontSize: 16 * SizeConfig.textMultiplier!,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17 * SizeConfig.heightMultiplier!,
              ),
              const Divider(),
              ...List.generate(
                  _tripCancellationReason.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            cancelReason = _tripCancellationReason[index];

                            selectedIndex = index;
                          });
                        },
                        child: Utils.title(
                            title: _tripCancellationReason[index],
                            isSelected: selectedIndex == index),
                      )),
              BlueButton(
                title: "Submit",
                onTap: () {
                  widget.onSubmit(cancelReason);
                },
                wantMargin: false,
                borderRadius: 4 * SizeConfig.widthMultiplier!,
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> _tripCancellationReason = [
  "Distance is too far",
  "I have phone or app problems",
  "I need some rest",
  "I facing vehicle issue",
  "Reward is too low",
];

class CustomBottomSheet {
  int? selectedIndex;

  String? cancelReason;

  customBottomSheet({
    required BuildContext context,
    double? bottomSheetHeight,
    required Function(String? cancelReason) onSubmit,
    Function()? onCancel,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                  ),
                  height:
                      bottomSheetHeight ?? 410 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthMultiplier!,
                            top: 30 * SizeConfig.heightMultiplier!),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                AnywhereDoor.pop(context);
                                if (onCancel != null) {
                                  onCancel();
                                }
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: AppColors.kRed,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16 * SizeConfig.textMultiplier!),
                              ),
                            ),
                            CustomSizedBox(
                              width: 48,
                            ),
                            Text(
                              "Reason for Cancellation",
                              style: TextStyle(
                                  color: AppColors.kBlackTextColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * SizeConfig.textMultiplier!),
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        height: 18,
                      ),
                      ...List.generate(
                          _tripCancellationReason.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cancelReason =
                                        _tripCancellationReason[index];

                                    selectedIndex = index;
                                  });
                                },
                                child: Utils.title(
                                    title: _tripCancellationReason[index],
                                    isSelected: selectedIndex == index),
                              )),
                      CustomSizedBox(
                        height: 20,
                      ),
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Center(
                            child: BlueButton(
                              isLoading: state is MutateOnTripsLoading,
                              title: "Submit",
                              buttonIsEnabled: cancelReason?.isNotEmpty == true,
                              onTap: () {
                                if (cancelReason?.isNotEmpty == true) {
                                  onSubmit(cancelReason);
                                }
                                AnywhereDoor.pop(context);
                              },
                              wantMargin: false,
                              borderRadius: 4 * SizeConfig.widthMultiplier!,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
