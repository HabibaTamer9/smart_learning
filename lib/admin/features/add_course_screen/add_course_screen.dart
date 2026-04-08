import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/widgets/custom_button.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/custom_text_field.dart';

class AddCourseScreen extends StatelessWidget {
  AddCourseScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController urlController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  List<String> levels = ["Beginner", "Intermediate", "Advanced"];

  List<String> tracks = ["mobile", "web", "uiux"];

  String? selectedLevel;

  String? selectedTrack;

  clearText(){
    nameController.clear();
    urlController.clear();
    imageController.clear();
    numberController.clear();
    selectedLevel = null;
    selectedTrack = null;
  }

  Future<void> addCourse(BuildContext context) async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));
    try{
      await FirebaseFirestore.instance.collection(selectedTrack!).add({
        'title': nameController.text,
        'playlist': urlController.text,
        'image': imageController.text,
        'videosCount': numberController.text,
        'level': selectedLevel,
      });
      Navigator.pop(context);
      clearText();
    }catch(e){
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("Add Course",
                          style: Theme.of(context).textTheme.headlineLarge)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Course Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomTextField(
                      hintText: "Course Name",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Course Name";
                        }
                        return null;
                      },
                      controller: nameController),
                  Text(
                    "Course url",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomTextField(
                      hintText: "Course url",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter url";
                        }
                        return null;
                      },
                      controller: urlController),
                  Text(
                    "Course image url",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomTextField(
                      hintText: "Course image url",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Course image";
                        }
                        return null;
                      },
                      controller: imageController),
                  Text(
                    "number of videos",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomTextField(
                      hintText: "number of videos",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter number of videos";
                        }
                        return null;
                      },
                      controller: numberController),
                  Text(
                    "Select Level",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedLevel,
                      dropdownColor: Colors.white,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        hintText: "Select Level",
                        hintStyle: TextStyle(color: Color(0xff6A707C)),
                        suffixIconColor: Color(0xff6A707C),
                      ),
                      items: levels.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedLevel = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please Select Level";
                        }
                        return null;
                      },
                    ),
                  ),

                  Text(
                    "Select Track",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedTrack,
                      dropdownColor: Colors.white,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade900, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        hintText: "Select Track",
                        hintStyle: TextStyle(color: Color(0xff6A707C)),
                        suffixIconColor: Color(0xff6A707C),
                      ),
                      items: tracks.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedTrack = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please Select Track";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Add Course",
                    onPressed: () async{
                      if (keyForm.currentState!.validate()) {
                        await addCourse(context);

                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
