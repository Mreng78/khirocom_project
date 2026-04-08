import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AppColors.dart';
import '../Controller/UserController.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onCenterTap;
  final VoidCallback onRecordsTap;
  final IconData centerIcon;

  const CustomBottomNavBar({
    super.key,
    required this.onProfileTap,
    required this.onCenterTap,
    required this.onRecordsTap,
    this.centerIcon = Icons.home,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Positioned(
      bottom: 20,
      left: 60,
      right: 60,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background "Tab" shape
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Appcolors.appmaincolor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Appcolors.appmaincolor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Appcolors.appmaincolor, width: 1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile
              Obx(() {
                final imageUrl = userController.currentUser.value?.ImageUrl;
                final hasImage = imageUrl != null && imageUrl.isNotEmpty;
                return _buildNavItem(
                  onTap: onProfileTap,
                  label: "الملف الشخصي",
                  icon: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Appcolors.appBarbackground,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: hasImage
                          ? DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: !hasImage
                        ? const Icon(Icons.person, color: Colors.white, size: 28)
                        : null,
                  ),
                );
              }),
              // Center Action (Home / Add)
              _buildCenterButton(onTap: onCenterTap, icon: centerIcon),
              // Records
              _buildNavItem(
                onTap: onRecordsTap,
                label: "السجل",
                icon: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Appcolors.appBarbackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.assessment, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required VoidCallback onTap, required String label, required Widget icon}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            label,
            style: TextStyle(
              color: Appcolors.appmaincolor,
              fontSize: 13,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton({required VoidCallback onTap, required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Appcolors.appBarbackground,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Appcolors.appBarbackground.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }
}
