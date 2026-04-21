import 'dart:io';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PdfConverterService {
  /// Converts all pages of a PDF file into high-quality images.
  /// Returns a list of paths to the generated images.
  Future<List<String>> convertPdfToImages(String pdfPath) async {
    final document = await PdfDocument.openFile(pdfPath);
    final List<String> imagePaths = [];
    final tempDir = await getTemporaryDirectory();

    for (int i = 1; i <= document.pagesCount; i++) {
        final page = await document.getPage(i);
        final pageImage = await page.render(
            width: page.width * 2, // Double resolution for better OCR
            height: page.height * 2,
            format: PdfPageImageFormat.jpg,
            quality: 100,
        );

        if (pageImage != null) {
            final imageFile = File(p.join(
                tempDir.path, 
                'lab_report_page_${i}_${DateTime.now().millisecondsSinceEpoch}.jpg'
            ));
            await imageFile.writeAsBytes(pageImage.bytes);
            imagePaths.add(imageFile.path);
        }
        await page.close();
    }

    await document.close();
    return imagePaths;
  }
}
