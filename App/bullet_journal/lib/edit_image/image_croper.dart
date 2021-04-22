import 'dart:io';

import 'package:bullet_journel/edit_image/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCroperView extends StatefulWidget {
  @override
  _ImageCroperViewState createState() => _ImageCroperViewState();
}

bool isSwitched = true;
List<File> imageFiles = [];

class _ImageCroperViewState extends State<ImageCroperView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () async {
          final file = await Utils.pickMedia(
              isGallery: isSwitched, cropImage: cropSquareImage);
          if (file == null) return;
          setState(() => imageFiles.add(file));
          print('file' + file.path);
        },
      ),
      body: ImageListWidget(imageFiles),
    );
  }

  Future<File> cropSquareImage(File file) async {
    return await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);
  }

  Widget ImageListWidget(List<File> imageFiles) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: imageFiles
          .map((imageFile) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(imageFile),
              ))
          .toList(),
    );
  }
}
