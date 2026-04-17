import 'package:flutter/material.dart';
import 'package:green_track/res/app_colors.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primary : AppColors.disabled,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
