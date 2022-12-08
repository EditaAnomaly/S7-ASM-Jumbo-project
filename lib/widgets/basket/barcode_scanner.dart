import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner(this.onScan, {super.key});

  final Function(String) onScan;

  @override
  Widget build(BuildContext context) {
    return BarcodeCamera(
      types: const [
        BarcodeType.ean8,
        BarcodeType.ean13,
      ],
      resolution: Resolution.hd720,
      framerate: Framerate.fps30,
      mode: DetectionMode.pauseVideo,
      onScan: (code) => onScan(code.value),
      children: const [
        MaterialPreviewOverlay(
          animateDetection: false,
          aspectRatio: 16.0 / 11.0,
        ),
        BlurPreviewOverlay(),
      ],
    );
    return BarcodeCamera(
      types: const [
        BarcodeType.ean8,
        BarcodeType.ean13,
      ],
      resolution: Resolution.hd720,
      framerate: Framerate.fps30,
      mode: DetectionMode.pauseDetection,
      position: CameraPosition.back,
      onScan: (code) => {
        onScan(code.value),
      },
      children: const [
        MaterialPreviewOverlay(
          animateDetection: false,
          aspectRatio: 16.0 / 11.0,
        ),
      ],
    );
  }
}
