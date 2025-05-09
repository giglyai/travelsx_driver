import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/home/revamp/screen/new_driver_home_screen.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/revamp/imagePath/new_imagePath.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/user/earning/screens/earning_screen.dart';
import 'package:travelx_driver/user/trip/screens/trip_screen.dart';
import 'package:travelx_driver/user/vehicle/screen/my_vehicle_screen.dart';

class DriverBottomNavBar extends StatefulWidget {
  const DriverBottomNavBar({super.key});

  @override
  DriverBottomNavBarState createState() => DriverBottomNavBarState();
}

class DriverBottomNavBarState extends State<DriverBottomNavBar>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late PageController pageController;
  final ValueNotifier<int> selectedPageIndex = ValueNotifier<int>(0);

  late ScrollController _scrollController;
  bool _isNavBarVisible = true;
  double _bottomNavBarHeight = kBottomNavigationBarHeight;

  late MainHomeCubit mainHomeCubit;

  @override
  void initState() {
    super.initState();
    mainHomeCubit = context.read();
    mainHomeCubit.getUserData();
    pageController = PageController(
      initialPage: selectedPageIndex.value,
      keepPage: true,
    );
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = false;
            _bottomNavBarHeight = 0; // Hide the navbar
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = true;
            _bottomNavBarHeight = 70; // Show the navbar
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(
      context,
    ); // Call super.build to satisfy AutomaticKeepAliveClientMixin
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<MainHomeCubit, MainHomeState>(
        builder: (context, state) {
          return PageView(
            controller: pageController,
            onPageChanged: (value) {
              selectedPageIndex.value = value;
              setState(() {});
            },
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NewDriverHomeScreen(),
              UserTripScreen(),
              DriverVehicleScreen(fromHome: true),

              Earnings(wantBackButton: false),

              // NewInventoryScreen(
              //     params: NewInventoryScreenParams(
              //         inventoryCategoriesRes:
              //             state.sellerHomeModel?.data?.categories)),
              //
              // CartScreen(
              //   params: CartScreenParams(wantBackButton: false),
              // ),
            ],
          );
        },
      ),
      bottomNavigationBar:
          _isNavBarVisible
              ? SafeArea(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _bottomNavBarHeight,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFD7B5B5), width: 2),
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: _isNavBarVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(
                          imagePath: NewImagePath.homeNav,
                          index: 0,
                        ),
                        _buildNavItem(
                          imagePath: NewImagePath.orderNav,
                          index: 1,
                        ),
                        _buildNavItem(
                          imagePath: NewImagePath.addVehicleNav,
                          index: 2,
                        ),
                        _buildNavItem(
                          imagePath: NewImagePath.earningNav,
                          index: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildNavItem({
    required String imagePath,
    String? label,
    required int index,
  }) {
    final color =
        selectedPageIndex.value == index ? Colors.blue : Colors.black54;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPageIndex.value = index;
        });
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageLoader.svgPictureAssetImage(
            imagePath: imagePath,
            color:
                selectedPageIndex.value == index
                    ? AppColors.kPinkF4B5A4
                    : AppColors.kBlackTextColor,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
