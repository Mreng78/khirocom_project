import 'package:flutter/material.dart';
import 'package:frontend/Controller/UserController.dart';
import 'package:frontend/Screans/TeacherScrean/TeacherHomescrean.dart';
import 'package:frontend/Widgets/CustomBottomNavBar.dart';
import 'package:get/get.dart';
import '../../Controller/StudentController.dart';
import '../../Controller/HalaqatController.dart';
import '../../Controller/UploadsController.dart';
import '../../Widgets/AppColors.dart';
import '../../Widgets/CustomTextField.dart';
import '../../Widgets/DropDown.dart';

class Addstudent extends StatelessWidget {
  const Addstudent({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.find<StudentController>();
    final HalaqatController halaqatController = Get.find<HalaqatController>();
    final UploadsController uploadsController = Get.put(UploadsController());

    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _genderController = TextEditingController();
    final _ageController = TextEditingController();
    final _current_Memorization_SorahController = TextEditingController();
    final _current_Memorization_AyaController = TextEditingController();
    final _phoneNumberController = TextEditingController();
    final _fatherNumberController = TextEditingController();
    final _categoryController = TextEditingController();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    List<String> genderOptions = ['ذكر', 'أنثى'];
    List<String> categoryOptions = [
      "اطفال",
      "أقل من 5 أجزاء",
      "5 أجزاء",
      "10 أجزاء",
      "15 جزء",
      "20 جزء",
      "25 جزء",
      "المصحف كامل",
    ];
    List<String> surahNames = [
      "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام", "الأعراف", "الأنفال", "التوبة", "يونس",
      "هود", "يوسف", "الرعد", "إبراهيم", "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه",
      "الأنبياء", "الحج", "المؤمنون", "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت", "الروم",
      "لقمان", "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر",
      "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية", "الأحقاف", "محمد", "الفتح", "الحجرات", "ق",
      "الذاريات", "الطور", "النجم", "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر", "الممتحنة",
      "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك", "القلم", "الحاقة", "المعارج",
      "نوح", "الجن", "المزمل", "المدثر", "القيامة", "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس",
      "التكوير", "الانفطار", "المطغفين", "الانشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد",
      "الشمس", "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر", "البينة", "الزلزلة", "العاديات",
      "القارعة", "التكاثر", "العصر", "الهمزة", "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر",
      "المسد", "الإخلاص", "الفلق", "الناس"
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Appcolors.appBarbackground,
        title: const Text(
          "خيركم",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/appbackground.jpg"),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 120), // Space for bottom nav
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      // Image Section
                      Center(
                        child: Stack(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: uploadsController.uploadedImageUrl.isNotEmpty
                                    ? NetworkImage(uploadsController.uploadedImageUrl.value)
                                    : null,
                                child: uploadsController.uploadedImageUrl.isEmpty
                                    ? Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Appcolors.appmaincolor,
                                      )
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () => uploadsController.pickAndUploadImage(),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Appcolors.appmaincolor,
                                  child: Obx(
                                    () => uploadsController.isUploading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Appcolors.appmaincolor, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            "أضافة طالب",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Appcolors.appmaincolor,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 216, 241, 188),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Appcolors.appmaincolor, width: 2),
                        ),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'إسم الطالب',
                              labelText: 'إسم الطالب',
                              fillColor: Colors.white,
                              validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال إسم الطالب' : null,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Dropdown(
                                    items: genderOptions,
                                    hintText: 'الجنس',
                                    label: 'الجنس',
                                    icon: Icons.person_outline,
                                    fillColor: Colors.white,
                                    onChanged: (value) => _genderController.text = value.toString(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _ageController,
                                    hintText: 'العمر',
                                    labelText: 'العمر',
                                    fillColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال العمر' : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              controller: _phoneNumberController,
                              hintText: 'رقم الهاتف (اختياري)',
                              labelText: 'رقم الهاتف (اختياري)',
                              fillColor: Colors.white,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              controller: _fatherNumberController,
                              hintText: 'هاتف ولي الأمر',
                              labelText: 'هاتف ولي الأمر',
                              fillColor: Colors.white,
                              keyboardType: TextInputType.phone,
                              validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم ولي الأمر' : null,
                            ),
                            const SizedBox(height: 15),
                            Dropdown(
                              items: categoryOptions,
                              hintText: 'الفئة',
                              label: 'الفئة',
                              icon: Icons.category,
                              fillColor: Colors.white,
                              onChanged: (value) => _categoryController.text = value.toString(),
                            ),
                            const SizedBox(height: 15),
                            const Divider(color: Colors.green),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomTextField(
                                    controller: _current_Memorization_SorahController,
                                    hintText: 'السورة الحالية',
                                    labelText: 'السورة',
                                    fillColor: Colors.white,
                                    items: surahNames,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    controller: _current_Memorization_AyaController,
                                    hintText: 'الآية',
                                    labelText: 'الآية',
                                    fillColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              controller: _usernameController,
                              hintText: 'اسم المستخدم',
                              labelText: 'اسم المستخدم',
                              fillColor: Colors.white,
                              validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال اسم المستخدم' : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'كلمة المرور',
                              labelText: 'كلمة المرور',
                              fillColor: Colors.white,
                              obscureText: true,
                              validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال كلمة المرور' : null,
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: studentController.isStudentsLoading.value
                                        ? null
                                        : () async {
                                            if (_formKey.currentState!.validate()) {
                                              Map<String, dynamic> studentData = {
                                                "Name": _nameController.text,
                                                "Gender": _genderController.text,
                                                "Age": int.tryParse(_ageController.text) ?? 0,
                                                "phoneNumber": _phoneNumberController.text,
                                                "FatherNumber": _fatherNumberController.text,
                                                "Category": _categoryController.text,
                                                "current_Memorization_Sorah": _current_Memorization_SorahController.text,
                                                "current_Memorization_Aya": _current_Memorization_AyaController.text,
                                                "Username": _usernameController.text,
                                                "Password": _passwordController.text,
                                                "ImageUrl": uploadsController.uploadedImageUrl.value,
                                                "status": "مستمر",
                                                "HalakatId": halaqatController.currentHalaqah.value?.Id ?? 0,
                                              };

                                              bool success = await studentController.addStudent(studentData);
                                              if (success) {
                                                Get.back();
                                              }
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolors.appBarbackground,
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: studentController.isStudentsLoading.value
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                          )
                                        : const Text(
                                            "إضافة الطالب",
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cairo'),
                                          ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => Get.back(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                  child: const Text(
                                    "إلغاء",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Cairo'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Cleanly placed bottom nav bar
          CustomBottomNavBar(
            onProfileTap: () {},
            onCenterTap: () => Get.to(() => const TeacherHomescrean()),
            onRecordsTap: () {},
            centerIcon: Icons.home,
          ),
        ],
      ),
    );
  }
}
