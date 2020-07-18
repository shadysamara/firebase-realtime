import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  StorageHelper._();
  static final StorageHelper firestoreHelper = StorageHelper._();

  Future<String> addNewProductImage(File image) async {
    try {
      String path = 'images/${image.path.split('/').last}';
      StorageReference storageReference = FirebaseStorage.instance.ref();
      if (image != null) {
        StorageUploadTask storageUploadTask = storageReference
            .child('images/${image.path.split('/').last}')
            .putFile(image);
        StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
        String imageUrl = await snapshot.ref.getDownloadURL();
        return imageUrl;
      } else {
        return 'null man';
      }
    } catch (error) {
      print(error);
    }
  }

  Future uploadFile(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${image.path.split("/").last}}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      print(fileURL);
    });
  }
}
