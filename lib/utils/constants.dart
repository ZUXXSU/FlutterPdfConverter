import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.blueAccent;
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.red;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
  );
}

class AppStrings {
  static const String appName = 'Document Scanner';
  static const String captureDocument = 'Capture Document';
  static const String generatePdf = 'Generate PDF';
  static const String viewSavedPdfs = 'View Saved PDFs';
  static const String noCapturedImages = 'No captured images';
  static const String pdfGenerationError = 'Failed to generate PDF';
  static const String pdfSaveSuccess = 'PDF saved successfully';
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadius = 8.0;
}