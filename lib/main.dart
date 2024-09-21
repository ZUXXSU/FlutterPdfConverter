import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imgtopdf/screens/home_screen.dart';
import 'package:imgtopdf/utils/theme.dart';
import 'package:imgtopdf/controllers/document_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Document Scanner',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {
        Get.put(DocumentController(), permanent: true);
      }),
      home: HomeScreen(),
    );
  }
}