import 'dart:ui';
import 'package:frontend/Controller/Auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Screans/authscrean/LoginScrean.dart';

class Appbarcontainer extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(75.0); // Slightly taller for richness
  
  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon1;
  final Widget? rightIcon2;
  final String? undertitel;

  const Appbarcontainer({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon1,
    this.rightIcon2,
    this.undertitel,
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
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Actions
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTransparentIconButton(
                        icon: Icons.logout_rounded,
                        color: Colors.white,
                        onTap: () => _showLogoutDialog(context, authController),
                      ),
                      const SizedBox(width: 12),
                      _buildTransparentIconButton(
                        icon: Icons.grid_view_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  // Center Title Section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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

                  // Right Actions (Notifications & Profile)
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
          backgroundImage: user?.ImageUrl != null && user!.ImageUrl!.isNotEmpty
              ? NetworkImage(user.ImageUrl!)
              : null,
          child: user?.ImageUrl == null || user!.ImageUrl!.isEmpty
              ? const Icon(Icons.person_rounded, color: Colors.white, size: 20)
              : null,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("تسجيل الخروج", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          content: const Text("هل أنت متأكد من رغبتك في تسجيل الخروج؟", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Cairo')),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey, fontFamily: 'Cairo')),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                authController.user_logout();
                Get.offAll(() => const Loginscrean());
              },
              child: const Text("خروج", style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
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
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white.withOpacity(0.2),
                backgroundImage: user?.ImageUrl != null && user!.ImageUrl!.isNotEmpty
                    ? NetworkImage(user.ImageUrl!)
                    : null,
                child: user?.ImageUrl == null || user!.ImageUrl!.isEmpty
                    ? const Icon(Icons.person_rounded, color: Colors.white, size: 60)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                user?.Name ?? "المستخدم",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                user?.Role ?? "",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => Get.back(),
                child: const Text("إغلاق", style: TextStyle(fontFamily: 'Cairo')),
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
