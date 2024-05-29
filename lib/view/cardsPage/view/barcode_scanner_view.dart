import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/text_theme_light.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<StatefulWidget> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildQrView(context),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: (controller) {
            _onQRViewCreated(controller, context);
          },
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 5,
            borderLength: 20,
            borderWidth: 4,
            cutOutHeight: (MediaQuery.of(context).size.width -
                    (context.mediumValue * 1.5)) *
                0.6,
            cutOutWidth:
                MediaQuery.of(context).size.width - (context.mediumValue * 1.5),
            cutOutSize: null,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        SafeArea(
          child: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () async {
                    if (controller != null) {
                      Navigator.pop(context, result?.code);
                    }
                  },
                  icon: const Icon(
                    Icons.cancel,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    context.normalSizedBoxVertical,
                    Text(
                      LocaleKeys
                          .cards_page_add_card_scan_page_scan_your_cards_barcode
                          .locale,
                      style: context.textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    context.normalSizedBoxVertical,
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        "assets/images/barcode_scan_img.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.cancel,
                  size: 24,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: context.highValue * 0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        fixedSize: Size(
                          context.mediumValue * 7,
                          context.mediumValue * 1.42,
                        ),
                      ),
                      onPressed: () {
                        if (controller != null) {
                          Navigator.pop(context, result?.code);
                        }
                      },
                      child: Text(
                        LocaleKeys.cards_page_add_card_scan_page_manually_enter
                            .locale,
                        style: TextThemeLight.instance!.button.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    context.normalSizedBoxHorizontal,
                    ElevatedButton(
                      onPressed: () async {
                        await controller!.toggleFlash();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: Size(
                          context.mediumValue * 1.6,
                          context.mediumValue * 1.6,
                        ),
                      ),
                      child: const Icon(
                        Icons.flash_on_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.dispose();
        result = scanData;
        Navigator.pop(context, result?.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
