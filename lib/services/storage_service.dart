import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<String> savePdf(String sourcePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'document_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final savedFile = File('${directory.path}/$fileName');
    
    await File(sourcePath).copy(savedFile.path);
    
    return savedFile.path;
  }

  Future<List<String>> getSavedPdfs() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();
    return files
        .where((file) => file.path.endsWith('.pdf'))
        .map((file) => file.path)
        .toList();
  }
}