enum TypeLogement { appartement, maison }
enum SourceChauffage { bois, electricite, gaz }
enum TypeVelo { normal, electrique }

class Carbon {
  double v(double k, int n) => n > 0 ? (k * 0.14 + (1 + (n - 1) * 0.05)) / n : 0;

  double vl(TypeVelo t, double k) => t == TypeVelo.electrique ? k * 0.0015 : 0;

  double b(double co2, double k) => co2 * (1 - ((k ~/ 1000) * 0.02));

  double l(TypeLogement t, double s, SourceChauffage c) {
    double cf = t == TypeLogement.appartement ? 0.8 : 1.2;
    double cs = c == SourceChauffage.bois ? 2 : (c == SourceChauffage.electricite ? 5 : 20);
    return s * cf * cs;
  }

  String lb(double s) {
    if (s <= 500) return "Excellent";
    if (s <= 1500) return "Bon";
    if (s <= 3000) return "Médiocre";
    if (s <= 7999) return "Mauvais";
    return "Exécrable";
  }

  Map<String, dynamic> res(double kv, int n, TypeVelo tv, double kvl, TypeLogement tl, double s, SourceChauffage sc) {
    double co2p = b(v(kv, n) + vl(tv, kvl) + l(tl, s, sc), kvl);
    return {
      "tonnes": co2p / 1000,
      "score": lb(co2p),
    };
  }
}