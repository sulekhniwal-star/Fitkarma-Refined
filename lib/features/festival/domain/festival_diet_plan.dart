import 'package:flutter/material.dart';

enum FestivalDietType {
  nirjalaFast,
  phalaharFast,
  sattvicFast,
  jainFast,
  rozaFast,
  partialFast,
  feastMode,
  moderateIndulgence,
  communityMeal,
  noRestriction
}

class FestivalDietConfig {
  final String festivalId;
  final FestivalDietType type;
  final List<String>? allowedFoodIds;
  final List<String>? forbiddenFoodIds;
  final TimeOfDay? sehriCutoffTime;
  final TimeOfDay? iftarTime; // Generally computed at runtime
  final double calorieBudgetMultiplier;
  final bool suppressWorkoutIntensity;
  final String? fastBreakSuggestion;
  final String insightCardMessage;

  const FestivalDietConfig({
    required this.festivalId,
    required this.type,
    this.allowedFoodIds,
    this.forbiddenFoodIds,
    this.sehriCutoffTime,
    this.iftarTime,
    this.calorieBudgetMultiplier = 1.0,
    this.suppressWorkoutIntensity = false,
    this.fastBreakSuggestion,
    required this.insightCardMessage,
  });
}

const Map<String, FestivalDietConfig> festivalDietConfigs = {
  'navratri': FestivalDietConfig(
    festivalId: 'navratri',
    type: FestivalDietType.sattvicFast,
    calorieBudgetMultiplier: 0.80,
    allowedFoodIds: ['sabudana', 'kuttu', 'singhara', 'rajgira', 'fruits', 'milk', 'paneer', 'sendha_namak'],
    forbiddenFoodIds: ['wheat', 'rice', 'pulses', 'onion', 'garlic'],
    insightCardMessage: "Navratri is here! Focus on Sattvic foods. We've adjusted your calorie goal by -20%.",
  ),
  'diwali': FestivalDietConfig(
    festivalId: 'diwali',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.15,
    insightCardMessage: "Happy Diwali! Enjoy the festivities safely. We've allowed 15% extra calories for sweets.",
  ),
  'holi': FestivalDietConfig(
    festivalId: 'holi',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Happy Holi! Tracking Gujiyas today? Enjoy your meal with awareness.",
  ),
  'karva_chauth': FestivalDietConfig(
    festivalId: 'karva_chauth',
    type: FestivalDietType.nirjalaFast,
    calorieBudgetMultiplier: 0.5,
    suppressWorkoutIntensity: true,
    fastBreakSuggestion: "Dates + warm water + sherbet",
    insightCardMessage: "Karva Chauth Vrat detected. Avoid intense activity today. Break your fast with hydrating fluids.",
  ),
  'ramadan': FestivalDietConfig(
    festivalId: 'ramadan',
    type: FestivalDietType.rozaFast,
    calorieBudgetMultiplier: 0.85,
    suppressWorkoutIntensity: true,
    insightCardMessage: "Ramadan Kareem. Focus on a high-protein Sehri and a hydrating Iftar.",
  ),
  'paryushana': FestivalDietConfig(
    festivalId: 'paryushana',
    type: FestivalDietType.jainFast,
    calorieBudgetMultiplier: 0.80,
    forbiddenFoodIds: ['potato', 'carrot', 'beet', 'onion', 'garlic'],
    insightCardMessage: "Paryushana Parv. Jain Vrat mode active — root vegetables are restricted.",
  ),
  'janmashtami': FestivalDietConfig(
    festivalId: 'janmashtami',
    type: FestivalDietType.phalaharFast,
    calorieBudgetMultiplier: 0.85,
    allowedFoodIds: ['fruits', 'milk', 'curd', 'makhana', 'dry_fruits'],
    insightCardMessage: "Happy Janmashtami! Stick to Phalahar foods today.",
  ),
  'shivaratri': FestivalDietConfig(
    festivalId: 'shivaratri',
    type: FestivalDietType.nirjalaFast,
    calorieBudgetMultiplier: 0.70,
    suppressWorkoutIntensity: true,
    insightCardMessage: "Maha Shivaratri. High-intensity workouts are not recommended during fasting.",
  ),
  'dussehra': FestivalDietConfig(
    festivalId: 'dussehra',
    type: FestivalDietType.partialFast,
    calorieBudgetMultiplier: 0.95,
    insightCardMessage: "Vijayadashami. Keep your meals light and balanced today.",
  ),
  'ram_navami': FestivalDietConfig(
    festivalId: 'ram_navami',
    type: FestivalDietType.sattvicFast,
    calorieBudgetMultiplier: 0.90,
    insightCardMessage: "Ram Navami. Sattvic diet recommended for today.",
  ),
  'ganesh_chaturthi': FestivalDietConfig(
    festivalId: 'ganesh_chaturthi',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Ganpati Bappa Morya! 5% extra calorie room for Modaks today.",
  ),
  'onam': FestivalDietConfig(
    festivalId: 'onam',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Happy Onam! Tracking your Sadhya? Enjoy the grand feast!",
  ),
  'chhath_puja': FestivalDietConfig(
    festivalId: 'chhath_puja',
    type: FestivalDietType.nirjalaFast,
    calorieBudgetMultiplier: 0.40,
    suppressWorkoutIntensity: true,
    insightCardMessage: "Chhath Puja Nirjala Vrat. Rest well and stay hydrated after the fast.",
  ),
  'raksha_bandhan': FestivalDietConfig(
    festivalId: 'raksha_bandhan',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Happy Raksha Bandhan! Enjoy the sweets in moderation.",
  ),
  'guru_nanak_jayanti': FestivalDietConfig(
    festivalId: 'guru_nanak_jayanti',
    type: FestivalDietType.communityMeal,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Happy Gurpurab! Langar-aligned plan active today.",
  ),
  'christmas': FestivalDietConfig(
    festivalId: 'christmas',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Merry Christmas! Enjoy your festive dinner with awareness.",
  ),
  'eid_ul_fitr': FestivalDietConfig(
    festivalId: 'eid_ul_fitr',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.15,
    insightCardMessage: "Eid Mubarak! Celebrate with a delicious feast today.",
  ),
  'eid_ul_adha': FestivalDietConfig(
    festivalId: 'eid_ul_adha',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Eid-ul-Adha. Enjoy your festive protein-rich meals.",
  ),
  'teej': FestivalDietConfig(
    festivalId: 'teej',
    type: FestivalDietType.nirjalaFast,
    calorieBudgetMultiplier: 0.60,
    suppressWorkoutIntensity: true,
    insightCardMessage: "Happy Teej! Nirjala fast detected. Stay in a cool environment.",
  ),
  'ugadi': FestivalDietConfig(
    festivalId: 'ugadi',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Happy Ugadi / Gudi Padwa! Celebrate the New Year with healthy choices.",
  ),
  'bihu': FestivalDietConfig(
    festivalId: 'bihu',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Happy Bihu! Enjoy the traditional snacks with awareness.",
  ),
  'baisakhi': FestivalDietConfig(
    festivalId: 'baisakhi',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Happy Baisakhi! Harvest festival mode active.",
  ),
  'lohri': FestivalDietConfig(
    festivalId: 'lohri',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Happy Lohri! Watch your calorie intake from peanuts and popcorn.",
  ),
  'buddha_purnima': FestivalDietConfig(
    festivalId: 'buddha_purnima',
    type: FestivalDietType.sattvicFast,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Buddha Purnima. Vegetarian/Sattvic diet encouraged today.",
  ),
  'navroze': FestivalDietConfig(
    festivalId: 'navroze',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Navroze Mubarak! Enjoy the Parsi feast today.",
  ),
  'durga_puja': FestivalDietConfig(
    festivalId: 'durga_puja',
    type: FestivalDietType.feastMode,
    calorieBudgetMultiplier: 1.10,
    insightCardMessage: "Subho Bijoya! Enjoy the Durga Puja festivities and feasts.",
  ),
  'hanuman_jayanti': FestivalDietConfig(
    festivalId: 'hanuman_jayanti',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Hanuman Jayanti. Vegetarian-only mode active.",
  ),
  'easter': FestivalDietConfig(
    festivalId: 'easter',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Happy Easter! Celebrate with a healthy and happy meal.",
  ),
  'republic_day': FestivalDietConfig(
    festivalId: 'republic_day',
    type: FestivalDietType.noRestriction,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Happy Republic Day! Stay fit for the nation.",
  ),
  'independence_day': FestivalDietConfig(
    festivalId: 'independence_day',
    type: FestivalDietType.noRestriction,
    calorieBudgetMultiplier: 1.0,
    insightCardMessage: "Happy Independence Day! Take a pledge for better health.",
  ),
  'maha_ashtami': FestivalDietConfig(
    festivalId: 'maha_ashtami',
    type: FestivalDietType.partialFast,
    calorieBudgetMultiplier: 0.90,
    insightCardMessage: "Maha Ashtami. Partial fasting diet active.",
  ),
  'makar_sankranti': FestivalDietConfig(
    festivalId: 'makar_sankranti',
    type: FestivalDietType.moderateIndulgence,
    calorieBudgetMultiplier: 1.05,
    insightCardMessage: "Makar Sankranti. Enjoy some Til-gul for good health!",
  ),
};
