import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScanPage extends StatefulWidget {
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
    _checkCameraPermission();  // Check permission when the page loads
  }

  // Method to check and request camera permission
  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Request permission if not granted
      if (await Permission.camera.request().isGranted) {
        // Permission granted
        setState(() {
          // Rebuild UI if permission granted to initialize QR scanner
        });
      } else {
        // Permission denied, show a dialog
        _showPermissionDeniedDialog();
      }
    }
  }

  // Show a dialog if permission is denied
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
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: FutureBuilder(
        future: Permission.camera.status,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isGranted) {
              // If permission is granted, show the QR scanner
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
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
                          ? Text('Data: ${result!.code}')
                          : Text('Scan a code'),
                    ),
                  )
                ],
              );
            } else {
              // If permission is not granted, show a message
              return Center(
                child: Text('Camera permission is required to scan QR codes.'),
              );
            }
          }
          return Center(child: CircularProgressIndicator());  // Show loading indicator while waiting for permission status
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
