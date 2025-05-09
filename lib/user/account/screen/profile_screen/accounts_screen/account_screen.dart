// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/widgets/buttons/blue_button.dart';
import '../../../../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../../../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../../../../shared/widgets/size_config/size_config.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  TextEditingController companynameController = TextEditingController();
  TextEditingController modelnoController = TextEditingController();
  TextEditingController licenseplatenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RideBackButton(),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Text(
                'Add your vehicle',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company Name',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Verified',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              vechiledetails(companynameController),
              CustomSizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Model No',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Verified',
                    style: GoogleFonts.roboto(
                      fontSize: 14 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              vechiledetails(modelnoController),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Text(
                'License plate number',
                style: GoogleFonts.roboto(
                  fontSize: 14 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              vechiledetails(licenseplatenumberController),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: BlueButton(
                  buttonColor: Colors.black,
                  title: 'Save',
                ),
              ),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Text(
                'About Drivers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              CustomSizedBox(
                height: 20 * SizeConfig.heightMultiplier!,
              ),
              Text(
                'Photo of your drivers license',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              CustomSizedBox(
                height: 5 * SizeConfig.heightMultiplier!,
              ),
              Row(
                children: [
                  Container(
                    height: 72 * SizeConfig.heightMultiplier!,
                    width: 76 * SizeConfig.widthMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                  ),
                  CustomSizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 72 * SizeConfig.heightMultiplier!,
                    width: 76 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              CustomSizedBox(
                height: 5 * SizeConfig.heightMultiplier!,
              ),
              Text(
                'Photo of the driver',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              CustomSizedBox(
                height: 10 * SizeConfig.widthMultiplier!,
              ),
              Container(
                height: 72 * SizeConfig.heightMultiplier!,
                width: 76 * SizeConfig.widthMultiplier!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
              ),
              CustomSizedBox(height: 20 * SizeConfig.heightMultiplier!),
              Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: BlueButton(
                  buttonColor: Colors.black,
                  title: 'Edit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField vechiledetails(TextEditingController companynameController) {
    companynameController;
    modelnoController;
    licenseplatenumberController;
    return TextFormField(
      controller: companynameController,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            fontSize: 20 * SizeConfig.textMultiplier!,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
