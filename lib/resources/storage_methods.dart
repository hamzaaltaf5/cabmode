import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Adding Image to firebase storage
  Future<String> uploadImageToStorage(
    String folderName,
    Uint8List imageFile,
  ) async {
    Reference ref =
        _storage.ref().child(folderName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(imageFile);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
