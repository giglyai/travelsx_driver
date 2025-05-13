import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:travelx_driver/home/widget/container_with_border/container_with_border.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/keyboard/custom_keyboard.dart';
import 'package:travelx_driver/shared/local_storage/user_repository.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:ios_keyboard_action/ios_keyboard_action.dart';
import 'package:lottie/lottie.dart';

import '../../../config/phone_pay/phone_pay_payment.dart';
import '../../../shared/api_client/api_client.dart';
import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/routes/api_routes.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/utils/utilities.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/empty_data_screens/earnings_empty.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../bloc/wallet_cubit.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late WalletCubit _walletCubit;
  String? selectName;
  final FocusNode _textFiledFocusNode = FocusNode();
  final TextEditingController addMoneyController = TextEditingController();

  @override
  void initState() {
    _walletCubit = BlocProvider.of<WalletCubit>(context);
    _walletCubit.getWalletData(dateFilter: selectName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.only(bottom: 15 * SizeConfig.heightMultiplier!),
        //   child: BlueButton(
        //     title: "add_money".tr,
        //     onTap: () {
        //       _showAddMoneyBottomSheet();
        //       // await UpiPayment(totalAmount: 1).startPgTransaction();
        //     },
        //   ),
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RideBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                child: Text(
                  "wallets".tr,
                  style: TextStyle(
                    color: AppColors.kBlackTextColor.withOpacity(0.70),
                    fontSize: 20 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 26 * SizeConfig.heightMultiplier!),
              Center(
                child: Text(
                  "balance".tr,
                  style: TextStyle(
                    color: AppColors.kBlackTextColor.withOpacity(0.60),
                    fontSize: 16 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 7 * SizeConfig.heightMultiplier!),
              Center(
                child: BlocBuilder<WalletCubit, WalletState>(
                  builder: (context, state) {
                    if (state is GotWalletSuccessState) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.walletModel.data?.total?.currency ?? "",
                            style: AppTextStyle.text40kGreen84C4B0700,
                          ),
                          CustomSizedBox(width: 10),
                          Text(
                            "${state.walletModel.data?.total?.balance ?? ""}",
                            style: AppTextStyle.text40kkBlackTextColorW700,
                          ),
                        ],
                      );
                    }
                    return Text("");
                  },
                ),
              ),
              SizedBox(height: 20 * SizeConfig.heightMultiplier!),
              Center(
                child: SizedBox(
                  width: 190 * SizeConfig.widthMultiplier!,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      //background color of dropdown button
                      border: Border.all(
                        color: AppColors.kBlue3D6DFE,
                        width: 2 * SizeConfig.widthMultiplier!,
                      ),
                      //border of dropdown button
                      borderRadius: BorderRadius.circular(
                        40 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectName,
                      hint: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            EarningActivity.thisWeek.getEarningActivityString,
                            style: TextStyle(
                              color: AppColors.kBlackTextColor.withOpacity(
                                0.70,
                              ),
                              fontWeight: FontWeight.w700,
                              fontSize: 16 * SizeConfig.textMultiplier!,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20 * SizeConfig.imageSizeMultiplier!,
                          ),
                        ],
                      ),
                      items: [
                        DropdownMenuItem(
                          value: EarningActivity.today.getEarningActivityString,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  EarningActivity
                                      .today
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20 * SizeConfig.imageSizeMultiplier!,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              EarningActivity
                                  .yesterday
                                  .getEarningActivityString,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  EarningActivity
                                      .yesterday
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20 * SizeConfig.imageSizeMultiplier!,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              EarningActivity.lastweek.getEarningActivityString,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  EarningActivity
                                      .lastweek
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20 * SizeConfig.imageSizeMultiplier!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              EarningActivity.thisWeek.getEarningActivityString,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  EarningActivity
                                      .thisWeek
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20 * SizeConfig.imageSizeMultiplier!,
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              EarningActivity
                                  .lastmonth
                                  .getEarningActivityString,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  EarningActivity
                                      .lastmonth
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20 * SizeConfig.imageSizeMultiplier!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              EarningActivity
                                  .thisMonth
                                  .getEarningActivityString,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  EarningActivity
                                      .thisMonth
                                      .getEarningActivityString,
                                  style: TextStyle(
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.70),
                                    fontSize: 16 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20 * SizeConfig.imageSizeMultiplier!,
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        //get value when changed
                        setState(() {
                          selectName = value;
                        });
                        _walletCubit.getWalletData(dateFilter: selectName);
                      },
                      iconEnabledColor: AppColors.kWhite,
                      //Icon color
                      style: TextStyle(
                        color: AppColors.kBlackTextColor.withOpacity(0.70),
                        fontWeight: FontWeight.w700,
                        fontSize: 16 * SizeConfig.textMultiplier!,
                      ),
                      dropdownColor: AppColors.kWhite,
                      //dropdown background color
                      underline: Container(), //remove underline
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25 * SizeConfig.heightMultiplier!),
              BlocConsumer<WalletCubit, WalletState>(
                listener: (context, state) {
                  if (state is WalletFailureState) {
                    // CustomToastUtils.showToast(
                    //     context: context,
                    //     title: state.errorMessage,
                    //     imagePath: ImagePath.errorIcon,
                    //     toastColor: AppColors.kRedFF355);
                  }
                },
                builder: (context, state) {
                  if (state is GotWalletSuccessState) {
                    return Wrap(
                      direction: Axis.vertical,
                      children: List.generate(
                        state.walletModel.data?.transactions?.length ?? 0,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            right: 16 * SizeConfig.widthMultiplier!,
                            left: 16 * SizeConfig.widthMultiplier!,
                            bottom: 10 * SizeConfig.heightMultiplier!,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.walletModel.data?.transactions?[index].createdTime}",
                                style: TextStyle(
                                  color: AppColors.kBlackTextColor.withOpacity(
                                    0.80,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14 * SizeConfig.textMultiplier!,
                                ),
                              ),
                              SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  8 * SizeConfig.widthMultiplier!,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    7 * SizeConfig.widthMultiplier!,
                                  ),
                                  color: AppColors.kWhiteF8F8F8,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                        8 * SizeConfig.widthMultiplier!,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.kGreen8FB891
                                            .withOpacity(0.80),
                                      ),
                                      child: ImageLoader.svgPictureAssetImage(
                                        imagePath: ImagePath.handMoneyIcon,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                    CustomSizedBox(width: 10),
                                    SizedBox(
                                      width: 230 * SizeConfig.widthMultiplier!,
                                      child: Text(
                                        "${state.walletModel.data?.transactions?[index].description}",
                                        style: TextStyle(
                                          color: AppColors.kBlackTextColor
                                              .withOpacity(0.80),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              14 * SizeConfig.textMultiplier!,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${state.walletModel.data?.transactions?[index].currency} ${state.walletModel.data?.transactions?[index].amount}",
                                      style: TextStyle(
                                        color: AppColors.kBlackTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            16 * SizeConfig.textMultiplier!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12 * SizeConfig.heightMultiplier!,
                              ),
                              if (index <
                                  (state
                                              .walletModel
                                              .data
                                              ?.transactions
                                              ?.length ??
                                          0) -
                                      1)
                                SizedBox(
                                  width: 331 * SizeConfig.widthMultiplier!,
                                  child: Divider(
                                    endIndent: 30 * SizeConfig.widthMultiplier!,
                                    thickness:
                                        0.4 * SizeConfig.widthMultiplier!,
                                    color: AppColors.kBlackTextColor
                                        .withOpacity(0.30),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is WalletEmptyState) {
                    return Center(
                      child: EmptyEarnings(message: state.emptyMessage),
                    );
                  }

                  if (state is WalletLoadingState) {
                    return Center(
                      child: Lottie.asset(
                        ImagePath.loadingAnimation,
                        height: 50 * SizeConfig.heightMultiplier!,
                        width: 300 * SizeConfig.widthMultiplier!,
                      ),
                    );
                  }
                  return Center(child: Text("no_data".tr));
                },
              ),
              SizedBox(height: 20 * SizeConfig.heightMultiplier!),
            ],
          ),
        ),
      ),
    );
  }

  usableRow({
    required String title,
    required String subTitle,
    bool? wantBoldText,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24 * SizeConfig.widthMultiplier!,
        right: 26 * SizeConfig.widthMultiplier!,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.kBlackTextColor,
              fontSize: 16 * SizeConfig.textMultiplier!,
              fontWeight:
                  wantBoldText == true ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            subTitle,
            style: TextStyle(
              color: AppColors.kBlackTextColor,
              fontSize: 16 * SizeConfig.textMultiplier!,
              fontWeight:
                  wantBoldText == true ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _showAddMoneyBottomSheet() async {
    bool buttonEnabled = false;
    AddMoneyContainer addMoneyContainer = AddMoneyContainer.none;
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        15 * SizeConfig.widthMultiplier!,
                      ),
                      topRight: Radius.circular(
                        15 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                  height: 790 * SizeConfig.heightMultiplier!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          addMoneyController.clear();
                          AnywhereDoor.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * SizeConfig.widthMultiplier!,
                            vertical: 15 * SizeConfig.heightMultiplier!,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  8 * SizeConfig.widthMultiplier!,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kWhiteE5E5E5,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: ImageLoader.svgPictureAssetImage(
                                  imagePath: ImagePath.closeIcon,
                                  height: 10 * SizeConfig.heightMultiplier!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "enter_amount".tr,
                        style: AppTextStyle.text20black0000W700,
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "INR",
                              style: AppTextStyle.text40kGreen84C4B0700,
                            ),
                            CustomSizedBox(width: 5),
                            SizedBox(
                              width: 180 * SizeConfig.widthMultiplier!,
                              child: IOSKeyboardAction(
                                focusActionType: FocusActionType.done,
                                focusNode: _textFiledFocusNode,
                                child: TextFormField(
                                  enabled: false,
                                  focusNode: _textFiledFocusNode,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]'),
                                    ),
                                  ],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: true,
                                      ),
                                  controller: addMoneyController,
                                  cursorColor: AppColors.kBlue3D6,
                                  style:
                                      AppTextStyle.text40kkBlackTextColorW700,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintText: "0.0",
                                    border: InputBorder.none,
                                    hintStyle: AppTextStyle
                                        .text40kkBlackTextColorW700
                                        ?.copyWith(
                                          height:
                                              1.7 *
                                              SizeConfig.heightMultiplier!,
                                        ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty == true) {
                                      setState1(() {
                                        buttonEnabled = true;
                                      });
                                    } else {
                                      setState1(() {
                                        buttonEnabled = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "minimum_amount_100".tr,
                        style: AppTextStyle.text16black0000W500,
                      ),
                      CustomSizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10 * SizeConfig.widthMultiplier!,
                          vertical: 6 * SizeConfig.widthMultiplier!,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kWhiteF8F8F8,
                          borderRadius: BorderRadius.circular(37),
                        ),
                        child: Text(
                          "you_can_also_select_amount".tr,
                          style: AppTextStyle.text16black0000W400,
                        ),
                      ),
                      CustomSizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              addMoneyController.text = 100.toString();
                              addMoneyContainer = AddMoneyContainer.one;
                              setState1(() {
                                buttonEnabled = true;
                              });
                            },
                            child: ContainerWithBorder(
                              width: 100 * SizeConfig.widthMultiplier!,
                              borderColor:
                                  addMoneyContainer == AddMoneyContainer.one
                                      ? AppColors.kBlue3D6DFE
                                      : AppColors.kBlue40C4FF,
                              containerColor:
                                  addMoneyContainer == AddMoneyContainer.one
                                      ? AppColors.kBlueEAEEFA
                                      : AppColors.kWhite,
                              borderWidth:
                                  addMoneyContainer == AddMoneyContainer.one
                                      ? 2
                                      : 1,
                              child: Center(
                                child: Text(
                                  "INR 100",
                                  style:
                                      addMoneyContainer == AddMoneyContainer.one
                                          ? AppTextStyle.text16kBlue3D6DFEW700
                                          : AppTextStyle.text16black0000W700
                                              ?.copyWith(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.41),
                                              ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addMoneyController.text = 200.toString();
                              addMoneyContainer = AddMoneyContainer.two;
                              setState1(() {
                                buttonEnabled = true;
                              });
                            },
                            child: ContainerWithBorder(
                              width: 100 * SizeConfig.widthMultiplier!,
                              borderColor:
                                  addMoneyContainer == AddMoneyContainer.two
                                      ? AppColors.kBlue3D6DFE
                                      : AppColors.kBlue40C4FF,
                              containerColor:
                                  addMoneyContainer == AddMoneyContainer.two
                                      ? AppColors.kBlueEAEEFA
                                      : AppColors.kWhite,
                              borderWidth:
                                  addMoneyContainer == AddMoneyContainer.two
                                      ? 2
                                      : 1,
                              child: Center(
                                child: Text(
                                  "INR 200",
                                  style:
                                      addMoneyContainer == AddMoneyContainer.two
                                          ? AppTextStyle.text16kBlue3D6DFEW700
                                          : AppTextStyle.text16black0000W700
                                              ?.copyWith(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.41),
                                              ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addMoneyController.text = 300.toString();
                              addMoneyContainer = AddMoneyContainer.three;
                              setState1(() {
                                buttonEnabled = true;
                              });
                            },
                            child: ContainerWithBorder(
                              width: 100 * SizeConfig.widthMultiplier!,
                              borderColor:
                                  addMoneyContainer == AddMoneyContainer.three
                                      ? AppColors.kBlue3D6DFE
                                      : AppColors.kBlue40C4FF,
                              containerColor:
                                  addMoneyContainer == AddMoneyContainer.three
                                      ? AppColors.kBlueEAEEFA
                                      : AppColors.kWhite,
                              borderWidth:
                                  addMoneyContainer == AddMoneyContainer.three
                                      ? 2
                                      : 1,
                              child: Center(
                                child: Text(
                                  "INR 300",
                                  style:
                                      addMoneyContainer ==
                                              AddMoneyContainer.three
                                          ? AppTextStyle.text16kBlue3D6DFEW700
                                          : AppTextStyle.text16black0000W700
                                              ?.copyWith(
                                                color: AppColors.kBlackTextColor
                                                    .withOpacity(0.41),
                                              ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      KeyboardDemo(
                        textMaxLength: 4,
                        onChanged: (value) {
                          if (value?.isNotEmpty == true) {
                            setState1(() {
                              buttonEnabled = true;
                            });
                          } else {
                            setState1(() {
                              buttonEnabled = false;
                            });
                          }
                        },
                        controller: addMoneyController,
                      ),
                      CustomSizedBox(height: 10),
                      BlueButton(
                        buttonIsEnabled: buttonEnabled,
                        title: "add_money".tr,
                        onTap: () async {
                          //   await UpiPayment(
                          //     ///Todo Uncomment after testing
                          //     totalAmount:
                          //         int.tryParse(addMoneyController.text) ?? 100,
                          //     //totalAmount: 1,
                          //   ).startPgTransaction().then((value) async {
                          //     if (value?.success == true) {
                          //       final Map<String, dynamic> response =
                          //           await ApiClient()
                          //               .post(ApiRoutes.statusCreate, body: {
                          //         "payment_response": value ?? "",
                          //         "user_id": UserRepository.getUserID,
                          //         "lp_id": UserRepository.getLpID,
                          //         "feature": "credit-money",
                          //         "user": AppNames.appName,
                          //         "reason": "for wallet",
                          //         "create_iso_time":
                          //             DateTime.now().toIso8601String(),
                          //         "create_utc_time":
                          //             DateTime.now().toUtc().toIso8601String(),
                          //         "payment_type": {
                          //           "mode":
                          //               value?.data?.paymentInstrument?.type ??
                          //                   "",
                          //           "status": "paid",
                          //           "amount": addMoneyController.text,
                          //           "currency": "INR"
                          //         }
                          //       });
                          //       if (response['status'] == "success") {
                          //         _walletCubit.getWalletData(
                          //             dateFilter: selectName);

                          //         AnywhereDoor.pop(context);
                          //       }
                          //     } else {
                          //       _walletCubit.getWalletData(
                          //           dateFilter: selectName);

                          //       AnywhereDoor.pop(context);
                          //     }
                          //   });
                          //   ;
                        },
                      ),
                      CustomSizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool checkUserBalanceIsGreaterThenZero(String balance) {
    if ((double.tryParse(balance) ?? 0) > 0) {
      return true;
    } else {
      return true;
    }
  }
}

enum AddMoneyContainer { none, one, two, three }
