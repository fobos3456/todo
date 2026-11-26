import 'package:flutter/material.dart';
import '../models/app_language.dart';

class EmergencyBanner extends StatelessWidget {
  final AppStrings strings;
  final VoidCallback onEmergencyClick;

  const EmergencyBanner({
    super.key,
    required this.strings,
    required this.onEmergencyClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDAD6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBA1A1A), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Color(0xFF410002), size: 26),
              SizedBox(width: 8),
              Text(
                "ALERTA DE EMERGENCIA",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF410002), fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            strings.emergencyNotice,
            style: const TextStyle(color: Color(0xFF410002), fontSize: 13, height: 1.3),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onEmergencyClick,
              icon: const Icon(Icons.phone),
              label: Text(strings.emergencyAction, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
