import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/routes/navigator.dart';
import 'package:travelx_driver/shared/widgets/buttons/blue_button.dart';
import 'package:travelx_driver/shared/widgets/custom_sized_box/custom_sized_box.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
// import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';
// import 'package:gigly_travel_ride/shared/constants/app_colors/app_colors.dart';
// import 'package:gigly_travel_ride/shared/constants/app_styles/app_styles.dart';
// import 'package:gigly_travel_ride/shared/routes/navigator.dart';
// import 'package:gigly_travel_ride/shared/widgets/buttons/blue_button.dart';
// import 'package:gigly_travel_ride/shared/widgets/custom_sized_box/custom_sized_box.dart';
// import 'package:gigly_travel_ride/shared/widgets/size_config/size_config.dart';
import 'package:intl/intl.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
            thumbColor: AppColors.kBlack010101,
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
                      "Terms & Conditions",
                      style: AppTextStyle.text24Bblack0000W600,
                    ),
                    CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      "Last update on $date",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 24,
                    ),
                    Divider(),
                    CustomSizedBox(
                      height: 24,
                    ),
                    Text(
                      "This page states the Terms and Conditions under which you may visit this APP https://play.google.com/store/apps/details?id=com.byteplace.gigly.driver.ride&hl=en_US Please read this page carefully. If you do not accept the Terms and Conditions stated here, we would request you to exit this site. The business, any of its business divisions and / or its subsidiaries, associate companies or subsidiaries to subsidiaries or such other investment companies (in India or abroad) reserve their respective rights to revise these Terms and Conditions at any time by updating this posting. You should visit this page periodically to re-appraise yourself of the Terms and Conditions because they are binding on all users of this Website.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "USE OF CONTENT",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "All logos, brands, marks headings, labels, names, signatures,  or any combinations thereof, appearing in this site, except as otherwise noted, are properties either owned or used under licence, by the business and/or its associate entities who feature on this Website. The use of these properties or any other content on this site, except as provided in these terms and conditions or in the site content, is strictly prohibited.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "SECURITY RULES",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "Visitors are prohibited from violating or attempting to violate the security of the Web site, including, without limitation, (1) accessing data not intended for such user or logging into a server or account which the user is not authorised to access, (2) attempting to probe, scan or test the vulnerability of a system or network or to breach security or authentication measures without proper authorisation, (3) attempting to interfere with service to any user, host or network, including, without limitation, via means of submitting a virus or "
                      "Trojan horse"
                      " to the Website, overloading, "
                      "flooding"
                      ", "
                      "mail bombing"
                      " or "
                      "crashing"
                      ", or (4) sending unsolicited electronic mail, including promotions and/or advertising of products or services. Violations of system or network security may result in civil or criminal liability. The business and/or its associate entities will have the right to investigate occurrences that they suspect as involving such violations and will have the right to involve and cooperate with law enforcement authorities in prosecuting users who are involved in such violations.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "GENERAL RULES",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "Visitors may not use the Web Site in order to transmit, distribute, store or destroy material (a) that could constitute or encourage conduct that would be considered a criminal offence or violate any applicable law or regulation, (b) in a manner that will infringe the copyright, trademark, trade secret or other intellectual property rights of others or violate the privacy or publicity of other personal rights of others, or (c) that is libellous, defamatory, pornographic, profane, obscene, threatening, abusive or hateful.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "INEMNITY",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(height: 14),
                    Text(
                      "The User unilaterally agree to indemnify and hold harmless, without objection, the Company, its officers, directors, employees and agents from and against any claims, actions and/or demands and/or liabilities and/or losses and/or damages whatsoever arising from or resulting from their use of GIGLY or their breach of the terms",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "LIABILITY",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "User agrees that neither GIGLY nor its group companies, directors, officers or employee shall be liable for any direct or/and indirect or/and incidental or/and special or/and consequential or/and exemplary damages, resulting from the use or/and the inability to use the service or/and for cost of procurement of substitute goods or/and services or resulting from any goods or/and data or/and information or/and services purchased or/and obtained or/and messages received or/and transactions entered into through or/and from the service or/and resulting from unauthorized access to or/and alteration of user's transmissions or/and data or/and arising from any other matter relating to the service, including but not limited to, damages for loss of profits or/and use or/and data or other intangible, even if  GIGLY  has been advised of the possibility of such damages.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "User further agrees that GIGLY shall not be liable for any damages arising from interruption, suspension or termination of service, including but not limited to direct or/and indirect or/and incidental or/and special consequential or/and exemplary damages, whether such interruption or/and suspension or/and termination was justified or not, negligent or intentional, inadvertent or advertent.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "User agrees thatGIGLY shall not be responsible or liable to the user, or anyone, for the statements or conduct of any third party of the service. In sum, in no event shall Company's total liability to the User for all damages or/and losses or/and causes of action exceed the amount paid by the User to GIGLY, if any, that is related to the cause of action.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "DISCLAIMER OF CONSEQUENTIAL DAMAGES",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "In no event shall Company or any parties, organizations or entities associated with the corporate brand name us or otherwise, mentioned at this Website be liable for any damages whatsoever (including, without limitations, incidental and consequential damages, lost profits, or damage to computer hardware or loss of data information or business interruption) resulting from the use or inability to use the Website and the Website material, whether based on warranty, contract, tort, or any other legal theory, and whether or not, such organization or entities were advised of the possibility of such damages.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "CANCELLATION POLICY:",
                      style: AppTextStyle.text14black0000W500,
                    ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    Text(
                      "Cancellations by Rider:",
                      style: AppTextStyle.text14black0000W400,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "* Before Driver Accepts:Full refund is issued.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* After Driver Accepts but Before Pickup:",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* Free cancellation within a set time window (e.g., 5 minutes) after booking confirmation. A small cancellation fee may apply outside this window (optional).",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* Before Driver Accepts:Full refund is issued.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* After Pickup:No refund is issued unless the cancellation is due to:",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* Driver not arriving within a reasonable timeframe (defined by app).",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* Before Pickup:Rider receives a full refund and may be offered a voucher or discount for future rides.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* After Pickup:Rider receives a full refund if the ride is not completed due to driver fault (e.g., car breakdown, detour without reason).",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "General Exceptions:",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    Text(
                      "* Refunds may not be applicable in case of fraudulent activity or abuse of the cancellation policy.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* The app reserves the right to review cancellation requests on a case-by-case basis.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "* All refunds will be settled within 7 working days.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
                    ),
                    Text(
                      "Cancellations by Travel/Driver",
                      style: AppTextStyle.text14black0000W400,
                    ),
                    CustomSizedBox(
                      height: 14,
                    ),
                    Text(
                      "* Before Pickup:Rider receives a full refund and may be offered a voucher or discount for future rides.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* After Pickup:Rider receives a full refund if the ride is not completed due to driver fault (e.g., car breakdown, detour without reason).",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* After Pickup:A partial refund may be issued at the app's discretion if the ride is not completed due to factors beyond the driver's control (e.g., rider no-show, road closure).",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "General Exceptions:",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* Refunds may not be applicable in case of fraudulent activity or abuse of the cancellation policy.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* The app reserves the right to review cancellation requests on a case-by-case basis.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "* All refunds will be settled within 7 working days.",
                      style: AppTextStyle.text12black0000W300,
                    ),
                    CustomSizedBox(
                      height: 26,
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
