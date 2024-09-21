import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imgtopdf/controllers/document_controller.dart';
import 'package:imgtopdf/screens/camera_screen.dart';
import 'package:imgtopdf/screens/pdf_view_screen.dart';
import 'package:imgtopdf/widgets/custom_button.dart';
import 'package:imgtopdf/widgets/custom_dialog.dart';

class HomeScreen extends GetView<DocumentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Document Scanner')),
      body: Obx(() => AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildContent(),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CameraScreen()),
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text('Captured Images: ${controller.imagePaths.length}')),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () async {
              await controller.generateAndSavePdf();
              if (controller.error.isNotEmpty) {
                CustomDialog.showError(controller.error);
              } else {
                CustomDialog.showSuccess('PDF generated and saved successfully');
                Get.to(() => PdfViewScreen(pdfPath: controller.pdfPath));
              }
            },
            text: 'Generate PDF',
          ),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () async {
              final savedPdfs = await controller.getSavedPdfs();
              Get.to(() => SavedPdfsScreen(pdfPaths: savedPdfs));
            },
            text: 'View Saved PDFs',
          ),
        ],
      ),
    );
  }
}

class SavedPdfsScreen extends StatelessWidget {
  final List<String> pdfPaths;

  SavedPdfsScreen({required this.pdfPaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved PDFs')),
      body: ListView.builder(
        itemCount: pdfPaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Document ${index + 1}'),
            onTap: () => Get.to(() => PdfViewScreen(pdfPath: pdfPaths[index])),
          );
        },
      ),
    );
  }
}