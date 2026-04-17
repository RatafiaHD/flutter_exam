import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
import 'package:green_track/pages/shared/section_card.dart';
import 'package:green_track/res/app_colors.dart';
import 'package:green_track/res/app_icons.dart';
import 'package:provider/provider.dart';

class WizardStepConsumption extends StatelessWidget {
  const WizardStepConsumption({super.key});

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
            icon: AppIcons.shoppingCart,
            title: l10n.consumption_food,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l10n.consumption_label),
                RadioListTile<int>(
                  title: Text(l10n.consumption_new),
                  value: 1,
                  groupValue: model.foodScore == 0 ? null : model.foodScore,
                  activeColor: AppColors.primary,
                  onChanged: (int? v) =>
                      context.read<WizardModel>().setFoodScore(v ?? 0),
                ),
                RadioListTile<int>(
                  title: Text(l10n.consumption_second_hand),
                  value: 2,
                  groupValue: model.foodScore == 0 ? null : model.foodScore,
                  activeColor: AppColors.primary,
                  onChanged: (int? v) =>
                      context.read<WizardModel>().setFoodScore(v ?? 0),
                ),
              ],
            ),
          ),
          SectionCard(
            icon: AppIcons.shoppingCart,
            title: l10n.consumption_equipment,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l10n.consumption_label),
                RadioListTile<int>(
                  title: Text(l10n.consumption_new),
                  value: 1,
                  groupValue:
                      model.equipmentScore == 0 ? null : model.equipmentScore,
                  activeColor: AppColors.primary,
                  onChanged: (int? v) =>
                      context.read<WizardModel>().setEquipmentScore(v ?? 0),
                ),
                RadioListTile<int>(
                  title: Text(l10n.consumption_second_hand),
                  value: 2,
                  groupValue:
                      model.equipmentScore == 0 ? null : model.equipmentScore,
                  activeColor: AppColors.primary,
                  onChanged: (int? v) =>
                      context.read<WizardModel>().setEquipmentScore(v ?? 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
