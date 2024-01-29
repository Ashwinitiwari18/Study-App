import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void linkedin() {
    _launchUri("https://www.linkedin.com/in/ashwini-tiwari-825032229/");
  }

  void github() {
    _launchUri("https://github.com/Ashwinitiwari18");
  }

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: "mailto", path: "ashwinitiwari019@gmail.com");
    _launchUri(emailLaunchUri.toString());
  }

  Future<void> _launchUri(String url) async {
    if (!await launch(url)) {
      throw "could not luanch $url";
    }
  }
}
