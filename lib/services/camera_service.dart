import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  late List<CameraDescription> cameras;
  CameraController? controller;

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> initializeController() async {
    if (cameras.isEmpty) {
      throw CameraException('No cameras found', 'Device has no cameras');
    }

    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
  }

  Future<XFile> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      throw CameraException('Camera not initialized', 'Call initializeController() first');
    }

    final image = await controller!.takePicture();
    return image;
  }

  void dispose() {
    controller?.dispose();
  }
}