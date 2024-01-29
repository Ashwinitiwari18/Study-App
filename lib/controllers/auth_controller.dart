import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/widgets/dialogs/dialoge_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 1));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _authAccount.idToken,
            accessToken: _authAccount.accessToken);
        await _auth.signInWithCredential(_credential);
        await saveAccount(account);
      }
    } on FirebaseAuthException catch (error) {
      log("${error.code}-${error.message}");
    }
    navigateToHomePage();
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveAccount(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilePic": account.photoUrl
    });
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  void showLogInAlertDialog() {
    Get.dialog(Dialogs.questionStartDialogue(onTap: () {
      Get.back();
      navigateToLoginPage();
    }), barrierDismissible: false);
  }

  void navigateToLoginPage() {
    Get.toNamed(LogInScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
