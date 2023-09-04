import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';


class PdfCard extends StatelessWidget {
  final String filePath;
  final String fileName;

  PdfCard({required this.filePath, required this.fileName});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(filePath);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  Future<void> main() async {
    final pdf = pw.Document();
  }

  @override
  Widget build(BuildContext context) {
    bool isPdf = fileName.toLowerCase().endsWith('.pdf');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          isPdf ? Icons.picture_as_pdf : Icons.cloud_download,
          size: 42,
          color: isPdf ? Colors.redAccent : Colors.blueAccent,
        ),
        title: Text(
          fileName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          _launchUrl();
        },
      ),
    );
  }
}
