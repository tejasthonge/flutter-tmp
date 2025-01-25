import 'package:image_picker/image_picker.dart';

class AppImagesServices {
  static pickGalleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  static capturePhoto({maxHeight = 1024.00, maxWidth = 1024.00}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxHeight: maxHeight, maxWidth: maxWidth);
    return photo;
  }

  static pickGalleryVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    return image;
  }

  static captureVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    return video;
  }

  static pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    return images;
  }
}
