import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PdfService {
  Future<String> generatePdf(List<String> imagePaths) async {
    final pdf = pw.Document();

    for (String path in imagePaths) {
      final image = pw.MemoryImage(File(path).readAsBytesSync());

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/document.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }
}