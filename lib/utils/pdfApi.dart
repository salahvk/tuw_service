import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(text) async {
    final image = MemoryImage(
        // File(text).readAsBytesSync(),
        text);
    final pdf = Document();
    // final font = await rootBundle.load("assets/open-sans.ttf");
    // final ttf = Font.ttf(font);

    pdf.addPage(Page(
      build: (context) => Center(
        child: Image(image),
        // Text(text, style: TextStyle(font: ttf, fontSize: 40)),
      ),
    ));

    return saveDocument(name: 'PaymentReceipt.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    final dir2 = await getExternalStorageDirectory();
    final file = File('${dir2!.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
