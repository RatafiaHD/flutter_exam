# Wizard Steps Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the 3 wizard steps (Transports, Logement, Consommation), a shared Provider data model, and the wizard shell with step navigation.

**Architecture:** A single `WizardModel` (ChangeNotifier) holds all form state and is provided at the root via `ChangeNotifierProvider`. Each step is a `StatelessWidget` that reads/writes the model via `context.watch` / `context.read`. `WizardPage` becomes a `StatefulWidget` managing `currentStep` (0–2) and renders the correct step widget.

**Tech Stack:** Flutter, Dart, provider 6.1.5, AppColors, AppIcons, AppLocalizations.

---

## File Map

| Action | File |
|---|---|
| Create | `lib/models/wizard_model.dart` |
| Modify | `lib/main.dart` |
| Modify | `lib/pages/wizard_page/wizard_page.dart` |
| Modify | `lib/pages/wizard_page/step/wizard_step_transports.dart` |
| Modify | `lib/pages/wizard_page/step/wizard_step_housing.dart` |
| Modify | `lib/pages/wizard_page/step/wizard_step_consumption.dart` |

---

## Task 1: WizardModel — data model + enums

**Files:**
- Create: `lib/models/wizard_model.dart`

- [ ] **Step 1: Create the model file**

```dart
import 'package:flutter/foundation.dart';

enum BikeType { electric, mechanical }

enum HousingType { apartment, house }

enum HeatingSource { electricity, gas, wood }

class WizardModel extends ChangeNotifier {
  int carKm = 12000;
  int carPassengers = 1;
  BikeType? bikeType;
  int bikeKm = 1000;

  HousingType? housingType;
  int? housingSurface;
  HeatingSource? heatingSource;

  int foodScore = 0;
  int equipmentScore = 0;

  void setCarKm(int value) {
    carKm = value;
    notifyListeners();
  }

  void setCarPassengers(int value) {
    carPassengers = value;
    notifyListeners();
  }

  void setBikeType(BikeType? value) {
    bikeType = value;
    notifyListeners();
  }

  void setBikeKm(int value) {
    bikeKm = value;
    notifyListeners();
  }

  void setHousingType(HousingType? value) {
    housingType = value;
    notifyListeners();
  }

  void setHousingSurface(int? value) {
    housingSurface = value;
    notifyListeners();
  }

  void setHeatingSource(HeatingSource? value) {
    heatingSource = value;
    notifyListeners();
  }

  void setFoodScore(int value) {
    foodScore = value;
    notifyListeners();
  }

  void setEquipmentScore(int value) {
    equipmentScore = value;
    notifyListeners();
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/models/wizard_model.dart
git commit -m "feat: add WizardModel with enums and ChangeNotifier"
```

---

## Task 2: Wire Provider in main.dart

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Update main.dart**

Replace the content of `lib/main.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
import 'package:green_track/pages/wizard_page/wizard_page.dart';
import 'package:green_track/res/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WizardModel>(
      create: (_) => WizardModel(),
      child: MaterialApp(
        title: 'Green track',
        theme: ThemeData(
          fontFamily: 'PlusJakartaSans',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            tertiary: AppColors.tertiary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            centerTitle: false,
          ),
          sliderTheme: SliderThemeData(year2023: false),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const WizardPage(),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/main.dart
git commit -m "feat: wrap app with ChangeNotifierProvider<WizardModel>"
```

---

## Task 3: WizardStepTransports

**Files:**
- Modify: `lib/pages/wizard_page/step/wizard_step_transports.dart`

- [ ] **Step 1: Implement the step**

Replace the entire file content:

```dart
import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
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
          _SectionCard(
            icon: AppIcons.car,
            title: l10n.transports_car,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.0,
              children: <Widget>[
                Text(l10n.transports_car_km_label),
                _LabeledSlider(
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
          _SectionCard(
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
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: model.bikeType == BikeType.electric
                              ? AppColors.primary
                              : AppColors.disabled,
                        ),
                        onPressed: () => context
                            .read<WizardModel>()
                            .setBikeType(BikeType.electric),
                        child: Text(l10n.transports_bike_type_electric),
                      ),
                    ),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              model.bikeType == BikeType.mechanical
                                  ? AppColors.primary
                                  : AppColors.disabled,
                        ),
                        onPressed: () => context
                            .read<WizardModel>()
                            .setBikeType(BikeType.mechanical),
                        child: Text(l10n.transports_bike_type_mechanical),
                      ),
                    ),
                  ],
                ),
                _LabeledSlider(
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
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
    final String label =
        value >= max ? maxLabel : displayValue;
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
                  color:
                      isSelected ? AppColors.primary : AppColors.cardContainer,
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
```

- [ ] **Step 2: Commit**

```bash
git add lib/pages/wizard_page/step/wizard_step_transports.dart
git commit -m "feat: implement WizardStepTransports"
```

---

## Task 4: WizardStepHousing

**Files:**
- Modify: `lib/pages/wizard_page/step/wizard_step_housing.dart`

- [ ] **Step 1: Implement the step**

Replace the entire file content:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
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
          _SectionCard(
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
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              model.housingType == HousingType.apartment
                                  ? AppColors.primary
                                  : AppColors.disabled,
                        ),
                        onPressed: () => context
                            .read<WizardModel>()
                            .setHousingType(HousingType.apartment),
                        child:
                            Text(l10n.housing_characteristics_type_apartment),
                      ),
                    ),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              model.housingType == HousingType.house
                                  ? AppColors.primary
                                  : AppColors.disabled,
                        ),
                        onPressed: () => context
                            .read<WizardModel>()
                            .setHousingType(HousingType.house),
                        child: Text(l10n.housing_characteristics_type_house),
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
          _SectionCard(
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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
```

- [ ] **Step 2: Commit**

```bash
git add lib/pages/wizard_page/step/wizard_step_housing.dart
git commit -m "feat: implement WizardStepHousing"
```

---

## Task 5: WizardStepConsumption

**Files:**
- Modify: `lib/pages/wizard_page/step/wizard_step_consumption.dart`

- [ ] **Step 1: Implement the step**

Replace the entire file content:

```dart
import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/models/wizard_model.dart';
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
          _SectionCard(
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
          _SectionCard(
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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
```

- [ ] **Step 2: Commit**

```bash
git add lib/pages/wizard_page/step/wizard_step_consumption.dart
git commit -m "feat: implement WizardStepConsumption"
```

---

## Task 6: WizardPage — shell with navigation

**Files:**
- Modify: `lib/pages/wizard_page/wizard_page.dart`

- [ ] **Step 1: Implement the wizard shell**

Replace the entire file content:

```dart
import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/pages/shared/app_bar.dart';
import 'package:green_track/pages/wizard_page/step/wizard_step_consumption.dart';
import 'package:green_track/pages/wizard_page/step/wizard_step_housing.dart';
import 'package:green_track/pages/wizard_page/step/wizard_step_transports.dart';
import 'package:green_track/res/app_colors.dart';

class WizardPage extends StatefulWidget {
  const WizardPage({super.key});

  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {
  int _currentStep = 0;

  static const int _totalSteps = 3;

  static const List<Widget> _steps = <Widget>[
    WizardStepTransports(),
    WizardStepHousing(),
    WizardStepConsumption(),
  ];

  void _goNext() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _goPrevious() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GreenTrackAppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              l10n.current_step(_currentStep + 1, _totalSteps),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
      body: _steps[_currentStep],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (_currentStep == 0)
                TextButton(
                  onPressed: () {},
                  child: Text(l10n.buttons_bar_cancel),
                )
              else
                TextButton(
                  onPressed: _goPrevious,
                  child: Text(l10n.buttons_bar_previous),
                ),
              FilledButton(
                onPressed: _currentStep < _totalSteps - 1 ? _goNext : () {},
                child: Text(
                  _currentStep < _totalSteps - 1
                      ? l10n.buttons_bar_next
                      : l10n.buttons_bar_compute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/pages/wizard_page/wizard_page.dart
git commit -m "feat: implement WizardPage shell with step navigation"
```
