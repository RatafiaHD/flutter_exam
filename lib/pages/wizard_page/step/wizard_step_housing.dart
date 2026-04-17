import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
import 'package:green_track/pages/shared/choice_button.dart';
import 'package:green_track/pages/shared/section_card.dart';
import 'package:green_track/res/app_colors.dart';
import 'package:green_track/res/app_icons.dart';
import 'package:provider/provider.dart';

class WizardStepHousing extends StatelessWidget {
  const WizardStepHousing({super.key});

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
            icon: AppIcons.house,
            title: l10n.housing_characteristics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: <Widget>[
                Text(l10n.housing_characteristics_type_label),
                Row(
                  spacing: 12.0,
                  children: <Widget>[
                    Expanded(
                      child: ChoiceButton(
                        label: l10n.housing_characteristics_type_apartment,
                        isSelected: model.housingType == HousingType.apartment,
                        onPressed: () => context
                            .read<WizardModel>()
                            .setHousingType(HousingType.apartment),
                      ),
                    ),
                    Expanded(
                      child: ChoiceButton(
                        label: l10n.housing_characteristics_type_house,
                        isSelected: model.housingType == HousingType.house,
                        onPressed: () => context
                            .read<WizardModel>()
                            .setHousingType(HousingType.house),
                      ),
                    ),
                  ],
                ),
                Text(l10n.housing_characteristics_surface_label),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: l10n.housing_characteristics_surface_hint,
                    suffixText: l10n.housing_characteristics_surface_suffix,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (String v) {
                    final int? parsed = int.tryParse(v);
                    context.read<WizardModel>().setHousingSurface(
                          parsed != null && parsed > 0 ? parsed : null,
                        );
                  },
                ),
              ],
            ),
          ),
          SectionCard(
            icon: AppIcons.heating,
            title: l10n.housing_heating_source,
            child: Column(
              children: <Widget>[
                RadioListTile<HeatingSource>(
                  title: Text(l10n.housing_heating_source_electricity),
                  value: HeatingSource.electricity,
                  groupValue: model.heatingSource,
                  activeColor: AppColors.primary,
                  onChanged: (HeatingSource? v) =>
                      context.read<WizardModel>().setHeatingSource(v),
                ),
                RadioListTile<HeatingSource>(
                  title: Text(l10n.housing_heating_source_gas),
                  value: HeatingSource.gas,
                  groupValue: model.heatingSource,
                  activeColor: AppColors.primary,
                  onChanged: (HeatingSource? v) =>
                      context.read<WizardModel>().setHeatingSource(v),
                ),
                RadioListTile<HeatingSource>(
                  title: Text(l10n.housing_heating_source_wood),
                  value: HeatingSource.wood,
                  groupValue: model.heatingSource,
                  activeColor: AppColors.primary,
                  onChanged: (HeatingSource? v) =>
                      context.read<WizardModel>().setHeatingSource(v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
