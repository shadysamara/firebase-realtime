import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/ecommerce_app/repositories/firestore_helper.dart';
import 'package:login_firebase/ecommerce_app/repositories/storage_helper.dart';

class EcommerceHome extends StatefulWidget {
  @override
  _EcommerceHomeState createState() => _EcommerceHomeState();
}

class _EcommerceHomeState extends State<EcommerceHome> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ECPMMERCE'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 300,
                height: 300,
                child: image != null ? Image.file(image) : Container(),
              ),
            ),
            RaisedButton(onPressed: () async {
              PickedFile pickedFile =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              print(pickedFile.path);
              image = File(pickedFile.path);
              setState(() {});
            }),
            RaisedButton(onPressed: () async {
              PickedFile pickedFile =
                  await ImagePicker().getImage(source: ImageSource.camera);
              File file = File(pickedFile.path);

              String url =
                  await StorageHelper.firestoreHelper.addNewProductImage(file);

              FirestoreHelper.firestoreHelper.addNewProduct('product1', url);
            })
          ],
        ),
      ),
    );
  }
}
