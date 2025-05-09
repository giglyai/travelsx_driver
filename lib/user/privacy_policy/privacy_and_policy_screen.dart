import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/constants/app_styles/app_styles.dart';
import '../../shared/routes/navigator.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/size_config/size_config.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  State<PrivacyAndPolicyScreen> createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
  ScrollController _scrollController = ScrollController();

  DateTime _dateTime = DateTime.now();

  String? date;

  @override
  void initState() {
    super.initState();
    date = DateFormat('dd/MM/yyyy').format(_dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RawScrollbar(
            padding: EdgeInsets.only(right: 20 * SizeConfig.widthMultiplier!),
            thumbColor: AppColors.kBlack707070,
            thumbVisibility: true,
            controller: _scrollController,
            scrollbarOrientation: ScrollbarOrientation.right,
            thickness: 5 * SizeConfig.widthMultiplier!,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 26 * SizeConfig.widthMultiplier!,
                    right: 50 * SizeConfig.widthMultiplier!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(
                      height: 32,
                    ),
                    Text(
                      "Gigly Privacy Policy",
                      style: AppTextStyle.text24Bblack0000500,
                    ),
                    CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      "Last update on $date",
                      style: AppTextStyle.text14black0000W300,
                    ),
                    CustomSizedBox(
                      height: 24,
                    ),
                    Divider(),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "1. Information We Collect :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "1.1 Personal Information: We may collect personal information from you when you create an account, use our services, or communicate with us. This information may include your name, email address, phone number, profile picture, payment information, and other relevant details necessary to provide our services.\n\n"),
                          TextSpan(
                              text:
                                  "1.2 Location Information: To facilitate our driver ride and delivery services, we collect your device's location information when you use our app. This includes GPS signals and other information related to your location.\n\n"),
                          TextSpan(
                              text:
                                  "1.3 Usage Information: We collect information about how you interact with our app, such as the features you use, the content you view, and the actions you take. This data helps us improve our app and services.\n\n"),
                          TextSpan(
                              text:
                                  "1.4 Device Information: We may collect technical information about your device, such as the device model, operating system, and unique identifiers. This helps us ensure the compatibility and security of our app."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "2. How We Use Your Information :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "2.1 Service Provision: We use your personal information to provide the driver ride and delivery services you request. This includes matching you with drivers or delivery partners, processing payments, and facilitating communication between users.\n\n"),
                          TextSpan(
                              text:
                                  "2.2 Improvement of Services: We use the data we collect to improve and optimise our app and services. This includes analysing user behaviour, identifying trends, and making enhancements to enhance the user experience.\n\n"),
                          TextSpan(
                              text:
                                  "2.3 Communication: We may use your contact information to communicate with you regarding your account,transactions, and important updates related to our app and services.\n\n"),
                          TextSpan(
                              text:
                                  "2.4 Customer Support: We may use your information to respond to your inquiries, address your concerns, and provide customer support.\n\n"),
                          TextSpan(
                              text:
                                  "2.5 Account Deletion: To request the deletion of your account, please contact us at support@gigly.ai. Account deletion may take up to 7 working days to process.\n\n"),
                          TextSpan(
                              text:
                                  "2.6 Legal and Safety Purposes: We may use your information to comply with applicable laws, regulations, and legal processes. Additionally, we may use your data to protect the security and safety of our users, our app, and the general public."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "3. How We Share Your Information :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "3.1 Drivers and Delivery Partners: When you use our app for ride or delivery services, we share certain information, such as your name and location, with drivers or delivery partners to fulfil your requests.\n\n"),
                          TextSpan(
                              text:
                                  "3.2 Service Providers: We may share your information with third-party service providers who assist us in providing and maintaining our app and services. These providers are bound by confidentiality obligations and are not allowed to use your data for other purposes.\n\n"),
                          TextSpan(
                              text:
                                  "3.3 Legal Requirements: We may disclose your information in response to lawful requests, court orders, or legal processes. We may also share your data to protect our rights, privacy, safety, and property, as well as that of our users and others.\n\n"),
                          TextSpan(
                              text:
                                  "3.4 Business Transfers: In the event of a merger, acquisition, or sale of all or part of our business, your information may be transferred as part of the transaction. We will notify you of any such change and obtain your consent if required by law."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "4. Data Security :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "We take data security seriously and implement reasonable measures to protect your personal information from unauthorised access, disclosure, alteration, and destruction. However, no data transmission or storage system can be guaranteed to be 100% secure. Therefore, while we strive to protect your data, we cannot guarantee its absolute security."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "Account Deletion : To request the deletion of your account, please contact us at support@gigly.ai. Account deletion may take up to 7 working days to process."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "5. Children's Privacy :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(height: 14),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "Our app and services are not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us immediately at support@gigly.ai, and we will take appropriate steps to remove the information from our systems."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "6. Changes to the Privacy Policy :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "We may update this Privacy Policy from time to time to reflect changes in our practices and services. Any modifications will be effective immediately upon posting the updated policy on our app. Please review this policy periodically to stay informed about how we handle your information."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "7. Contact Us :",
                      style: AppTextStyle.text16black0000W700,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  "If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at admin@gigly.ai"),
                          TextSpan(
                              text:
                                  "By using Gigly, you consent to the collection, use, and sharing of your personal information as described in this Privacy Policy."),
                          TextSpan(text: "\n\nNote: "),
                          TextSpan(
                              text:
                                  "This is a general template for a privacy policy and may not cover all legal requirements. It's recommended to seek legal advice to ensure compliance with specific regulations and laws relevant to your app and its target audience."),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    BlueButton(
                      width: 328 * SizeConfig.widthMultiplier!,
                      height: 43 * SizeConfig.heightMultiplier!,
                      wantMargin: false,
                      borderRadius: 4 * SizeConfig.widthMultiplier!,
                      buttonColor: AppColors.kBlackTextColor,
                      title: "Go back",
                      onTap: () {
                        AnywhereDoor.pop(context);
                      },
                    ),
                    CustomSizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
