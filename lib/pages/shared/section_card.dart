import 'package:flutter/material.dart';
import 'package:green_track/res/app_colors.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.0,
        children: <Widget>[
          Row(
            spacing: 8.0,
            children: <Widget>[
              Icon(icon, color: AppColors.primary),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
