import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/Screans/TeacherScrean/AddStudent.dart';
import 'package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Controller/navigation_controller.dart';
import 'package:get/get.dart';

class Custombottomnavbar extends StatelessWidget {
  /// The page name used for the center floating button action.
  final String centerbutton;

  /// The page name that identifies THIS screen (used to mark active tab).
  final String currentpage;

  const Custombottomnavbar({
    super.key,
    required this.centerbutton,
    required this.currentpage,
  });

  // Safe controller access: find if already registered, otherwise create.
  NavigationController get _navController =>
      Get.isRegistered<NavigationController>()
          ? Get.find<NavigationController>()
          : Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Refined Glass Layer (Flush to Bottom)
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Appcolors.appBarbackground.withOpacity(0.9),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildnavbaritems(
                      icon: Icons.auto_graph_outlined,
                      windowname: 'activities',
                      label: 'الأنشطة',
                    ),
                    _buildnavbaritems(
                      icon: Icons.history_edu,
                      windowname: 'record',
                      label: 'السجل',
                    ),
                    // Space for center button
                    const SizedBox(width: 50),
                    _buildnavbaritems(
                      icon: Icons.tune,
                      windowname: 'settings',
                      label: 'الإعدادات',
                    ),
                    _buildnavbaritems(
                      icon: Icons.account_circle_outlined,
                      windowname: 'profile',
                      label: 'الملف',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Positioned Center Action Button (Crisp & Modern)
        Positioned(
          top: -26,
          child: _buildCenterButton(),
        ),
      ],
    );
  }

  Widget _buildCenterButton() {
    IconData centerIcon;
    if (centerbutton == 'add') {
      centerIcon = Icons.add;
    } else if (centerbutton == 'Home' || centerbutton == 'home') {
      centerIcon = Icons.home;
    } else {
      centerIcon = Icons.close;
    }

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            _navController.changePage(centerbutton);
            if (centerbutton == 'add') {
              Get.to(() => const Addstudent());
            } else {
              Get.to(() => const TeacherHomescrean());
            }
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Appcolors.appmaincolor, width: 3),
            ),
            child: Icon(
              centerIcon,
              color: Appcolors.appmaincolor,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildnavbaritems({
    required IconData icon,
    required String windowname,
    required String label,
  }) {
    return Obx(() {
      final bool isSelected = _navController.page.value == windowname;

      return GestureDetector(
        onTap: () => _navController.changePage(windowname),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  size: 24,
                ),
              ),
             // const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  fontSize: 10,
                  fontFamily: 'Cairo',
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
