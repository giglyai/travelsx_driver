import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/app_colors/app_colors.dart';
import '../../../shared/constants/imagePath/image_paths.dart';
import '../../../shared/utils/image_loader/image_loader.dart';
import '../../../shared/widgets/size_config/size_config.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.availableCameras,
  });

  final CameraDescription camera;
  final List<CameraDescription> availableCameras;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  FlashMode flashMode = FlashMode.auto;
  CameraDescription? camera;
  bool isPreview = false;
  XFile? image;
  List<FlashMode> flashModes = [
    FlashMode.auto,
    FlashMode.always,
    FlashMode.torch,
    FlashMode.off
  ];
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }

  IconData getFlashIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.torch:
        return Icons.highlight;
      case FlashMode.off:
        return Icons.flash_off;
    }
  }

  void logError(String code, String? message) {
    if (message != null) {
      print('Error: $code\nError Message: $message');
    } else {
      print('Error: $code');
    }
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isPreview
          ? cameraPreview(
              image?.path,
            )
          : Column(
              children: [
                Expanded(
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the Future is complete, display the preview.
                        return CameraPreview(_controller);
                      } else {
                        // Otherwise, display a loading indicator.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //camera toggle
                      // ImageLoader.assetImage(
                      //     imagePath: ImagePath.flipCamera,
                      //     width: 50 * SizeConfig.widthMultiplier!,
                      //     height: 50 * SizeConfig.heightMultiplier!),

                      if (widget.availableCameras.length >= 2)
                        GestureDetector(
                          onTap: () async {
                            final camerasToToggleIndex = (widget
                                    .availableCameras
                                    .indexOf(camera ?? widget.camera)) +
                                1;
                            if (camerasToToggleIndex <
                                widget.availableCameras.length) {
                              camera =
                                  widget.availableCameras[camerasToToggleIndex];
                              await _controller.setDescription(camera!);
                            } else {
                              camera = widget.availableCameras[0];
                              await _controller.setDescription(
                                camera!,
                              );
                            }
                            _controller.addListener(() {
                              if (mounted) setState(() {});
                              if (_controller.value.hasError) {
                                log('Camera error ${_controller.value.errorDescription}');
                              }
                            });
                          },
                          child: Icon(
                            getCameraLensIcon(camera?.lensDirection ??
                                widget.camera.lensDirection),
                            color: AppColors.kWhite,
                          ),
                        ),
                      GestureDetector(
                        onTap: () async {
                          // Take the Picture in a try / catch block. If anything goes wrong,
                          // catch the error.
                          try {
                            // Ensure that the camera is initialized.
                            await _initializeControllerFuture;

                            // Attempt to take a picture and get the file `image`
                            // where it was saved.
                            image = await _controller.takePicture();
                            isPreview = !isPreview;
                            setState(() {});
                            if (!mounted) return;

                            // If the picture was taken, display it on a new screen.
                          } catch (e) {
                            // If an error occurs, log the error to the console.
                            print(e);
                          }
                        },
                        child: ImageLoader.svgPictureAssetImage(
                            imagePath: ImagePath.cameraClickIcon),
                      ),

                      //flash toggle

                      GestureDetector(
                        onTap: () async {
                          final flashmodeIndex = (flashModes
                                  .indexOf(_controller.value.flashMode)) +
                              1;

                          if (flashmodeIndex < flashModes.length) {
                            await _controller
                                .setFlashMode(flashModes[flashmodeIndex]);
                          } else {
                            await _controller.setFlashMode(flashModes[0]);
                          }
                          setState(() {});
                        },
                        child: Icon(
                          getFlashIcon(_controller.value.flashMode),
                          color: AppColors.kWhite,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  cameraPreview(String? imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        imagePath != null
            ? Expanded(
                child: Image.file(
                File(imagePath),
                fit: BoxFit.fitHeight,
              ))
            : Container(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Todo enhance ui

              GestureDetector(
                onTap: () {
                  setState(() {
                    isPreview = !isPreview;
                  });
                },
                child: Row(
                  children: [
                    ImageLoader.svgPictureAssetImage(
                        imagePath: ImagePath.cameraIcon,
                        color: AppColors.kWhite),
                    SizedBox(
                      width: 10 * SizeConfig.widthMultiplier!,
                    ),
                    Text(
                      "Retake",
                      style: TextStyle(
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.textMultiplier!),
                    ),
                  ],
                ),
              ),

              Container(
                width: 143 * SizeConfig.widthMultiplier!,
                height: 60 * SizeConfig.heightMultiplier!,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius:
                      BorderRadius.circular(64 * SizeConfig.widthMultiplier!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(
                          color: AppColors.kBlackTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.textMultiplier!),
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context, image);
                      },
                      icon: Icon(
                        Icons.check,
                        color: AppColors.kBlackTextColor,
                        size: 30 * SizeConfig.imageSizeMultiplier!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
