import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:get/get.dart';

class LogInScreen extends GetView<AuthController> {
  const LogInScreen({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/app_splash_logo.png",
            width: 200,
            height: 200,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20),
            child: Text(
              "In this app, you can learn different subjects and topics. You have to solve quizzes of different subjects within a defined time, and based on your performance, you will earn points.",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: onSurfaceTextColor),
              textAlign: TextAlign.center,
            ),
          ),
          MainButton(
            onTap: () {
              controller.signInWithGoogle();
            },
            child: Stack(
              children: [
                Positioned(child: SvgPicture.asset("assets/icons/google.svg")),
                Center(
                  child: Text(
                    "Sign in with Google",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
