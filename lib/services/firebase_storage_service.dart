import 'dart:developer';

import 'package:get/get.dart';
import 'package:study_app/firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child("${imgName.toLowerCase()}.png");
      var imgURL = await urlRef.getDownloadURL();
      return imgURL;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
