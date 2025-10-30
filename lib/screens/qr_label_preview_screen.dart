import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:name_tag_printer/widgets/qr_overlay_widget.dart';
import 'package:name_tag_printer/widgets/scan_button_widget.dart';
import 'package:name_tag_printer/widgets/user_details_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class QRLabelPreviewScreen extends StatefulWidget {
  final String apiUrl;
  const QRLabelPreviewScreen({super.key, required this.apiUrl});

  @override
  _QRLabelPreviewScreenState createState() => _QRLabelPreviewScreenState();
}

class _QRLabelPreviewScreenState extends State<QRLabelPreviewScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool isScanning = false;
  bool isDataReady = false;
  bool isLoading = false;

  String fullName = '';
  String designation = '';
  String mobileNumber = '';
  String tShirtSize = '';
  String ticketId = '';
  String qrCodeNumber = '';
  String statusMessage = '';
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/icons/techx_logo.svg',
            height: 20, width: 20),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: isScanning
            ? QRScannerOverlay(
                controller: controller,
                isLoading: isLoading,
                onDetect: _onQRCodeDetected,
                onClose: () {
                  controller.stop();
                  print('on Close called');
                  setState(() {
                    isScanning = false;
                    isLoading = false;
                  });
                },
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isDataReady
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            statusMessage.toLowerCase() == 'attendance updated successfully'
                                ? UserDetailsCard(
                                    fullName: fullName,
                                    designation: designation,
                                    mobileNumber: mobileNumber,
                                    tShirtSize: tShirtSize,
                                    qrCodeNumber: qrCodeNumber)
                                : Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 16.0),
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFFEF2F2),
                                              Color(0xFFFEE2E2),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Color(0xFFEF4444).withOpacity(0.2),
                                              width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFEF4444).withOpacity(0.1),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEF4444).withOpacity(0.15),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Icon(
                                                    Icons.warning_rounded,
                                                    color: Color(0xFFEF4444),
                                                    size: 28,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Expanded(
                                                  child: Text(
                                                    statusMessage,
                                                    style: TextStyle(
                                                      color: Color(0xFFB91C1C),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      statusMessage ==
                                              'Attendance has already been updated'
                                          ? UserDetailsCard(
                                              fullName: fullName,
                                              designation: designation,
                                              mobileNumber: mobileNumber,
                                              tShirtSize: tShirtSize,
                                              qrCodeNumber: qrCodeNumber)
                                          : SizedBox()
                                    ],
                                  ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: ScanButton(
                                label: "Scan New QR Code",
                                onScanPressed: () {
                                  setState(() {
                                    isScanning = true;
                                    isDataReady = false;
                                    fullName = '';
                                    designation = '';
                                    mobileNumber = '';
                                    tShirtSize = '';
                                    qrCodeNumber = '';
                                    ticketId = '';
                                    statusMessage = '';
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : ScanCardButton(
                          onPressed: () {
                            setState(() {
                              isScanning = true;
                              isDataReady = false;
                              fullName = '';
                              designation = '';
                              mobileNumber = '';
                              tShirtSize = '';
                              ticketId = '';
                              qrCodeNumber = '';
                              statusMessage = '';
                            });
                          },
                        ),
                ),
              ),
      ),
    );
  }

  void _onQRCodeDetected(BarcodeCapture capture) async {
    if (isLoading) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final scannedTicketId = barcodes.first.rawValue ?? "";
    final guidRegEx = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');

    if (!guidRegEx.hasMatch(scannedTicketId)) {
      Fluttertoast.showToast(
          msg: "Invalid QR Code: Not a valid QR",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      controller.stop();
      setState(() {
        isScanning = false;
        isLoading = false;
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse(
          "${widget.apiUrl}/api/v1.0/Register/AttendeeEntry?ticketId=$scannedTicketId");
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          fullName = data['fullName'] ?? '';
          designation = data['designation'] ?? '';
          mobileNumber = data['mobileNumber'] ?? '';
          tShirtSize = data['tShirtSize'] ?? '';
          ticketId = scannedTicketId;
          qrCodeNumber = data['qrNumber'];
          statusMessage = data['message'];
          isDataReady = true;
          isScanning = false;
        });

        if (data['message']?.toLowerCase() == "attendance updated successfully") {
          Fluttertoast.showToast(
            msg: data['message'] ?? "Attendance updated successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.body}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() {
          isScanning = false;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error from catch block: $e");
      Fluttertoast.showToast(
        msg: "Failed to fetch details: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        isScanning = false;
        isLoading = false;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
