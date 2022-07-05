import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold_price_predictor/GoldInfo.dart';
import 'package:provider/provider.dart';

class FirebaseFunctions {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  DocumentReference documentReference;
  String _imageLink;

  Future<void> _showMyDialog(String title, String message, String buttonText,
      Function function, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'QuickSand', fontWeight: FontWeight.bold),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
          actions: <Widget>[
            ElevatedButton(child: Text(buttonText), onPressed: function),
          ],
        );
      },
    );
  }

  Future<bool> addOrnament(
      Map<String, dynamic> product, BuildContext context) async {
    try {
      if (product == null) {
        throw Exception("Product's value is null");
      } else {
        DocumentReference _documentReference =
            _firebaseFirestore.collection('Product').doc(product["Name"]);

        await _documentReference.set(product);

        _showMyDialog("Success!!", "Data loaded successfully", "Ok",
            () => Navigator.pop(context), context);
        return true;
      }
    } catch (e) {
      _showMyDialog("Failure!", e.toString(), "Ok",
          () => Navigator.pop(context), context);
      return false;
    }
  }

  Future<bool> updateDetails(
      String collectionName,
      Map<String, dynamic> updateMap,
      String docId,
      BuildContext context) async {
    try {
      await _firebaseFirestore
          .collection(collectionName)
          .doc(docId)
          .update(updateMap)
          .then((value) {
        _showMyDialog("Success", "Data has been successfully updated!", "Ok",
            () => Navigator.pop(context), context);
        return true;
      });
    } catch (e) {
      await _showMyDialog('Unable to update data', e.toString(), 'Ok',
          () => Navigator.pop(context), context);
      return false;
    }
  }

  Future addImages(
      List images, BuildContext context, String productName) async {
    var temp;

    try {
      StorageReference _sf = _firebaseStorage.ref().child(productName);
      images.forEach((image) {
        _sf.putFile(image).onComplete.then((image) async {
          temp = await image.ref.getDownloadURL();

          if (temp == null) {
            throw Exception("Downloadable link not generated");
          } else {
             _imageLink = temp;
             Provider.of<GoldInfo>(context,listen: false).image = _imageLink;
            await _showMyDialog("Success", "Image has been successfully updated!",
                "Ok", () => Navigator.pop(context), context);

            return true;

          }
        });
      });

     }catch (e) {
      await _showMyDialog('Unable to display image', e.toString(), 'Ok',
          () => Navigator.pop(context), context);
      return false;
    }
  }
}
