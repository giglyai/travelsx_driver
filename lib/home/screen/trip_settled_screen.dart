import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/widgets/app_bar/gigly_app_bar.dart';
import 'package:travelx_driver/shared/widgets/google_map/google-map.widget.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/widgets/size_config/size_config.dart';
import '../widget/trip_settlement_amount/ride_settlement_amount_widget.dart';

class RideSettlementScreen extends StatefulWidget {
  RideSettlementScreen(
      {super.key,
      required this.settlementAmount,
      required this.pickupAddress,
      required this.dropupAddress,
      required this.currency});

  String settlementAmount;
  String pickupAddress;
  String dropupAddress;
  String currency;
  @override
  State<RideSettlementScreen> createState() => _RideSettlementScreenState();
}

class _RideSettlementScreenState extends State<RideSettlementScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: HomeDrawer(),
      body: Stack(
        children: [
          SizedBox(
            height: size.height * 1,
            child: GoogleMapWidget(),
          ),
          GestureDetector(
            onTap: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState!.openDrawer();
                //open drawer, if drawer is closed
              }
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40 * SizeConfig.heightMultiplier!,
                        left: 22 * SizeConfig.widthMultiplier!),
                    child: Icon(
                      Icons.menu,
                      size: 40 * SizeConfig.imageSizeMultiplier!,
                      color: AppColors.kBlackTextColor,
                    ),
                  ),
                  const Spacer(),
                  SizedBox.shrink(),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
              left: 20 * SizeConfig.widthMultiplier!,
              right: 21 * SizeConfig.widthMultiplier!,
              top: 100 * SizeConfig.heightMultiplier!,
              child: RideSettlementAmountCard(
                settlementAmount: widget.settlementAmount,
                pickupAddress: widget.pickupAddress,
                dropupAddress: widget.dropupAddress,
                currency: widget.currency,
              )),
        ],
      ),
    );
  }
}
