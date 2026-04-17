import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/res/app_icons.dart';

class GreenTrackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GreenTrackAppBar({super.key, this.bottom});

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        spacing: 14.0,
        children: <Widget>[
          Icon(AppIcons.app, size: 20.0),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.app_name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
