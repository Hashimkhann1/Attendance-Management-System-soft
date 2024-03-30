


import 'dart:io';

import 'package:attendancemanagementsystem/res/constant/constant.dart';
import 'package:attendancemanagementsystem/view_model/getx/image_picker_getx/image_picker_getx.dart';
import 'package:attendancemanagementsystem/view_model/getx/loading_getx/loading_getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileViewModel{

  final _auth = FirebaseAuth.instance;

  final LoadingGetx loadingGetx = Get.put(LoadingGetx());
  final ImagePickerGetx imagePickerGetx = Get.put(ImagePickerGetx());

  late String imageUrl = '';


  Future uploadAdminImage() async {
    try{
      loadingGetx.setLoading();
      final imageFile = File(imagePickerGetx.selectedImagePath.value);
      print(imageFile);
      final uploadImageRef = FirebaseStorage.instance.ref().child('images/${_auth.currentUser!.uid.toString()}');
      await uploadImageRef.putFile(imageFile).then((p0) {
        loadingGetx.setLoading();
        Constant().toastMessage("Uploadin....");
      }).onError((error, stackTrace) {
        loadingGetx.setLoading();
        Constant().toastMessage("Error while uploading image");
        print(error.toString());
      });
      imageUrl = await uploadImageRef.getDownloadURL();

      if(imageUrl != ''){
        FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).update({
          "userImage" : imageUrl
        }).then((value){
          Constant().toastMessage("Image update");
        });
      }

    }catch(error){
      loadingGetx.setLoading();
      print("error while uploading admin image from LogedinUserViewModel $error >>>>>>>>");
    }
  }
}