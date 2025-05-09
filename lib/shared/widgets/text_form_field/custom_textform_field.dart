// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CustomTextFromField extends StatelessWidget {
  CustomTextFromField(
      {Key? key,
      this.hintText,
      this.errorText,
      this.customInputFormatters,
      this.controller,
      this.textStyle,
      this.hintTextStyle,
      this.validator,
      this.minLines,
      this.maxLines,
      this.onChanged,
      this.autoFillHints,
      this.onFieldSubmitted,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.textInputAction,
      this.cursorRadius,
      this.cursorColor,
      this.obscureText = false,
      this.wantFilledColor = false,
      this.cursorHeight,
      this.filledColor,
      this.focusedColorBorder,
      this.hintTextColor,
      this.hintTextSize,
      this.textStyleSize,
      this.textStyleColor,
      this.readOnly,
      this.enabled,
      this.autoValidateMode,
      this.autoFocus,
      this.onEditingComplete,
      this.outLineBorderRadius,
      this.disabledBorder,
      this.focusedBorder,
      this.focusedErrorBorder,
      this.topPadding,
      this.leftPadding,
      this.margin,
      this.wantDisabledBorder = false,
      this.enabledColorBorder,
      this.textAlignVertical,
      this.wantBorderColorWidth = false,
      this.textCapitalization,
        this.wantDisabledBorderColor,

        this.textAlign})
      : super(key: key);

  TextInputType? keyboardType;
  int? minLines;
  int? maxLines;
  String? hintText;
  String? errorText;
  TextEditingController? controller;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onFieldSubmitted;
  List<TextInputFormatter>? customInputFormatters;
  String? Function(String?)? validator;
  Iterable<String>? autoFillHints;
  Widget? prefixIcon;
  Widget? suffixIcon;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  Radius? cursorRadius;
  Color? cursorColor;
  Color? focusedColorBorder;
  Color? enabledColorBorder;
  bool? obscureText;
  double? cursorHeight;
  bool wantFilledColor;
  Color? filledColor;
  Color? hintTextColor;
  double? hintTextSize;
  bool wantBorderColorWidth;
  Color? textStyleColor;
  double? textStyleSize;
  bool? enabled;
  bool? readOnly;
  AutovalidateMode? autoValidateMode;
  bool? autoFocus;
  void Function()? onEditingComplete;

  double? outLineBorderRadius;
  double? focusedErrorBorder;
  double? disabledBorder;
  double? focusedBorder;
  bool wantDisabledBorder;
  double? topPadding;
  double? leftPadding;
  EdgeInsetsGeometry? margin;

  TextAlignVertical? textAlignVertical;
  TextAlign? textAlign;
  TextCapitalization? textCapitalization;
  Color? wantDisabledBorderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          EdgeInsets.only(
              left: 10 * SizeConfig.widthMultiplier!,
              right: 10 * SizeConfig.widthMultiplier!),
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onEditingComplete: onEditingComplete,
        autofocus: autoFocus ?? false,
        enabled: enabled ?? true,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
        readOnly: readOnly ?? false,
        cursorHeight: cursorHeight,
        obscureText: obscureText ?? false,
        cursorRadius:
            cursorRadius ?? Radius.circular(4 * SizeConfig.widthMultiplier!),
        textInputAction: textInputAction,
        focusNode: focusNode,
        cursorColor: cursorColor ?? AppColors.kGreenSolid,
        autofillHints: autoFillHints,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        keyboardType: keyboardType,
        textAlignVertical: textAlignVertical,
        textAlign: textAlign ?? TextAlign.start,
        style: textStyle ??
            TextStyle(
                fontSize: textStyleSize ?? 15 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w500,
                color: textStyleColor ?? AppColors.kBlackTextColor),
        controller: controller,
        inputFormatters: customInputFormatters,
        validator: validator,
        decoration: InputDecoration(
          filled: wantFilledColor,
          suffixIcon: suffixIcon != null
              ? SizedBox(
                  width: 45 * SizeConfig.widthMultiplier!,
                  child: suffixIcon,
                )
              : null,
          prefixIcon: prefixIcon,
          hintStyle: hintTextStyle ??
              TextStyle(
                  fontSize: hintTextSize ?? 14 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w400,
                  color: hintTextColor ??
                      AppColors.kBlackTextColor.withOpacity(0.60)),
          hintText: hintText,
          contentPadding: EdgeInsets.only(
            top: topPadding ?? 30 * SizeConfig.heightMultiplier!,
            left: leftPadding ?? 10 * SizeConfig.widthMultiplier!,
          ),
          errorText: errorText?.isNotEmpty == true ? errorText : null,
          errorStyle: TextStyle(
              color: Colors.red, fontSize: SizeConfig.textMultiplier! * 11),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
            borderRadius: BorderRadius.circular(
                focusedErrorBorder ?? 5 * SizeConfig.widthMultiplier!),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.2),
          ),
          disabledBorder: wantDisabledBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      disabledBorder ?? 5 * SizeConfig.widthMultiplier!),
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.25), width: 1.2))
              :  OutlineInputBorder(
                  borderSide: BorderSide(color: wantDisabledBorderColor ?? Color(0xffFFFFFF), width: 1.2),
                ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                focusedBorder ?? 4 * SizeConfig.widthMultiplier!),
            borderSide: BorderSide(
                color: focusedColorBorder ?? AppColors.kBlackTextColor,
                width: 1),
          ),
          enabledBorder: wantBorderColorWidth
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      outLineBorderRadius ?? 5 * SizeConfig.widthMultiplier!),
                  borderSide: BorderSide(
                      color: enabledColorBorder ??
                          AppColors.kBlackTextColor.withOpacity(0.5),
                      width: 1.5),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      outLineBorderRadius ?? 5 * SizeConfig.widthMultiplier!),
                  borderSide: BorderSide(
                      color: enabledColorBorder ??
                          AppColors.kBlackTextColor.withOpacity(0.5),
                      width: 1),
                ),
        ),
      ),
    );
  }
}


class FieldState<T> {
  final T value;
  final bool isActive;
  final String error;
  Color? errorColor;
  final T? name;

  FieldState({
    required this.value,
    this.isActive = false,
    required this.error,
    this.errorColor,
    this.name,
  });

  FieldState.initial({
    required T value,
    bool? isActive,
    T? name,
  }) : this(
    value: value,
    isActive: isActive ?? true,
    error: '',
    errorColor: AppColors.kredDF0000,
    name: name,
  );

  FieldState<T> copyWith({
    T? value,
    bool? isActive,
    String? error,
    Color? errorColor,
    T? name,
  }) {
    return FieldState(
      value: value ?? this.value,
      isActive: isActive ?? this.isActive,
      error: error ?? this.error,
      errorColor: errorColor ?? this.errorColor,
      name: name ?? this.name,
    );
  }
}

class FileState<T> {
  final T? file;
  final String error;
  final String type;

  FileState({
    this.file,
    required this.error,
    required this.type,
  });

  FileState.initial({
    T? file,
    required String type,
  }) : this(
    error: '',
    file: file,
    type: type,
  );

  FileState<T> copyWith({
    String? error,
    String? type,
    T? file,
  }) {
    return FileState(
      error: error ?? this.error,
      file: file ?? this.file,
      type: type ?? this.type,
    );
  }

  FileState<T> deleteFile() {
    return FileState(
      error: this.error,
      file: null,
      type: this.type,
    );
  }
}