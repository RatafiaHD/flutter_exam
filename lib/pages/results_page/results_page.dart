import 'package:flutter/material.dart';
import 'package:green_track/pages/shared/app_bar.dart';
import 'package:green_track/res/app_colors.dart';
import 'package:green_track/res/app_icons.dart';
import 'widgets/score_widget.dart';

class ResultsPage extends StatelessWidget {
  final double t;
  final String s;
  final int a;
  final Map<String, double> d;

  const ResultsPage({
    super.key,
    this.t = 0.4,
    this.s = "Exécrable",
    this.a = 201,
    this.d = const {"dep": 0.1, "log": 0.1, "con": 0.2},
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.scoreExcellentBackground;
    Color bc = AppColors.scoreExcellentBorder;
    Color tx = AppColors.scoreExcellentValue;

    if (s == "Bon") {
      bg = AppColors.scoreGoodBackground; bc = AppColors.scoreGoodBorder; tx = AppColors.scoreGoodValue;
    } else if (s == "Médiocre") {
      bg = AppColors.scoreFairBackground; bc = AppColors.scoreFairBorder; tx = AppColors.scoreFairValue;
    } else if (s == "Mauvais") {
      bg = AppColors.scorePoorBackground; bc = AppColors.scorePoorBorder; tx = AppColors.scorePoorValue;
    } else if (s == "Exécrable") {
      bg = AppColors.scoreVeryPoorBackground; bc = AppColors.scoreVeryPoorBorder; tx = AppColors.scoreVeryPoorValue;
    }

    return Scaffold(
      backgroundColor: AppColors.neutral,
      appBar: const GreenTrackAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Votre score", style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
            const SizedBox(height: 30),
            Center(child: ScoreWidget(t: t, s: s, bg: bg, bc: bc, tx: tx)),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Détail de votre score", style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                  const SizedBox(height: 25),
                  _r(AppIcons.car, "Déplacements", d["dep"]!, 0.3),
                  _r(AppIcons.house, "Logement", d["log"]!, 0.2),
                  _r(AppIcons.shoppingCart, "Consommation", d["con"]!, 0.4),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xFFF0F8E8),
                  border: Border.all(color: AppColors.disabled),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Compensation", style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                  const SizedBox(height: 10),
                  Text.rich(TextSpan(text: "Il faudrait planter ", children: [
                    TextSpan(text: "$a arbres", style: const TextStyle(fontWeight: FontWeight.w800)),
                    const TextSpan(text: " pour compenser votre empreinte actuelle."),
                  ]), style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primaryDark)),
                  const SizedBox(height: 20),

                  LayoutBuilder(
                      builder: (context, constraints) {
                        const double iconSize = 16.0;
                        const double spacing = 8.0;
                        const double paddingHorizontal = 40.0; // 20 de chaque côté

                        final double availableWidth = constraints.maxWidth - paddingHorizontal;

                        final int iconsPerRow = ((availableWidth + spacing) / (iconSize + spacing)).floor();

                        final int maxTreesDisplayed = iconsPerRow * 3;

                        final int dt = a > maxTreesDisplayed ? maxTreesDisplayed : a;
                        final int xt = a > maxTreesDisplayed ? a - maxTreesDisplayed : 0;

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 11),
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.3),
                              border: Border.all(color: AppColors.disabled.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                alignment: WrapAlignment.center,
                                children: List.generate(dt, (i) => const Icon(AppIcons.forest, color: AppColors.primaryDark, size: iconSize)),
                              ),
                              if (xt > 0) ...[
                                const SizedBox(height: 11),
                                Container(
                                  width: 90, height: 26,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDark,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Text(
                                    "+ $xt",
                                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.white),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        );
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _r(IconData i, String l, double v, double p) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(children: [
            Icon(i, size: 22, color: AppColors.primaryDark),
            const SizedBox(width: 10),
            Text(l, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.black)),
            const Spacer(),
            Text("${v}t", style: const TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primaryDark)),
          ]),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: LinearProgressIndicator(
                value: p,
                minHeight: 12,
                backgroundColor: AppColors.disabled.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF38592D))
            ),
          ),
        ],
      ),
    );
  }
}