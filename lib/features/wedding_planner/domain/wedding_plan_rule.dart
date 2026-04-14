/// Wedding Plan Rule Engine
///
/// A local-first, rule-based engine that derives today's meal plan and workout
/// recommendation from the (phase, role, goal, eventKey) tuple.
///
/// Rules are defined statically here and can be overridden or extended at
/// runtime via RemoteConfig-delivered JSON (see RemoteConfigService). The
/// engine always falls back to the local rules if RemoteConfig is unavailable.

library;

// ─── Enums ───────────────────────────────────────────────────────────────────

enum WeddingPhase { preWedding, weddingWeek, postWedding, unknown }

enum WeddingPlanRole { bride, groom, guest, relative, none }

enum WeddingEventKey { haldi, mehendi, sangeet, baraat, vivah, reception }

// ─── Output model ────────────────────────────────────────────────────────────

class WeddingDayPlan {
  final String? eventKey;
  final String dietPhaseLabel;
  final String breakfastSuggestion;
  final String lunchSuggestion;
  final String dinnerSuggestion;
  final String snackSuggestion;
  final String workoutLabel;
  final String tip;

  const WeddingDayPlan({
    this.eventKey,
    required this.dietPhaseLabel,
    required this.breakfastSuggestion,
    required this.lunchSuggestion,
    required this.dinnerSuggestion,
    required this.snackSuggestion,
    required this.workoutLabel,
    required this.tip,
  });
}

// ─── Engine ──────────────────────────────────────────────────────────────────

class WeddingPlanEngine {
  /// Derive which wedding phase the user is currently in.
  static WeddingPhase computePhase({
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    if (startDate == null || endDate == null) return WeddingPhase.unknown;
    final now = DateTime.now();
    final weddingWeekStart = startDate.subtract(const Duration(days: 7));

    if (now.isAfter(endDate)) return WeddingPhase.postWedding;
    if (now.isAfter(weddingWeekStart) || now.isAtSameMomentAs(weddingWeekStart)) {
      return WeddingPhase.weddingWeek;
    }
    return WeddingPhase.preWedding;
  }

  /// Derive how many days until the wedding start.
  static int daysUntilWedding(DateTime? startDate) {
    if (startDate == null) return -1;
    return startDate.difference(DateTime.now()).inDays.clamp(0, 999);
  }

  /// Derive which prep sub-week the user is in (1-indexed).
  static int currentPrepWeek(DateTime? startDate, int? totalPrepWeeks) {
    if (startDate == null || totalPrepWeeks == null) return 1;
    final elapsed = DateTime.now().difference(startDate.subtract(Duration(days: totalPrepWeeks * 7))).inDays;
    return ((elapsed / 7).floor() + 1).clamp(1, totalPrepWeeks);
  }

  /// Core rule lookup. Consults static rules then applies any RemoteConfig
  /// overrides that were previously fetched and cached in Drift.
  ///
  /// [remoteOverrides] — optional map from RemoteConfig (e.g. fetched during
  /// background sync). Keys are `"wedding_plan_${phase}_${role}_${goal}"`.
  ///
  /// [eventKey] — optional specific event for event-day meal plans.
  /// When provided, returns specialized plan for that event.
  static WeddingDayPlan evaluate({
    required WeddingPhase phase,
    required WeddingPlanRole role,
    required String? goal,
    Map<String, dynamic>? remoteOverrides,
    String? eventKey,
  }) {
    // If we have a specific event, use event-specific plan
    if (eventKey != null && eventKey.isNotEmpty) {
      final eventPlan = _eventSpecificPlan(eventKey, role);
      if (eventPlan != null) return eventPlan;
    }

    final key = '${_phaseKey(phase)}_${_roleKey(role)}_${goal ?? 'default'}';

    // RemoteConfig override wins if present
    if (remoteOverrides != null) {
      final overrideJson = remoteOverrides['wedding_plan_$key'];
      if (overrideJson is Map<String, dynamic>) {
        return _fromJson(overrideJson);
      }
    }

    return _localRules(phase, role, goal);
  }

  // ── Local rule table ───────────────────────────────────────────────────────

  static WeddingDayPlan _localRules(
    WeddingPhase phase,
    WeddingPlanRole role,
    String? goal,
  ) {
    // post-wedding: everyone gets the same recovery plan
    if (phase == WeddingPhase.postWedding) {
      return const WeddingDayPlan(
        dietPhaseLabel: 'Post-Wedding Detox',
        breakfastSuggestion: 'Moong dal khichdi + nimbu paani',
        lunchSuggestion: 'Light dal + brown rice + salad',
        dinnerSuggestion: 'Vegetable soup + 2 multigrain rotis',
        snackSuggestion: 'Coconut water + seasonal fruits',
        workoutLabel: '20 min gentle yoga + 30 min walk',
        tip: 'Avoid high-intensity workouts for 5 days. Focus on rest and hydration.',
      );
    }

    // wedding week: role + goal branches
    if (phase == WeddingPhase.weddingWeek) {
      return _weddingWeekPlan(role, goal);
    }

    // pre-wedding: role + goal branches
    return _preWeddingPlan(role, goal);
  }

  // ── Event-specific plans ───────────────────────────────────────────────────

  static WeddingDayPlan? _eventSpecificPlan(String eventKey, WeddingPlanRole role) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;

    switch (eventKey.toLowerCase()) {
      case 'haldi':
        return _haldiDayPlan(role);
      case 'mehendi':
        return _mehendiDayPlan(role);
      case 'sangeet':
      case 'garba':
        return _sangeetDayPlan(role);
      case 'baraat':
        return _baraatDayPlan(role);
      case 'vivah':
      case 'wedding':
        return _weddingDayPlan(role);
      case 'reception':
        return _receptionDayPlan(role);
      default:
        return null;
    }
  }

  static WeddingDayPlan _haldiDayPlan(WeddingPlanRole role) {
    return const WeddingDayPlan(
      eventKey: 'haldi',
      dietPhaseLabel: 'Haldi Anti-Inflammatory',
      breakfastSuggestion: 'Haldi milk (turmeric + milk + black pepper) + banana',
      lunchSuggestion: 'Light dal + 1 roti + cucumber salad',
      dinnerSuggestion: 'Grilled paneer + mixed vegetable sabzi',
      snackSuggestion: 'Turmeric chai + roasted makhana',
      workoutLabel: '30 min gentle yoga — avoid heavy exercise',
      tip: 'Haldi has anti-inflammatory properties. Stay hydrated and wear old clothes!',
    );
  }

  static WeddingDayPlan _mehendiDayPlan(WeddingPlanRole role) {
    return const WeddingDayPlan(
      eventKey: 'mehendi',
      dietPhaseLabel: 'Mehendi Day Light & Energising',
      breakfastSuggestion: 'Oats upma + nimbu paani',
      lunchSuggestion: 'Light rice + dal + salad (avoid heavy lunch before sitting)',
      dinnerSuggestion: 'Khichdi + curd (easy to eat while waiting for mehendi to dry)',
      snackSuggestion: 'Fruits + coconut water',
      workoutLabel: 'Rest day — light stretching only',
      tip: 'Keep hands still while mehendi dries. Avoid water contact for 6-8 hours.',
    );
  }

  static WeddingDayPlan _sangeetDayPlan(WeddingPlanRole role) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;
    return WeddingDayPlan(
      eventKey: 'sangeet',
      dietPhaseLabel: 'Sangeet Energy Boost',
      breakfastSuggestion: isBrideGroom ? 'Banana + 2 eggs + toast' : 'Poha + fruits',
      lunchSuggestion: isBrideGroom 
          ? 'Chicken/paneer + rice + salad (load up before dancing)'
          : 'Dal + rotis + sabzi',
      dinnerSuggestion: 'Light pre-dance: banana shake or dates + nuts',
      snackSuggestion: 'Energy bars + coconut water during event',
      workoutLabel: isBrideGroom 
          ? 'Warm up session (10 min) before garba'
          : 'Enjoy the dancing!',
      tip: isBrideGroom 
          ? 'You\'ll dance 2-3 hours. Eat protein before to maintain energy.'
          : 'Stay hydrated and snack between dance sets.',
    );
  }

  static WeddingDayPlan _baraatDayPlan(WeddingPlanRole role) {
    final isGroom = role == WeddingPlanRole.groom;
    return WeddingDayPlan(
      eventKey: 'baraat',
      dietPhaseLabel: 'Baraat Endurance Day',
      breakfastSuggestion: isGroom 
          ? 'Peanut butter toast + banana + honey chai'
          : 'Paratha + curd + fruits',
      lunchSuggestion: isGroom 
          ? 'Heavy pre-baraat meal: dal makhani + rice + paneer (2 hours before)'
          : 'Regular lunch',
      dinnerSuggestion: isGroom 
          ? 'Light dinner after baraat: soup + rotis'
          : 'Buffet dinner — protein first strategy',
      snackSuggestion: 'Dates + nuts +-electrolyte drinks throughout',
      workoutLabel: isGroom 
          ? 'Light warm-up (5 min) — save energy for baraat dance'
          : 'Stay active during celebrations',
      tip: isGroom 
          ? 'Baraat can last 2-3 hours with continuous dancing. Hydrate constantly!'
          : 'Cheer for the baraat! Keep energy up with small frequent snacks.',
    );
  }

  static WeddingDayPlan _weddingDayPlan(WeddingPlanRole role) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;
    
    if (isBrideGroom) {
      return const WeddingDayPlan(
        eventKey: 'vivah',
        dietPhaseLabel: 'Wedding Day Bloat-Free',
        breakfastSuggestion: 'Idli + sambar + nimbu paani (light, no bloat)',
        lunchSuggestion: 'Light dal + rice + salad — don\'t skip, you need energy!',
        dinnerSuggestion: 'Easy-digest: paneer + rotis + warm jeera water',
        snackSuggestion: 'Fruits + dry fruits (keep by your side during ceremony)',
        workoutLabel: 'Rest & breathing only — you\'ll be on your feet all day',
        tip: 'Don\'t skip meals! Eat small amounts regularly. Stay hydrated. Congratulations! 🎊',
      );
    }
    
    return const WeddingDayPlan(
      eventKey: 'vivah',
      dietPhaseLabel: 'Wedding Day Enjoy',
      breakfastSuggestion: 'Idli/dosa + sambar + chai',
      lunchSuggestion: 'Full wedding lunch — enjoy mindfully',
      dinnerSuggestion: 'Reception dinner — protein first on plate',
      snackSuggestion: 'Wedding sweets in moderation',
      workoutLabel: 'Enjoy the celebrations!',
      tip: 'Use the "protein first" strategy at the buffet: fill half your plate with protein before carbs.',
    );
  }

  static WeddingDayPlan _receptionDayPlan(WeddingPlanRole role) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;
    
    return WeddingDayPlan(
      eventKey: 'reception',
      dietPhaseLabel: isBrideGroom ? 'Post-Wedding Celebration' : 'Reception Night',
      breakfastSuggestion: isBrideGroom 
          ? 'Light breakfast: fruits + yogurt'
          : 'Regular breakfast',
      lunchSuggestion: isBrideGroom 
          ? 'Recovery meal: dal + rice + vegetables'
          : 'Regular lunch',
      dinnerSuggestion: 'Reception dinner — enjoy but stay mindful',
      snackSuggestion: 'Wedding cake + mithai in moderation',
      workoutLabel: isBrideGroom 
          ? 'Rest day after wedding'
          : 'Enjoy the party!',
      tip: isBrideGroom 
          ? 'Congratulations! Focus on rest and hydration today.'
          : 'At the reception buffet? Eat protein and veggies first, save sweets for last.',
    );
  }

  static WeddingDayPlan _preWeddingPlan(WeddingPlanRole role, String? goal) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;

    switch (goal) {
      case 'tone_up':
      case 'Weight Loss':
      case 'Glowing Skin':
        return WeddingDayPlan(
          dietPhaseLabel: 'Lean & Glow',
          breakfastSuggestion: isBrideGroom
              ? 'Moong dal chilla + low-fat curd'
              : 'Oats upma + nimbu paani',
          lunchSuggestion: 'Dal + 1 roti + sabzi (no fried)',
          dinnerSuggestion: 'Paneer tikka + salad (no dressing)',
          snackSuggestion: 'Roasted chana + green tea',
          workoutLabel: isBrideGroom ? '30 min HIIT + 15 min yoga' : '40 min cardio + stretching',
          tip: 'Avoid cruciferous veggies this week — broccoli and cauliflower can cause bloating before events.',
        );
      case 'energised':
      case 'Stay Energetic':
        return WeddingDayPlan(
          dietPhaseLabel: 'Energise & Sustain',
          breakfastSuggestion: 'Banana + 2 boiled eggs + chai (no sugar)',
          lunchSuggestion: 'Rajma chawal (moderate portion) + lassi',
          dinnerSuggestion: 'Chicken tikka or paneer + dal soup',
          snackSuggestion: '5 dates + coconut water',
          workoutLabel: '30 min strength training + 20 min pranayama',
          tip: 'Eat every 3 hours to maintain energy through long event days.',
        );
      case 'manage_stress':
      case 'Stress Relief':
        return const WeddingDayPlan(
          dietPhaseLabel: 'Calm & Nourish',
          breakfastSuggestion: 'Banana smoothie with ashwagandha milk',
          lunchSuggestion: 'Khichdi + ghee + papad',
          dinnerSuggestion: '2 rotis + dal + warm milk before bed',
          snackSuggestion: 'Walnuts + chamomile tea',
          workoutLabel: '30 min yoga + 10 min meditation',
          tip: 'Magnesium-rich foods (nuts, dark chocolate) help reduce cortisol. Add them to snacks.',
        );
      case 'manage_indulgence':
      case 'Manage indulgence':
        return const WeddingDayPlan(
          dietPhaseLabel: 'Mindful Indulgence',
          breakfastSuggestion: 'Idli + sambar + 1 glass nimbu paani',
          lunchSuggestion: 'Dal + 2 rotis + salad',
          dinnerSuggestion: 'Vegetable curry + rice (moderate)',
          snackSuggestion: 'Roasted makhana + green tea',
          workoutLabel: '45 min brisk walk + stretching',
          tip: 'Use the 80/20 rule at events: eat mindfully for 80% of the meal, then enjoy a small treat.',
        );
      default:
        // Bride/Groom default: Posture & Core
        if (isBrideGroom) {
          return const WeddingDayPlan(
            dietPhaseLabel: 'Wedding Prep',
            breakfastSuggestion: 'Poha with peanuts + 1 glass nimbu paani',
            lunchSuggestion: 'Chole + 2 rotis + salad',
            dinnerSuggestion: 'Palak paneer + brown rice',
            snackSuggestion: 'Mixed nuts + coconut water',
            workoutLabel: '30 min posture & core + 20 min cardio',
            tip: 'Stay hydrated — aim for 3L of water per day in the pre-wedding phase.',
          );
        }
        return const WeddingDayPlan(
          dietPhaseLabel: 'Wedding Ready',
          breakfastSuggestion: 'Upma + fruit bowl + chai',
          lunchSuggestion: 'Dal + sabzi + 2 rotis',
          dinnerSuggestion: 'Rajma + rice + salad',
          snackSuggestion: 'Banana + roasted chana',
          workoutLabel: '30 min walk + light stretching',
          tip: 'Pack healthy snacks for the festivities — roasted nuts and fruits travel well.',
        );
    }
  }

  static WeddingDayPlan _weddingWeekPlan(WeddingPlanRole role, String? goal) {
    final isBrideGroom = role == WeddingPlanRole.bride || role == WeddingPlanRole.groom;

    if (isBrideGroom) {
      return const WeddingDayPlan(
        dietPhaseLabel: 'Bloat-Free Wedding Week',
        breakfastSuggestion: 'Moong dal chilla + curd (no fruits that bloat)',
        lunchSuggestion: 'Light dal soup + 1 roti + bottle gourd sabzi',
        dinnerSuggestion: 'Grilled paneer + salad + warm jeera water',
        snackSuggestion: 'Banana + 5 dates (pre-event energy)',
        workoutLabel: '20 min yoga & breathwork ONLY — no heavy lifting',
        tip: 'Avoid broccoli, beans, cabbage, onion-heavy dishes and carbonated drinks this week.',
      );
    }

    return const WeddingDayPlan(
      dietPhaseLabel: 'Event-Week Stamina',
      breakfastSuggestion: 'Oats porridge + banana + black coffee or tea',
      lunchSuggestion: 'Dal + rice + salad — avoid heavy fried appetisers at lunch',
      dinnerSuggestion: 'Grilled chicken or paneer + roti + sabzi',
      snackSuggestion: 'Coconut water + roasted chana between events',
      workoutLabel: '30 min walk + light stretching daily',
      tip: 'Prioritise sleep over late-night festivities where possible. Fatigue accumulates fast during multi-day weddings.',
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static String _phaseKey(WeddingPhase p) => p.name;
  static String _roleKey(WeddingPlanRole r) => r.name;

  static WeddingDayPlan _fromJson(Map<String, dynamic> j) {
    return WeddingDayPlan(
      eventKey: j['eventKey'] as String?,
      dietPhaseLabel: j['dietPhaseLabel'] ?? '',
      breakfastSuggestion: j['breakfastSuggestion'] ?? '',
      lunchSuggestion: j['lunchSuggestion'] ?? '',
      dinnerSuggestion: j['dinnerSuggestion'] ?? '',
      snackSuggestion: j['snackSuggestion'] ?? '',
      workoutLabel: j['workoutLabel'] ?? '',
      tip: j['tip'] ?? '',
    );
  }
}
