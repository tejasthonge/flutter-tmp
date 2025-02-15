import 'package:image_picker/image_picker.dart';

class AppImagesServices {
  static pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  static capturePhoto({maxHeight = 1024.00, maxWidth = 1024.00}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera, maxHeight: maxHeight, maxWidth: maxWidth);
    return photo;
  }

  static pickGalleryVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    return image;
  }

  static captureVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    return video;
  }

  static pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    return images;
  }
}
