import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:pdf/widgets.dart'as pdfWidgets;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class TestScreen extends StatelessWidget {
   TestScreen({super.key});

  Future<void> _shareToWhatsApp(Uint8List imageBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(imageBytes);

    
    } catch (e) {
      print('Error sharing to WhatsApp: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey widgetKey = GlobalKey();
        String fPath = '';
    return  Scaffold(
      appBar: AppBar(
        title: const Text('TEST'),
        leading: IconButton(
          onPressed: () async {
            RenderRepaintBoundary boundary = widgetKey.currentContext!
                .findRenderObject() as RenderRepaintBoundary;
            final image = await boundary.toImage();
            final byteData =
            await image.toByteData(format: ImageByteFormat.png);
            final Uint8List pngBytes = byteData!.buffer.asUint8List();

            // Convert the image to PDF
            final pdf = pdfWidgets.Document();
            final imageWidget =
            pdfWidgets.Image(pdfWidgets.MemoryImage(pngBytes));
            pdf.addPage(pdfWidgets.Page(build: (pdfWidgets.Context context) {
              return pdfWidgets.Center(child: imageWidget);
            }));

            // Save the PDF to device storage
            final output = await getExternalStorageDirectory();
            final downloadsPath = '${output!.path}/Download';
            final file = File('$downloadsPath/screenshot.pdf');
            fPath = file.path;

            if (!await File(downloadsPath).exists()) {
              await file.create(recursive: true);
            }
            await file.writeAsBytes(await pdf.save());

            // Show a snackbar or perform any other action
            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(content: InkWell(
                  onTap: () {
                    // Share.shareFiles([fPath], text: 'Great picture');
                  },
                  child: Text('PDF Saved , Tap here to Share'))),
            );
          },
          icon: const Icon(Icons.download),
        ),
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: widgetKey,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Text('${index + 1}'),
            itemCount: 80,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // screenshotController.capture().then((Uint8List? image) {
          //   if (image == null) {
          //     showModalBottomSheet<void>(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: <Widget>[
          //             ListTile(
          //               leading: const Icon(Icons.share),
          //               title: const Text('Share to WhatsApp'),
          //               onTap: () {
          //                  // Share.share('g');
          //                 Navigator.pop(context); // Close the bottom sheet
          //                  // Share the screenshot to WhatsApp
          //               },
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   }
          // });
        },
        child: const Icon(Icons.share),
      ),
    );
 
  }

}

