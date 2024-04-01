


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGetx extends GetxController{

  RxString selectedImagePath = ''.obs;

  //////// admin profile image picker ////////

  Future getAdminProfileImage() async {
    try{
      final ImagePicker _imgPicker = ImagePicker();
      final image = await _imgPicker.pickImage(source: ImageSource.gallery);
      if(image != null){
        selectedImagePath.value = image.path.toString();
      }

    }catch(error){
      print("error while getting admin image from ImagePickerGetx $error >>>>>>>");
    }
  }


}