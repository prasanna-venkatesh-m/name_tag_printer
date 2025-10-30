import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:name_tag_printer/widgets/qr_overlay_widget.dart';
import 'package:name_tag_printer/widgets/scan_button_widget.dart';
import 'package:name_tag_printer/widgets/user_details_widget.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class QRLabelPreviewScreen extends StatefulWidget {
  final String apiUrl;
  const QRLabelPreviewScreen({super.key, required this.apiUrl});

  @override
  _QRLabelPreviewScreenState createState() => _QRLabelPreviewScreenState();
}

class _QRLabelPreviewScreenState extends State<QRLabelPreviewScreen> {
  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;

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
                qrKey: qrKey,
                isLoading: isLoading,
                onQRViewCreated: _onQRViewCreated,
                onClose: () {
                  controller?.pauseCamera();
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
                            statusMessage == 'Attendance Updated Successfully'
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
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red
                                              .shade50, // subtle background for error
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.red.shade300),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.error_outline,
                                                    color: Colors.red.shade700),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    statusMessage,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.red.shade700,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (isLoading) return;

      final scannedTicketId = scanData.code ?? "";
      final guidRegEx = RegExp(
          r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');

      if (!guidRegEx.hasMatch(scannedTicketId)) {
        Fluttertoast.showToast(
            msg: "Invalid QR Code: Not a valid QR",
            backgroundColor: Colors.red,
            textColor: Colors.white);
        controller.pauseCamera();
        setState(() {
          isScanning = false;
          isLoading = false;
        });
        controller.resumeCamera();
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

          if (data['message'] == "Attendance updated successfully") {
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
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Failed to fetch details: $e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } finally {
        setState(() => isLoading = false);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
