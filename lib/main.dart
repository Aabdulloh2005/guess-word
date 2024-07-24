import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mini_quiz/views/screens/homepage.dart';

void main(List<String> args) {
  runApp(const MainRunner());
}

class MainRunner extends StatelessWidget {
  const MainRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Homepage(),
    );
  }
}
