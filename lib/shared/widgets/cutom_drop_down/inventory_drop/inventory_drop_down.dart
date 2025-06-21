import 'package:flutter/material.dart';
import 'package:travelx_driver/shared/constants/app_colors/app_colors.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';
import 'package:travelx_driver/shared/constants/revamp/imagePath/new_imagePath.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

class HomeScreenDropDown extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;
  final ValueChanged<int>? onIndexChanged;
  final VoidCallback? onCustomTap;
  final double? overlaySize;
  final double? verticalHeight;
  final String?
  displayLabel; // NEW: custom label to display instead of selectedItem

  HomeScreenDropDown({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.onIndexChanged,
    this.onCustomTap,
    this.overlaySize,
    this.verticalHeight,
    this.displayLabel, // NEW
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenDropDownState createState() => _HomeScreenDropDownState();
}

class _HomeScreenDropDownState extends State<HomeScreenDropDown>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDropdown() {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context)!;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: widget.overlaySize ?? 310 * SizeConfig.widthMultiplier!,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(
              10 * SizeConfig.widthMultiplier!,
              52 * SizeConfig.heightMultiplier!,
            ),
            showWhenUnlinked: false,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      return InkWell(
                        onTap: () {
                          _closeDropdown();
                          if (item == "Date Range") {
                            // Custom tap handler for custom date range
                            widget.onCustomTap?.call();
                          } else {
                            widget.onChanged(item);
                            widget.onIndexChanged?.call(index);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10 * SizeConfig.heightMultiplier!,
                            horizontal: 12 * SizeConfig.widthMultiplier!,
                          ),
                          child: Text(
                            item,
                            style: AppTextStyle.text14black0000W700,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() {
        isDropdownOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kPinkFFF3F0,
            borderRadius: BorderRadius.circular(
              100 * SizeConfig.widthMultiplier!,
            ),
            border: Border.all(color: AppColors.kPinkF4B5A4),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12 * SizeConfig.widthMultiplier!,
              vertical:
                  widget.verticalHeight ?? 8 * SizeConfig.widthMultiplier!,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.displayLabel ?? widget.selectedItem,
                  style: AppTextStyle.text14black0000W700,
                ),
                Container(
                  padding: EdgeInsets.all(6 * SizeConfig.widthMultiplier!),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(
                      37 * SizeConfig.widthMultiplier!,
                    ),
                  ),
                  child: ImageLoader.svgPictureAssetImage(
                    imagePath: NewImagePath.rightArrowIcon,
                    height: 18 * SizeConfig.heightMultiplier!,
                    width: 18 * SizeConfig.heightMultiplier!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
