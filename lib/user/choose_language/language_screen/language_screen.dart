import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/app_styles/app_styles.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../shared/widgets/size_config/size_config.dart';
import '../../../shared/widgets/text_form_field/custom_textform_field.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {

  bool isMissingDocContainerOpened = false;
  int? selectedDocIndex;
  List<String> languageList = [];
  TextEditingController languageController = TextEditingController();
  @override
  void initState() {
    languageList = ['हिंदी',
    'English'
    ];
    languageController.text='choose_language_op'.tr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RideBackButton(),
              CustomSizedBox(
                width: 50,
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 45 * SizeConfig.heightMultiplier!),
                child: Text(
                  'select_your_language'.tr,
                  style: AppTextStyle.text18black0000W600,
                ),
              ),
            ],
          ),
          CustomSizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(
                left: 60.0 * SizeConfig.widthMultiplier!,
                right: 20 * SizeConfig.widthMultiplier!),
            child: Text(
              'you_can_change_your_language_on_this_screen_anytime'.tr,
              style: AppTextStyle.text14black0000W500
                  ?.copyWith(
                  color: AppColors.kBlackTextColor
                      .withOpacity(0.50)),
            ),
          ),
          CustomSizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(
                left: 20.0 * SizeConfig.widthMultiplier!,
                right: 20 * SizeConfig.widthMultiplier!),
            child: Text(
              'language'.tr,
              style: AppTextStyle.text14black0000W600?.copyWith(color: AppColors.kBlackTextColor.withOpacity(0.40)),
            ),
          ),
          CustomSizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMissingDocContainerOpened =
                !isMissingDocContainerOpened;
              });
            },
            child: CustomTextFromField(
              controller: languageController,
              hintText: languageController.text,
              enabled: false,
              wantFilledColor: true,
              wantDisabledBorder: true,
              filledColor: AppColors.kWhite,
              hintTextStyle:
              AppTextStyle.text14kblack333333W600,
              suffixIcon: ImageLoader.svgPictureAssetImage(
                  imagePath: ImagePath.arrowIcon),
            ),
          ),
          if (isMissingDocContainerOpened == true)
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal:
                  22 * SizeConfig.widthMultiplier!),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kBlackTextColor
                        .withOpacity(0.15),
                    blurRadius: 3, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ],
              ),
              child: Wrap(
                children: List.generate(
                    languageList.length, (index) {
                  final language = languageList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        languageController.text= language;
                        selectedDocIndex = index;
                        isMissingDocContainerOpened =false;
                      });
                      if(languageController.text== 'हिंदी'){
                        Get.updateLocale(const Locale('hi', 'IN'));
                      }
                      else if(languageController.text== 'English'){
                        Get.updateLocale(const Locale('en', 'Us'));
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 *
                              SizeConfig.widthMultiplier!,
                          vertical: 10 *
                              SizeConfig.heightMultiplier!,
                        ),
                        decoration: BoxDecoration(
                          color: selectedDocIndex == index
                              ? AppColors.kWhite
                              : AppColors.kGreyFAF9F9,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              language ?? "",
                              style: AppTextStyle
                                  .text14kblack333333W600,
                            ),
                            Spacer(),
                            Text("")
                          ],
                        )),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
