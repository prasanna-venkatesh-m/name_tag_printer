import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onScanPressed;
  final String label;

  const ScanButton(
      {Key? key, required this.onScanPressed, this.label = "Scan QR"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.qr_code_scanner, color: Colors.white),
      label: Text(label),
      onPressed: onScanPressed,
    );
  }
}

class ScanCardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const ScanCardButton({
    Key? key,
    required this.onPressed,
    this.label = "Scan QR",
    this.icon = Icons.qr_code_scanner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150, // square shape
        height: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFF5722),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
