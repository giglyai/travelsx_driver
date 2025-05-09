// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:travelx_driver/home/bloc/home_cubit.dart';
// import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
// import 'package:travelx_driver/shared/routes/named_routes.dart';
// import 'package:travelx_driver/shared/routes/navigator.dart';
//
// class OverlayWidget extends StatefulWidget {
//   const OverlayWidget({Key? key}) : super(key: key);
//
//   @override
//   State<OverlayWidget> createState() => _OverlayWidgetState();
// }
//
// class _OverlayWidgetState extends State<OverlayWidget> {
//   late HomeCubit _homeCubit;
//
//   postcurrentLocation() async {
//     await _homeCubit.initiateCurrentLocationTimer();
//   }
//   @override
//   void initState() {
//     _homeCubit = BlocProvider.of<HomeCubit>(context);
//
//     super.initState();
//     postcurrentLocation();
//     FlutterOverlayWindow.overlayListener.listen((event) {
//        HomeCubit().postUserCurrentLocation();
//       log("$event");
//
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           width: double.infinity,
//           decoration: BoxDecoration(
//            color:  AppColors.red534A,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: GestureDetector(
//             onTap: () {
//
//
//
//               FlutterOverlayWindow.shareData("Heyy this is a data from the overlay");
//             },
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     ListTile(
//                       leading: Container(
//                         height: 80.0,
//                         width: 80.0,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black54),
//                           shape: BoxShape.circle,
//                           image: const DecorationImage(
//                             image: NetworkImage(
//                                 "https://api.multiavatar.com/x-slayer.png"),
//                           ),
//                         ),
//                       ),
//                       title: const Text(
//                         "X-SLAYER",
//                         style: TextStyle(
//                             fontSize: 20.0, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: const Text("Sousse , Tunisia"),
//                     ),
//
//                   ],
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: IconButton(
//                     onPressed: () async {
//                       await FlutterOverlayWindow.closeOverlay();
//                     },
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
