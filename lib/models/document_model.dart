class DocumentModel {
  final String id;
  final String name;
  final String pdfPath;
  final DateTime createdAt;

  DocumentModel({
    required this.id,
    required this.name,
    required this.pdfPath,
    required this.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      name: json['name'],
      pdfPath: json['pdfPath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pdfPath': pdfPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}