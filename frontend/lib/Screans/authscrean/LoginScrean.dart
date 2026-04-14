import "package:flutter/material.dart";
import "package:frontend/Controller/UserController.dart";
import "package:frontend/Screans/assistscrean/UnderDevelopmentScrean.dart";
import "package:frontend/models/Student.model.dart";
import "package:get/get.dart";
import "../../Widgets/AppColors.dart";
import "../../Controller/Auth_controller.dart";
import "../../models/User.model.dart";
import "package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart";
import "package:frontend/Widgets/CustomTextField.dart";

class Loginscrean extends StatelessWidget {
  const Loginscrean({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final UserController userController = Get.put(UserController());
    final formKey = GlobalKey<FormState>();
    final usernameController = authController.usernameorPhoneNumbercontroller;
    final passwordController = TextEditingController();

    final Role = "".obs;
    late Student student;
    late User user;

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
                  key: formKey,
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
                        controller: usernameController,
                        hintText: "اسم المستخدم أو رقم الهاتف",
                        labelText: "اسم المستخدم أو رقم الهاتف",
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => CustomTextField(
                          controller: passwordController,
                          hintText: "كلمة المرور",
                          labelText: "كلمة المرور",
                          prefixIcon: Icons.lock_outline,
                          obscureText: authController.obscurePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: authController.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onSuffixIconPressed: () {
                            authController.obscurePassword.value =
                                !authController.obscurePassword.value;
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
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Appcolors.appmaincolor,
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.appmaincolor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      bool isSuccess = await authController
                                          .login(
                                            usernameController.text.trim(),
                                            passwordController.text.trim(),
                                          );
                                      if (isSuccess) {
                                        print(authController.Role.value);
                                        Role.value = authController.Role.value;
                                        if (Role.value == "مدرس") {
                                          user =
                                              authController.currentUser.value!;
                                          Get.to(() => TeacherHomescrean());
                                        } else if (Role.value == "طالب") {
                                          student = authController
                                              .currentStudent
                                              .value!;
                                          Get.to(
                                            () => UnderDevelopmentScrean(
                                              name: student.Name,
                                            ),
                                          );
                                        } else if (Role.value == "admin" ||
                                            Role.value == "مشرف" ||
                                            Role.value == "موجه" ||
                                            Role.value == "مدير " ||
                                            Role.value == "مدير") {
                                          Get.to(
                                            () => UnderDevelopmentScrean(
                                              name: authController
                                                  .currentUser
                                                  .value!
                                                  .Name,
                                            ),
                                          );
                                        } else {
                                          Get.snackbar(
                                            'تنبيه',
                                            'تم تسجيل الدخول بنجاح، لكن واجهة المستخدم ${Role.value} غير متوفرة بعد.',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      } else {
                                        if (userController.errorMessage.value ==
                                            "بيانات الدخول غير صحيحة") {
                                          Get.dialog(
                                            Dialog(
                                              backgroundColor: Colors
                                                  .transparent, // لجعل الخلفية تعتمد على الحاوية الخاصة بنا
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                constraints:
                                                    const BoxConstraints(
                                                      maxWidth: 340,
                                                    ),
                                                padding: const EdgeInsets.all(
                                                  24,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 15,
                                                      offset: const Offset(
                                                        0,
                                                        10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.error_outline,
                                                        color: Colors.redAccent,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      "بيانات الدخول غير صحيحة",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Appcolors
                                                            .appmaincolor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 30),
                                                    Wrap(
                                                      spacing: 12,
                                                      runSpacing: 12,
                                                      alignment:
                                                          WrapAlignment.center,
                                                      children: [
                                                        _buildButton(
                                                          "إعادة المحاولة",
                                                          () => Get.back(),
                                                        ),
                                                        _buildButton(
                                                          "نسيت كلمة المرور",
                                                          () {
                                                            // منطق استعادة كلمة المرور
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                         Get.dialog(
                                            Dialog(
                                              backgroundColor: Colors
                                                  .transparent, // لجعل الخلفية تعتمد على الحاوية الخاصة بنا
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Container(
                                                width: double.infinity,
                                                constraints:
                                                    const BoxConstraints(
                                                      maxWidth: 340,
                                                    ),
                                                padding: const EdgeInsets.all(
                                                  24,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 15,
                                                      offset: const Offset(
                                                        0,
                                                        10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.network_check,
                                                        color: Colors.redAccent,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "خطأ أثناء محاولة الاتصال بالخادم",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Appcolors
                                                                .appmaincolor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'Cairo',
                                                          ),
                                                        ),
                                                          Text(
                                                          "تأكد من اتصالك بالانترنت",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Appcolors
                                                                .appmaincolor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'Cairo',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 30),
                                                    Wrap(
                                                      spacing: 12,
                                                      runSpacing: 12,
                                                      alignment:
                                                          WrapAlignment.center,
                                                      children: [
                                                        _buildButton(
                                                          "إعادة المحاولة",
                                                          () => Get.back(),
                                                        ),
                                                      
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              elevation: 0,
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
}

Widget _buildButton(String text, VoidCallback onTap) {
  return Material(
    color: Colors.transparent, // للحفاظ على شكل الحواف عند النقر
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // تحسين الانحناء
      child: Ink(
        decoration: BoxDecoration(
          // gradient: Appcolors.glossyGradient,
          color: Appcolors.appmaincolor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          width: 140, // عرض متناسب
          height: 48, // ارتفاع مريح للمس
          child: Stack(
            alignment: Alignment.center, // توسيط المحتويات تلقائياً
            children: [
              // الخلفية الفنية (CustomPaint)
              // Positioned.fill(
              //   child: CustomPaint(
              //     painter: Customcontainer(), // تسمية أكثر دقة
              //   ),
              // ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
