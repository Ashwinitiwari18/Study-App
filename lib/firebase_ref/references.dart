import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

final questionPapersRF = fireStore.collection("questionPapers");

final userRF = fireStore.collection("uesrs");

DocumentReference questionRF({
  required String paperID,
  required String questionID,
}) =>
    questionPapersRF.doc(paperID).collection("questions").doc(questionID);
Reference get firebaseStorage => FirebaseStorage.instance.ref();
