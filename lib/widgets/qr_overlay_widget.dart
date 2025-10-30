import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerOverlay extends StatelessWidget {
  final MobileScannerController controller;
  final void Function(BarcodeCapture) onDetect;
  final bool isLoading;
  final VoidCallback onClose;

  const QRScannerOverlay({
    Key? key,
    required this.controller,
    required this.onDetect,
    required this.isLoading,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: onDetect,
        ),
        // Scanning frame with gradient border
        Center(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                // Corner decorations
                Positioned(
                  top: 0,
                  left: 0,
                  child: _buildCorner(true, true),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildCorner(true, false),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: _buildCorner(false, true),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _buildCorner(false, false),
                ),
              ],
            ),
          ),
        ),
        // Instruction text
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Align QR code within the frame",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black87,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF6366F1).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: CircularProgressIndicator(
                      color: Color(0xFF6366F1),
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Fetching details...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please wait",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          top: 50,
          left: 20,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? BorderSide(color: Color(0xFF6366F1), width: 5)
              : BorderSide.none,
          left: isLeft
              ? BorderSide(color: Color(0xFF6366F1), width: 5)
              : BorderSide.none,
          right: !isLeft
              ? BorderSide(color: Color(0xFF6366F1), width: 5)
              : BorderSide.none,
          bottom: !isTop
              ? BorderSide(color: Color(0xFF6366F1), width: 5)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isTop && isLeft ? Radius.circular(24) : Radius.zero,
          topRight: isTop && !isLeft ? Radius.circular(24) : Radius.zero,
          bottomLeft: !isTop && isLeft ? Radius.circular(24) : Radius.zero,
          bottomRight: !isTop && !isLeft ? Radius.circular(24) : Radius.zero,
        ),
      ),
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
//           _buildWebQRScanner(),
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

//   Widget _buildWebQRScanner() {
//     return Container(
//       width: double.infinity,
//       height: 400,
//       child: FlutterWebQrcodeScanner(
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
