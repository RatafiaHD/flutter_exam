import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
import 'package:green_track/pages/shared/choice_button.dart';
import 'package:green_track/pages/shared/labeled_slider.dart';
import 'package:green_track/pages/shared/section_card.dart';
import 'package:green_track/res/app_colors.dart';
import 'package:green_track/res/app_icons.dart';
import 'package:provider/provider.dart';

class WizardStepTransports extends StatelessWidget {
  const WizardStepTransports({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final WizardModel model = context.watch<WizardModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24.0,
        children: <Widget>[
          SectionCard(
            icon: AppIcons.car,
            title: l10n.transports_car,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: <Widget>[
                Text(l10n.transports_car_km_label),
                LabeledSlider(
                  value: model.carKm.toDouble(),
                  min: 0,
                  max: 15000,
                  maxLabel: '15 000+',
                  displayValue: l10n.transports_car_km_value(model.carKm),
                  onChanged: (double v) =>
                      context.read<WizardModel>().setCarKm(v.toInt()),
                ),
                Text(l10n.transports_car_passengers),
                _PassengerSelector(
                  value: model.carPassengers,
                  onChanged: (int v) =>
                      context.read<WizardModel>().setCarPassengers(v),
                ),
              ],
            ),
          ),
          SectionCard(
            icon: AppIcons.bike,
            title: l10n.transports_bike,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: <Widget>[
                Row(
                  spacing: 12.0,
                  children: <Widget>[
                    Expanded(
                      child: ChoiceButton(
                        label: l10n.transports_bike_type_electric,
                        isSelected: model.bikeType == BikeType.electric,
                        onPressed: () => context
                            .read<WizardModel>()
                            .setBikeType(BikeType.electric),
                      ),
                    ),
                    Expanded(
                      child: ChoiceButton(
                        label: l10n.transports_bike_type_mechanical,
                        isSelected: model.bikeType == BikeType.mechanical,
                        onPressed: () => context
                            .read<WizardModel>()
                            .setBikeType(BikeType.mechanical),
                      ),
                    ),
                  ],
                ),
                LabeledSlider(
                  value: model.bikeKm.toDouble(),
                  min: 0,
                  max: 10000,
                  maxLabel: '10 000+',
                  displayValue: l10n.transports_bike_km_value(model.bikeKm),
                  onChanged: (double v) =>
                      context.read<WizardModel>().setBikeKm(v.toInt()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PassengerSelector extends StatelessWidget {
  const _PassengerSelector({
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: List<Widget>.generate(5, (int i) {
        final int passenger = i + 1;
        final bool isSelected = value == passenger;
        final String label = passenger == 5 ? '5+' : '$passenger';
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(passenger),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.cardBackground,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.cardContainer,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.white : AppColors.primary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
