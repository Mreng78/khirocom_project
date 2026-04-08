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
import "../../Widgets/AppBar.dart";

class Loginscrean extends StatefulWidget {
  const Loginscrean({super.key});

  @override
  State<Loginscrean> createState() => _LoginscreanState();
}

class _LoginscreanState extends State<Loginscrean> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _obscurePassword = false.obs;
  final _Role = "".obs;
  late Student student;
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbackground.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
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
                      Text(
                        'مرحبا مرة أخرى',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Appcolors.appmaincolor,
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
                        labelText: "اسم المستخدم أو رقم الهاتف",
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => CustomTextField(
                          controller: _passwordController,
                          hintText: "كلمة المرور",
                          labelText: "كلمة المرور",
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
                                    activeColor: Appcolors.appmaincolor,
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
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: Appcolors.appmaincolor,
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
                            onPressed: authController.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool isSuccess = await authController.login(
                                        _usernameController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                                      if (isSuccess) {
                                        print(authController.Role.value);
                                        _Role.value = authController.Role.value;
                                        if (_Role.value == "مدرس") {
                                          user =
                                              authController.currentUser.value!;
                                          Get.to(
                                            () => TeacherHomescrean(),
                                          );
                                        } else if (_Role.value == "طالب") {
                                          student = authController
                                              .currentStudent
                                              .value!;
                                          Get.to(
                                            () => UnderDevelopmentScrean(
                                              name: student.Name,
                                            ),
                                          );
                                        }else if (_Role.value == "admin" || _Role.value == "مشرف" || _Role.value == "موجه" ||_Role.value == "مدير " ||_Role.value == "مدير") {
                                          Get.to(
                                            () => UnderDevelopmentScrean(name: authController.currentUser.value!.Name ),
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
                              backgroundColor: Appcolors.appmaincolor,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shadowColor: Appcolors.appmaincolor.withOpacity(0.3),
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
      ),
    );
  }

  // Removed internal _buildTextField in favor of CustomTextField widget
}
