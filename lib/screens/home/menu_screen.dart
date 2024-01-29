import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(mobileScreenPadding),
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: onSurfaceTextColor))),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: mobileScreenPadding + 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.user.value == null
                        ? const SizedBox(child: Text('Hello how are you'),)
                        : Text(
                            controller.user.value!.displayName ??
                                '',
                            style: const TextStyle(
                                color: onSurfaceTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),),
                          const Spacer(flex: 1,),
                          _DrawerButton(icon: Icons.web, label: "Linkedin",onPressed: ()=>controller.linkedin(),),
                          _DrawerButton(icon: AppIcons.github, label: "Github",onPressed: ()=>controller.github(),),
                          _DrawerButton(icon: Icons.email, label: "Email",onPressed: ()=>controller.email(),),
                          const Spacer(flex: 4,),
                          _DrawerButton(icon: Icons.logout, label: "Logout",onPressed: ()=>controller.signOut(),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {required this.icon, required this.label, this.onPressed, super.key});

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed, icon: Icon(icon), label: Text(label));
  }
}
