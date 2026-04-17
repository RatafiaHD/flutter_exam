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
