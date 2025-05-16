import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:shimmer/shimmer.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/constants/app_styles/app_styles.dart';
import '../../../../shared/constants/imagePath/image_paths.dart';
import '../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../shared/widgets/size_config/size_config.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class MobileNumberLoginScreen extends StatefulWidget {
  const MobileNumberLoginScreen({super.key});

  @override
  _MobileNumberLoginScreenState createState() =>
      _MobileNumberLoginScreenState();
}

class _MobileNumberLoginScreenState extends State<MobileNumberLoginScreen> {
  /// Controllers
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  /// Bloc
  late ServiceLoginCubit _loginCubit;

  /// State variables
  bool isLoginButtonEnabled = false;

  bool isLoading = false; // Track the loading state

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);

    //countryCodeController.text = "91";
  }

  String selectedCountryID = "";

  @override
  void dispose() {
    phoneNumber.dispose();

    countryCodeController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  /// Handles login button enable/disable logic based on phone number length
  void _onPhoneNumberChanged(String value) {
    setState(() {
      isLoginButtonEnabled =
          value.length > 5; // Enable button for >5 characters
    });
  }

  bool showPasscodeField = false;
  final TextEditingController passcodeController = TextEditingController();
  int pointerCount = 0;

  void _onPointerDown(PointerDownEvent event) {
    pointerCount++;
  }

  void _onPointerUp(PointerUpEvent event) {
    if (pointerCount == 4) {
      setState(() {
        showPasscodeField = true;
      });
    }
    pointerCount = 0; // Reset after gesture
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.splashBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Hidden long press dev trigger
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  showPasscodeField = true;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 40 * SizeConfig.heightMultiplier!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                if (F.appFlavor == Flavor.kurinjidriver)
                  ImageLoader.assetImage(
                    imagePath: ImagePath.splashKurinjiIcon,
                    height: 200 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  )
                else if (F.appFlavor == Flavor.travelsxdriver)
                  ImageLoader.assetImage(
                    imagePath: ImagePath.splashTravelsxIcon,
                    height: 200 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  )
                else
                  ImageLoader.svgPictureAssetImage(
                    imagePath: ImagePath.giglyDriverSplashLogoFinal,
                    height: 110 * SizeConfig.heightMultiplier!,
                    width: 196 * SizeConfig.widthMultiplier!,
                  ),

                const Spacer(),

                /// Input Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20 * SizeConfig.widthMultiplier!,
                      // bottom: 6, // slight spacing below label
                    ),
                    child: Text(
                      "Enter your email address",
                      style: AppTextStyle.text14black0000W800?.copyWith(
                        fontSize: 20, // slightly increased for clarity
                        color: Colors.black87, // more legible than pure black
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Phone Number Input
                _buildPhoneNumberInput(),

                /// Optional Passcode Field
                if (showPasscodeField) ...[
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * SizeConfig.widthMultiplier!,
                    ),
                    child: TextFormField(
                      controller: passcodeController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Passcode",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                /// Login Button
                BlocConsumer<ServiceLoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is PhoneNumberSuccess) {
                      // Handle success
                    } else if (state is PhoneNumberFailure) {
                      // Handle error
                    }
                  },
                  builder: (context, state) {
                    return BlueButton(
                      borderRadius: 4 * SizeConfig.widthMultiplier!,
                      title: "Continue",
                      isLoading: state is PhoneNumberLoading,
                      wantMargin: true,
                      buttonIsEnabled: isLoginButtonEnabled,
                      onTap: _onLoginButtonPressed,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the phone number input field
  Widget _buildPhoneNumberInput({String? defaultCountryCode}) {
    if (defaultCountryCode != null) {
      countryCodeController.text = defaultCountryCode;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * SizeConfig.widthMultiplier!,
        vertical:
            8 *
            SizeConfig
                .heightMultiplier!, // Adjust vertical padding for smaller height
      ),
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: phoneNumberKey,
              child: Theme(
                data: ThemeData(hintColor: const Color(0x33adadad)),
                child: TextField(
                  autofillHints: const <String>[AutofillHints.username],
                  onSubmitted: (value) {
                    phoneNumberKey.currentState?.validate();
                  },
                  onChanged: (v) {
                    setState(() {});
                    if (v.length > 9) {
                      isLoginButtonEnabled = true;
                    } else {
                      isLoginButtonEnabled = false;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.next,
                  controller: phoneNumber,
                  style: TextStyle(
                    color: AppColors.kBlackTextColor.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                    fontSize: 20 * SizeConfig.textMultiplier!,
                  ),
                  decoration: InputDecoration(
                    prefix: SizedBox(width: 20 * SizeConfig.widthMultiplier!),
                    hintStyle: AppTextStyle.text14kBlackTextColorW500,
                    hintText: "Enter your mobile number",
                    fillColor: AppColors.kWhiteFFFF,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5 * SizeConfig.widthMultiplier!),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteFFFF,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5 * SizeConfig.widthMultiplier!),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteFFFF,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        4 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        top: 10 * SizeConfig.heightMultiplier!,
                        left: 15 * SizeConfig.widthMultiplier!,
                      ),
                      child: Text(
                        "+91",
                        style: TextStyle(
                          color: AppColors.kBlackTextColor.withOpacity(0.87),
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        // child: Form(
        //   key: phoneNumberKey,
        //   child: TextFormField(
        //     controller: phoneNumber,
        //     focusNode: focusNode,
        //     keyboardType: TextInputType.emailAddress,
        //     textInputAction: TextInputAction.next,
        //     autofillHints: [AutofillHints.username],
        //     onChanged: _onPhoneNumberChanged,
        //     style: _inputTextStyle(),
        //     validator: (value) {
        //       final input = value?.trim() ?? '';
        //       if (input.isEmpty) {
        //         return 'Please enter email';
        //       }

        //       // Email regex
        //       final isEmail = RegExp(
        //         r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
        //       ).hasMatch(input);

        //       // Phone regex (must start with + and country code, min 8 to 15 digits total)
        //       final isPhone = RegExp(
        //         r'^(\+?\d{1,4})?\d{6,14}$',
        //       ).hasMatch(input);

        //       if (!isEmail && !isPhone) {
        //         return 'Enter a valid email or phone number';
        //       }

        //       return null;
        //     },
        //     decoration: InputDecoration(
        //       hintText: "email",
        //       contentPadding: EdgeInsets.symmetric(
        //         horizontal: 10 * SizeConfig.widthMultiplier!,
        //         vertical: 10.0 * SizeConfig.heightMultiplier!,
        //       ),
        //       fillColor: AppColors.kWhiteFFFF,
        //       hintStyle: AppTextStyle.text14black0000W500,
        //       filled: true,
        //       enabledBorder: _inputBorder(),
        //       focusedBorder: _inputBorder(),
        //     ),
        //   ),
        // ),
        //),
        //   ],
      ),
    );
  }
  // Country Code Field

  // GestureDetector(
  //   onTap: () {
  //     CountryListBottomSheet().countryBottomSheet(
  //         context: context,
  //         onTap: (country, getCountryId, code, flag) {
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             countryCodeController.text = code ?? "";
  //             selectedCountryID = getCountryId;
  //             // validateUserInput();
  //             setState(() {});
  //           });
  //
  //           Navigator.pop(context);
  //         });
  //   },
  //   child: Container(
  //     padding: EdgeInsets.only(
  //       left: 11 * SizeConfig.widthMultiplier!,
  //       right: 5 * SizeConfig.widthMultiplier!,
  //       top: 11 * SizeConfig.heightMultiplier!,
  //       bottom: 11 * SizeConfig.heightMultiplier!,
  //     ),
  //     decoration: BoxDecoration(
  //         color: AppColors.kWhite,
  //         borderRadius:
  //             BorderRadius.circular(4 * SizeConfig.widthMultiplier!)),
  //     child: Row(
  //       children: [
  //         Text(
  //           "+${countryCodeController.text}",
  //           style: _inputTextStyle(),
  //         ),
  //         CustomSizedBox(
  //           width: 5,
  //         ),
  //         Icon(Icons.arrow_drop_down)
  //       ],
  //     ),
  //   ),
  // ),

  // GestureDetector(
  //   onTap: () {
  //
  //   },
  //   child: SizedBox(
  //     width: 95 * SizeConfig.widthMultiplier!,
  //     child: TextField(
  //       enabled: false,
  //       keyboardType: TextInputType.phone,
  //       textInputAction: TextInputAction.next,
  //       controller: countryCodeController,
  //       style: _inputTextStyle(),
  //       decoration: InputDecoration(
  //           prefixText: "+",
  //           contentPadding: EdgeInsets.symmetric(
  //               horizontal: 5 * SizeConfig.widthMultiplier!,
  //               vertical: 10.0 *
  //                   SizeConfig.heightMultiplier!), // Reduce height here
  //           fillColor: AppColors.kWhiteFFFF,
  //           filled: true,
  //           enabledBorder: _inputBorder(),
  //           focusedBorder: _inputBorder(),
  //           suffixIcon: Icon(Icons.arrow_drop_down)),
  //     ),
  //   ),
  // ),

  // CustomSizedBox(
  //   width: 10,
  // ),
  // Phone Number Field

  /// Handles login button press
  void _onLoginButtonPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (phoneNumberKey.currentState?.validate() ?? false) {
      final input = phoneNumber.text.trim();

      // Use regex to detect if input is an email or phone number
      final isEmail = RegExp(
        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
      ).hasMatch(input);

      _loginCubit.loginWithMobileNumber(
        countryCode: isEmail ? null : countryCodeController.text,
        phoneNumber: isEmail ? null : input,
        email: isEmail ? input : null,
        passcode: showPasscodeField ? int.parse(passcodeController.text) : null,
      );
    }
  }

  /// Shimmer widget for loading state
  Widget _shimmerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * SizeConfig.widthMultiplier!,
      ),
      child: Row(
        children: [
          _shimmerBox(width: 75 * SizeConfig.widthMultiplier!),
          SizedBox(width: 10 * SizeConfig.widthMultiplier!),
          Expanded(child: _shimmerBox()),
        ],
      ),
    );
  }

  /// Helper for shimmer box
  Widget _shimmerBox({double? width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: 48 * SizeConfig.heightMultiplier!,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Input field text style
  TextStyle _inputTextStyle() => TextStyle(
    color: AppColors.kBlackTextColor.withOpacity(0.87),
    fontWeight: FontWeight.w600,
    fontSize: 20 * SizeConfig.textMultiplier!,
  );

  /// Input field border style
  OutlineInputBorder _inputBorder() => OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.kWhiteFFFF),
    borderRadius: BorderRadius.circular(0 * SizeConfig.widthMultiplier!),
  );

  Future<void> showLocationBottomSheet() async {
    bool isLoading = false;

    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * SizeConfig.widthMultiplier!),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState1) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20 * SizeConfig.widthMultiplier!,
                      ),
                      topRight: Radius.circular(
                        20 * SizeConfig.widthMultiplier!,
                      ),
                    ),
                  ),
                  height: 400 * SizeConfig.heightMultiplier!,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      ImageLoader.assetImage(
                        imagePath: ImagePath.mapPinIcon,
                        height: 120 * SizeConfig.heightMultiplier!,
                        width: 120 * SizeConfig.widthMultiplier!,
                        filterQuality: FilterQuality.low,
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      Text(
                        "Location permission is off",
                        style: TextStyle(
                          fontSize: 20 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10 * SizeConfig.heightMultiplier!),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * SizeConfig.widthMultiplier!,
                        ),
                        child: Text(
                          "Please enable location permission for a better delivery experience.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16 * SizeConfig.textMultiplier!,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * SizeConfig.heightMultiplier!),
                      BlueButton(
                        buttonColor: Colors.pink,
                        title: "Continue",
                        isLoading: isLoading,
                        onTap: () async {
                          // Set loading state with mounted check
                          if (mounted) {
                            setState1(() {
                              isLoading = true;
                            });
                          }

                          // Loop to handle permission changes
                          bool exitLoop = false;
                          while (!exitLoop) {
                            LocationPermission permission =
                                await Geolocator.requestPermission();

                            if (permission == LocationPermission.always ||
                                permission == LocationPermission.whileInUse) {
                              // Permission granted, close bottom sheet
                              if (mounted) {
                                AnywhereDoor.pop(context);
                                await _loginCubit.getCountryCode();
                              }
                              exitLoop = true;
                            } else if (permission ==
                                LocationPermission.deniedForever) {
                              // Open app settings immediately
                              await Geolocator.openAppSettings();
                            } else {
                              // Permission denied, retry
                              continue;
                            }
                          }

                          // Reset loading state with mounted check
                          if (mounted) {
                            setState1(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
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
}
