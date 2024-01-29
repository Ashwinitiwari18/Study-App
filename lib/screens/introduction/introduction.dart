import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.star, size: 60),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "This is study app where you have diffrent sets of problem to solve, you are give 5 mins to sovle this problem. By this you can improve your knowdlege",
              style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            AppCircleButton(
              onTap: () {
                Get.offAllNamed('/home');
              },
              child: const Icon(Icons.arrow_forward,size: 50,),
            ),
          ]),
        ),
      ),
    );
  }
}
