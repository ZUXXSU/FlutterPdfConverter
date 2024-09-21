import 'package:get/get.dart';
import 'package:imgtopdf/services/pdf_service.dart';
import 'package:imgtopdf/services/storage_service.dart';

class DocumentController extends GetxController {
  final _imagePaths = <String>[].obs;
  final _pdfPath = ''.obs;
  final _isLoading = false.obs;
  final _error = ''.obs;

  List<String> get imagePaths => _imagePaths;
  String get pdfPath => _pdfPath.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  final PdfService _pdfService = PdfService();
  final StorageService _storageService = StorageService();

  void addImage(String path) {
    if (path.isNotEmpty && !_imagePaths.contains(path)) {
      _imagePaths.add(path);
    }
  }

  void removeImage(String path) {
    _imagePaths.remove(path);
  }

  Future<void> generateAndSavePdf() async {
    if (_imagePaths.isEmpty) {
      _error.value = 'No images captured';
      return;
    }

    _isLoading.value = true;
    _error.value = '';

    try {
      final pdfPath = await _pdfService.generatePdf(_imagePaths);
      final savedPath = await _storageService.savePdf(pdfPath);
      _pdfPath.value = savedPath;
    } catch (e) {
      _error.value = 'Failed to generate or save PDF: ${e.toString()}';
      print('Error generating or saving PDF: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<List<String>> getSavedPdfs() async {
    try {
      return await _storageService.getSavedPdfs();
    } catch (e) {
      print('Error getting saved PDFs: $e');
      _error.value = 'Failed to retrieve saved PDFs: ${e.toString()}';
      return [];
    }
  }
}