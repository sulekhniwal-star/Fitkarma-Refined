class AppSpacing {
  AppSpacing._();

  // Screen padding
  static const double screenH = 20.0;   // horizontal screen padding
  static const double cardH   = 16.0;   // inside card horizontal padding
  static const double fabClearance = 120.0; // bottom padding for FAB

  // Bento grid
  static const double bentoGap = 12.0;
}

class AppRadius {
  AppRadius._();

  static const double sm   = 10.0;   // chips, pills, tags
  static const double md   = 16.0;   // standard cards
  static const double lg   = 20.0;   // bottom sheets, modals
  static const double xl   = 28.0;   // hero sections, large cards
  static const double full = 9999.0; // avatar, FAB, round buttons

  // Bento aliases
  static const double bentoInner = 14.0; // nested cards
  static const double bentoOuter = 20.0; // outer cards
  static const double bentoHero  = 28.0; // full-width hero
}
