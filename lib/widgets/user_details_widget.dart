import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserDetailsCard extends StatelessWidget {
  final String fullName;
  final String designation;
  final String mobileNumber;
  final String tShirtSize;
  final String qrCodeNumber;

  const UserDetailsCard(
      {Key? key,
      required this.fullName,
      required this.designation,
      required this.mobileNumber,
      required this.tShirtSize,
      required this.qrCodeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350, // fixed width, can also use MediaQuery for responsive
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6),
            Text(
              designation,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.phone, size: 20, color: Colors.grey[700]),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    mobileNumber,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/jersey_details.svg',
                  width: 25,
                  height: 25,
                  color: Colors.grey[700],
                ),
                // Icon(Icons., size: 20, color: Colors.grey[700]),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tShirtSize,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.qr_code, size: 20, color: Colors.grey[700]),
                // Icon(Icons., size: 20, color: Colors.grey[700]),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    qrCodeNumber,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
