import 'package:flutter/material.dart';

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
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFF0F9FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Color(0xFF6366F1).withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6366F1).withOpacity(0.08),
              blurRadius: 24,
              offset: Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, 
                    size: 18, 
                    color: Color(0xFF10B981),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                letterSpacing: -0.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              designation,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6366F1),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 24),
            Divider(color: Color(0xFFE5E7EB), thickness: 1),
            SizedBox(height: 20),
            _buildInfoRow(
              icon: Icons.phone_rounded,
              label: 'Phone',
              value: mobileNumber,
              iconColor: Color(0xFF6366F1),
            ),
            SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.local_mall_rounded,
              label: 'T-Shirt Size',
              value: tShirtSize,
              iconColor: Color(0xFF10B981),
            ),
            SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.qr_code_2_rounded,
              label: 'QR Code',
              value: qrCodeNumber,
              iconColor: Color(0xFFF59E0B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
