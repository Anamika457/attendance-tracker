// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:convert';

import 'package:attendance_tracker/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:attendance_tracker/api_constants.dart';
class QRScanPage extends StatefulWidget {

  final String? sessionId;

  const QRScanPage({required this.sessionId});

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();  
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
    
      if (await Permission.camera.request().isGranted) {
        setState(() {
        });
      } else {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Denied'),
          content: const Text(
              'Camera permission is required to scan QR codes. Please grant permission from settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
    color: Colors.amber, 
  ),
        title: const Text('Scan QR Code', style: TextStyle(
    color: Colors.amber
  )),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: Permission.camera.status,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isGranted) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.amber,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 300,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: (result != null)
                          ? Text('Data: ${result!.code}', style: const TextStyle(
                          color: Colors.amber, 
                          fontSize: 20
                        ))
                          : const Text('Scan a code',style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20
                        )),
                        
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Camera permission is required to scan QR codes.'),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());  
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{

      setState(() {
        result = scanData;
      });
      final response = await http.post(
        Uri.http(apiUrl, '/track-attendance/'),
        body:{
          'uuid':scanData.code,
          'session_id': widget.sessionId
        }
      );
      if (!mounted) return;
      print("=====================================================================================================================");
      print(response.body);
      print("=====================================================================================================================");
      final data = jsonDecode(response.body);
      final String message = data['message'];
      final attendee = data['attendee'];
      final String name = attendee['name'];
      final String rollNo = attendee['roll_no'];
      final String gender = attendee['gender'];
      final String email = attendee['email'];
      final String sessionName = data['session']['name'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(
            message: message,
            name: name,
            rollNo: rollNo,
            gender: gender,
            email: email,
            sessionName: sessionName,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
