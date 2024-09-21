import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:imgtopdf/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

class PdfViewScreen extends StatelessWidget {
  final String pdfPath;

  const PdfViewScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _sharePdf(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfViewer.openFile(pdfPath),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              onPressed: () =>{
                Navigator.of(context).pop(),
                
              } ,
              text: 'Close',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sharePdf() async {
  try {
    final result = await Share.shareXFiles(
      [XFile(pdfPath)],
      subject: 'Scanned Document',
      text: 'Sharing scanned document',
    );

    if (result.status == ShareResultStatus.success) {
      print('PDF shared successfully');
    } else if (result.status == ShareResultStatus.dismissed) {
      print('Share was dismissed');
    }
  } catch (e) {
    print('Error sharing PDF: $e');
  }
}
}