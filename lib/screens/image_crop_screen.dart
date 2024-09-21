import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:imgtopdf/controllers/document_controller.dart';
import 'package:imgtopdf/widgets/custom_button.dart';

class ImageCropScreen extends GetView<DocumentController> {
  final String imagePath;

  ImageCropScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop Image')),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () => _cropImage(context),
                  text: 'Crop',
                ),
                CustomButton(
                  onPressed: () {
                    controller.addImage(imagePath);
                    Get.back();
                  },
                  text: 'Use as is',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cropImage(BuildContext context) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        controller.addImage(croppedFile.path);
        Get.back();
      } else {
        Get.snackbar('Info', 'Image cropping canceled',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error cropping image: $e');
      Get.snackbar('Error', 'Failed to crop image: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}