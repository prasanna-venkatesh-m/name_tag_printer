import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScannerOverlay extends StatelessWidget {
  final GlobalKey qrKey;
  final void Function(QRViewController) onQRViewCreated;
  final bool isLoading;
  final VoidCallback onClose;

  const QRScannerOverlay({
    Key? key,
    required this.qrKey,
    required this.onQRViewCreated,
    required this.isLoading,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(key: qrKey, onQRViewCreated: onQRViewCreated),
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    "Fetching details...",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
// import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';

// class QRScannerOverlay extends StatelessWidget {
//   final GlobalKey qrKey;
//   final void Function(QRViewController) onQRViewCreated;
//   final bool isLoading;
//   final VoidCallback onClose;

//   const QRScannerOverlay({
//     Key? key,
//     required this.qrKey,
//     required this.onQRViewCreated,
//     required this.isLoading,
//     required this.onClose,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (kIsWeb) ...[
//           _buildWebQRScanner(context),
//         ] else ...[
//           _buildMobileQRScanner(),
//         ],
//         Center(
//           child: Container(
//             width: 250,
//             height: 250,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blueGrey, width: 3),
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         if (isLoading)
//           Container(
//             color: Colors.black54,
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(color: Colors.white),
//                   SizedBox(height: 12),
//                   Text(
//                     "Fetching details...",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         Positioned(
//           top: 40,
//           left: 20,
//           child: IconButton(
//             icon: Icon(Icons.close, color: Colors.white),
//             onPressed: onClose,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildWebQRScanner(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height,
//       child: FlutterWebQrcodeScanner(
//         cameraDirection: CameraDirection.back,
//         onGetResult: (result) {
//           print('Scanned result: $result');
//         },
//         onError: (e) {
//           print('QR Code Error: $e');
//         },
//       ),
//     );
//   }

//   // Mobile QR Scanner
//   Widget _buildMobileQRScanner() {
//     return Container(
//       width: double.infinity,
//       height: 400,
//       child: QRView(
//         key: qrKey,
//         onQRViewCreated: onQRViewCreated,
//       ),
//     );
//   }
// }
