import 'package:flutter/material.dart';
import 'package:green_track/res/app_colors.dart';

class LabeledSlider extends StatelessWidget {
  const LabeledSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.maxLabel,
    required this.displayValue,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final String maxLabel;
  final String displayValue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final String label = value >= max ? maxLabel : displayValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.disabled,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
