import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/login/bloc/login_cubit.dart';
import 'package:travelx_driver/login/bloc/login_state.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/country_list_widget/country_list_bottomsheet.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

class MobileNumberLoginBottomSheet {
  static void show(BuildContext context, String email) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // This ensures the bottom sheet takes full height
      backgroundColor: AppColors.kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _MobileNumberLoginContent(email: email),
    );
  }
}

class _MobileNumberLoginContent extends StatefulWidget {
  final String email;
  const _MobileNumberLoginContent({Key? key, required this.email})
    : super(key: key);

  @override
  __MobileNumberLoginContentState createState() =>
      __MobileNumberLoginContentState();
}

class __MobileNumberLoginContentState extends State<_MobileNumberLoginContent> {
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final GlobalKey<FormState> phoneNumberKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  late ServiceLoginCubit _loginCubit;
  bool isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<ServiceLoginCubit>(context);
    countryCodeController.text = "91";
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    countryCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String value) {
    setState(() {
      isLoginButtonEnabled = value.length > 5;
    });
  }

  void _onLoginButtonPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (phoneNumberKey.currentState?.validate() ?? false) {
      _loginCubit.bottomSheetLoginWithMobileNumber(
        countryCode: countryCodeController.text,
        phoneNumber: phoneNumber.text,
        email: widget.email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20 * SizeConfig.widthMultiplier!,
        right: 20 * SizeConfig.widthMultiplier!,
        top: 20 * SizeConfig.heightMultiplier!,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: SingleChildScrollView(
        // Enables scrolling when keyboard is open
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter your mobile number with country code",
              style: AppTextStyle.text20black0000W600,
            ),
            CustomSizedBox(height: 10),
            _buildPhoneNumberInput(),
            CustomSizedBox(height: 30),
            BlocBuilder<ServiceLoginCubit, LoginState>(
              builder: (context, state) {
                return BlueButton(
                  title: "Continue",
                  wantMargin: false,
                  isLoading: state is PhoneNumberLoading,
                  buttonIsEnabled: isLoginButtonEnabled,
                  onTap: _onLoginButtonPressed,
                );
              },
            ),
            CustomSizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput({String? defaultCountryCode}) {
    if (defaultCountryCode != null) {
      countryCodeController.text = defaultCountryCode;
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical:
            8 *
            SizeConfig
                .heightMultiplier!, // Adjust vertical padding for smaller height
      ),
      child: Row(
        children: [
          // Country Code Field
          GestureDetector(
            onTap: () {
              CountryListBottomSheet().countryBottomSheet(
                context: context,
                onTap: (country, getCountryId, code, flag) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    countryCodeController.text = code ?? "";

                    // validateUserInput();
                    setState(() {});
                  });

                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 11 * SizeConfig.widthMultiplier!,
                right: 5 * SizeConfig.widthMultiplier!,
                top: 11 * SizeConfig.heightMultiplier!,
                bottom: 11 * SizeConfig.heightMultiplier!,
              ),
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                border: Border.all(color: AppColors.kBlackTextColor),
                borderRadius: BorderRadius.circular(
                  4 * SizeConfig.widthMultiplier!,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "+${countryCodeController.text}",
                    style: _inputTextStyle(),
                  ),
                  CustomSizedBox(width: 5),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),

          CustomSizedBox(width: 10),
          // Phone Number Field
          Expanded(
            child: Form(
              key: phoneNumberKey,
              child: TextField(
                controller: phoneNumber,
                focusNode: focusNode,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                autofillHints: [AutofillHints.username],
                onChanged: _onPhoneNumberChanged,
                style: _inputTextStyle(),
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10 * SizeConfig.widthMultiplier!,
                    vertical: 10.0 * SizeConfig.heightMultiplier!,
                  ), // Reduce height here
                  fillColor: AppColors.kWhiteFFFF,
                  hintStyle: AppTextStyle.text14black0000W500,
                  filled: true,
                  enabledBorder: _inputBorder(),
                  focusedBorder: _inputBorder(),
                ),
              ),
            ),
          ),
        ],
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
    borderSide: BorderSide(color: AppColors.kblack333333),
    borderRadius: BorderRadius.circular(0 * SizeConfig.widthMultiplier!),
  );
}
