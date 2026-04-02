import "package:flutter/material.dart";
import "package:frontend/Controller/UserController.dart";
import "package:frontend/Screans/assistscrean/UnderDevelopmentScrean.dart";
import "package:frontend/models/Student.model.dart";
import "package:get/get.dart";
import "../../Widgets/AppColors.dart";
import "../../Controller/Auth_controller.dart";
import "../../models/User.model.dart";
import "package:frontend/Screans/assistscrean/errorscreen.dart";
import "package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart";
import "package:frontend/Widgets/CustomTextField.dart";

class Loginscrean extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _obscurePassword = false.obs;
  final _Role = "".obs;
  late Student student;
  late User user;

  Loginscrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),

                    const SizedBox(height: 30),
                    const Text(
                      'مرحبا مرة أخرى',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 135, 7),
                        fontSize: 32,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'سجل دخولك للمتابعة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _usernameController,
                      hintText: "اسم المستخدم أو رقم الهاتف",
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextField(
                        controller: _passwordController,
                        hintText: "كلمة المرور",
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: _obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onSuffixIconPressed: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                      ),
                    ),
                    // const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: authController.isoflineMode.value,
                                  onChanged: (value) {
                                    authController.toggleOfflineMode(
                                      value ?? false,
                                    );
                                  },
                                  activeColor: Appcolors.iconColor,
                                ),
                              ),
                              const Text(
                                'الدخول بدون انترنت',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 100, 100, 100),
                                  fontSize: 14,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to forgot password
                          },
                          child: const Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: Color.fromARGB(255, 3, 135, 7),
                              fontSize: 16,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    // Login Button
                    SizedBox(
                      height: 55,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: userController.isLoading.value
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool isSuccess = await userController.login(
                                      _usernameController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                    if (isSuccess) {
                                      print(userController.Role.value);
                                      _Role.value = userController.Role.value;
                                      if (_Role.value == "مدرس") {
                                        user =
                                            userController.currentUser.value!;
                                        Get.to(
                                          () => TeacherHomescrean(),
                                        );
                                      } else if (_Role.value == "طالب") {
                                        student = userController
                                            .currentStudent
                                            .value!;
                                        Get.to(
                                          () => UnderDevelopmentScrean(
                                            name: student.Name,
                                          ),
                                        );
                                      }else if (_Role.value == "admin" || _Role.value == "مشرف" || _Role.value == "موجه" ||_Role.value == "مدير " ||_Role.value == "مدير") {
                                        Get.to(
                                          () => UnderDevelopmentScrean(name: userController.currentUser.value!.Name ),
                                        );
                                      } else {
                                        Get.snackbar(
                                          'تنبيه',
                                          'تم تسجيل الدخول بنجاح، لكن واجهة المستخدم ${_Role.value} غير متوفرة بعد.',
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    } else {
                                      Get.to(()=>Errorscreen(error: userController.errorMessage.value,));
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.iconColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shadowColor: Appcolors.iconColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: userController.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Register Link
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Removed internal _buildTextField in favor of CustomTextField widget
}
