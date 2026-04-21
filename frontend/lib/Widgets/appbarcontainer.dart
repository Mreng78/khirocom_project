import 'dart:ui';
import 'package:frontend/Controller/Auth_controller.dart';
import 'package:frontend/Screens/authscreen/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';

class Appbarcontainer extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(75.0);

  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon1;
  final Widget? rightIcon2;
  final String? undertitel;
  final Widget? navigationwidget;

  const Appbarcontainer({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon1,
    this.rightIcon2,
    this.undertitel,
    this.navigationwidget,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      final user = authController.currentUser.value;

      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.of(context).padding.top + 12,
              16,
              8,
            ),
            decoration: BoxDecoration(
              color: Appcolors.appBarbackground.withOpacity(0.9),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTransparentIconButton(
                          icon: Icons.logout_rounded,
                          color: Colors.white,
                          onTap: () =>
                              _showLogoutDialog(context, authController),
                        ),
                        const SizedBox(width: 12),
                        _buildTransparentIconButton(
                          icon: Icons.grid_view_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),

                    // Center Title
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          if (undertitel != null)
                            Text(
                              undertitel!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.7),
                                fontFamily: 'Cairo',
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Right Actions
                    Row(
                      children: [
                        _buildTransparentIconButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _buildProfileAvatar(context, user),
                      ],
                    ),
                  ],
                ),

                // ✅ يظهر فقط إذا موجود
                if (navigationwidget != null)
                  SizedBox(
                    height: 45,
                    child: navigationwidget,
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileAvatar(BuildContext context, dynamic user) {
    return InkWell(
      onTap: () => _showProfilePreview(context, user),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        ),
        child: CircleAvatar(
          radius: 19,
          backgroundColor: Colors.white.withOpacity(0.1),
          backgroundImage:
              user?.ImageUrl != null && user!.ImageUrl!.isNotEmpty
                  ? NetworkImage(user.ImageUrl!)
                  : null,
          child: user?.ImageUrl == null || user!.ImageUrl!.isEmpty
              ? const Icon(Icons.person_rounded,
                  color: Colors.white, size: 20)
              : null,
        ),
      ),
    );
  }

  void _showLogoutDialog(
      BuildContext context, AuthController authController) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("تسجيل الخروج",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cairo')),
          content: const Text(
            "هل أنت متأكد من رغبتك في تسجيل الخروج؟",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                authController.user_logout();
                Get.offAll(() => const LoginScreen());
              },
              child: const Text("خروج"),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfilePreview(BuildContext context, dynamic user) {
    Get.dialog(
      Center(
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Appcolors.appBarbackground.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    user?.ImageUrl != null && user!.ImageUrl!.isNotEmpty
                        ? NetworkImage(user.ImageUrl!)
                        : null,
                child: user?.ImageUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(user?.Name ?? "المستخدم"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("إغلاق"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransparentIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color.withOpacity(0.9), size: 22),
      ),
    );
  }
}