import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:imgtopdf/controllers/document_controller.dart';
import 'package:imgtopdf/widgets/custom_button.dart';
import 'package:imgtopdf/screens/image_crop_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  final DocumentController _documentController = Get.find<DocumentController>();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException('No cameras found', 'No cameras are available on this device');
      }
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _cameraController!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error initializing camera: $e');
      // Show an error dialog or snackbar to inform the user
      Get.snackbar('Error', 'Failed to initialize camera',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Document')),
      body: _initializeControllerFuture == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Expanded(
                        child: CameraPreview(_cameraController!),
                      ),
                      CustomButton(
                        onPressed: () => _takePicture(),
                        text: 'Capture',
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      Get.snackbar('Error', 'Camera is not initialized',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final image = await _cameraController!.takePicture();
      Get.to(() => ImageCropScreen(imagePath: image.path));
    } catch (e) {
      print('Error taking picture: $e');
      Get.snackbar('Error', 'Failed to capture image',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}