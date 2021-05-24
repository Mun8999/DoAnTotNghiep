// @dart=2.9
import 'package:hive/hive.dart';
part 'db_image_demo.g.dart';

@HiveType(typeId: 0)
class ImageData {
  @HiveField(0)
  int imageId;
  @HiveField(1)
  String imageFile;
  setImageId(int imageId) => this.imageId = imageId;
  setImageFile(String imageFile) => this.imageFile = imageFile;
  MyImage(int imageId, String imageFile) {
    this.imageId = imageId;
    this.imageFile = imageFile;
  }

  // String toString() {
  //   return '>>Id: ' +
  //       this.imageId.toString() +
  //       '\nFile: ' +
  //       this.imageFile.toString() +
  //       '\nOffset: ' +
  //       this.component.offset.toString() +
  //       '\nState: ' +
  //       this.component.state.toString();
  // }

  int get getImageId => this.imageId;
  String get getImageFile => this.imageFile;
}
