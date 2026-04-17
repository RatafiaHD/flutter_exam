import 'package:flutter/material.dart';
import 'package:green_track/res/app_colors.dart';

class ScoreWidget extends StatelessWidget {
  final double t;
  final String s;
  final Color bg;
  final Color bc;
  final Color tx;

  const ScoreWidget({
    super.key,
    required this.t,
    required this.s,
    required this.bg,
    required this.bc,
    required this.tx,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OrganicShapePainter(color: bg, borderColor: bc),
      child: SizedBox(
        width: 220,
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$t", style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 50, fontWeight: FontWeight.w900, color: tx)),
            Text("tonnes CO2/an", style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: tx, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: bc),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Text(s, style: TextStyle(fontFamily: 'PlusJakartaSans', color: tx, fontWeight: FontWeight.w600, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrganicShapePainter extends CustomPainter {
  const _OrganicShapePainter({required this.color, required this.borderColor});
  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint p = Paint()..color = color;
    final RRect r = RRect.fromLTRBAndCorners(
      0, 0, w, h,
      topLeft: Radius.elliptical(w * 0.6, h * 0.3),
      topRight: Radius.elliptical(w * 0.4, h * 0.67),
      bottomRight: Radius.elliptical(w * 0.7, h * 0.33),
      bottomLeft: Radius.elliptical(w * 0.3, h * 0.7),
    );
    canvas.drawRRect(r, p);
    canvas.drawRRect(r, Paint()..color = borderColor..style = PaintingStyle.stroke..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(_OrganicShapePainter old) => old.color != color || old.borderColor != borderColor;
}