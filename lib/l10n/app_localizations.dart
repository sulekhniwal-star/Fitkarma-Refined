import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_as.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_brx.dart';
import 'app_localizations_doi.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_kok.dart';
import 'app_localizations_ks.dart';
import 'app_localizations_mai.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mni.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_sa.dart';
import 'app_localizations_sat.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('as'),
    Locale('bn'),
    Locale('brx'),
    Locale('doi'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('kok'),
    Locale('ks'),
    Locale('mai'),
    Locale('ml'),
    Locale('mni'),
    Locale('mr'),
    Locale('ne'),
    Locale('or'),
    Locale('pa'),
    Locale('sa'),
    Locale('sat'),
    Locale('sd'),
    Locale('ta'),
    Locale('te'),
    Locale('ur'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'FitKarma'**
  String get appName;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get navFood;

  /// No description provided for @navWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get navWorkout;

  /// No description provided for @navSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get navSteps;

  /// No description provided for @navSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get navSleep;

  /// No description provided for @navSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get navSocial;

  /// No description provided for @navMe.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get navMe;

  /// No description provided for @screenTitleDashboard.
  ///
  /// In en, this message translates to:
  /// **'My Health Dashboard'**
  String get screenTitleDashboard;

  /// No description provided for @screenTitleProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get screenTitleProfile;

  /// No description provided for @screenTitleSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get screenTitleSettings;

  /// No description provided for @screenTitleFood.
  ///
  /// In en, this message translates to:
  /// **'Food Tracking'**
  String get screenTitleFood;

  /// No description provided for @screenTitleWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get screenTitleWorkout;

  /// No description provided for @screenTitleYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga & Mindfulness'**
  String get screenTitleYoga;

  /// No description provided for @screenTitleSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get screenTitleSteps;

  /// No description provided for @screenTitleSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get screenTitleSleep;

  /// No description provided for @screenTitleKarma.
  ///
  /// In en, this message translates to:
  /// **'Karma Hub'**
  String get screenTitleKarma;

  /// No description provided for @screenTitleLabReports.
  ///
  /// In en, this message translates to:
  /// **'Lab Reports'**
  String get screenTitleLabReports;

  /// No description provided for @screenTitleABHA.
  ///
  /// In en, this message translates to:
  /// **'ABHA Health ID'**
  String get screenTitleABHA;

  /// No description provided for @screenTitleEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency Card'**
  String get screenTitleEmergency;

  /// No description provided for @screenTitleWedding.
  ///
  /// In en, this message translates to:
  /// **'Wedding Planner'**
  String get screenTitleWedding;

  /// No description provided for @screenTitleFestival.
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get screenTitleFestival;

  /// No description provided for @actionNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get actionNext;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get actionApply;

  /// No description provided for @actionGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get actionGetStarted;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get actionLogout;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionLink.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get actionLink;

  /// No description provided for @actionUnlink.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get actionUnlink;

  /// No description provided for @headerAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get headerAccount;

  /// No description provided for @headerPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get headerPreferences;

  /// No description provided for @headerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get headerPrivacy;

  /// No description provided for @headerDataSync.
  ///
  /// In en, this message translates to:
  /// **'Data & Sync'**
  String get headerDataSync;

  /// No description provided for @headerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get headerNotifications;

  /// No description provided for @headerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get headerAbout;

  /// No description provided for @headerAchievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get headerAchievements;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorNetwork;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Please check your inputs.'**
  String get errorValidation;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning!'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon!'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening!'**
  String get greetingEvening;

  /// No description provided for @greetingNamaste.
  ///
  /// In en, this message translates to:
  /// **'Namaste'**
  String get greetingNamaste;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to FitKarma'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your journey to holistic health starts here.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingStepGoal.
  ///
  /// In en, this message translates to:
  /// **'Your Goal'**
  String get onboardingStepGoal;

  /// No description provided for @onboardingStepAbout.
  ///
  /// In en, this message translates to:
  /// **'About You'**
  String get onboardingStepAbout;

  /// No description provided for @onboardingStepDosha.
  ///
  /// In en, this message translates to:
  /// **'Discover your Nature'**
  String get onboardingStepDosha;

  /// No description provided for @onboardingStepLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get onboardingStepLanguage;

  /// No description provided for @onboardingStepConnections.
  ///
  /// In en, this message translates to:
  /// **'Connect Health ID'**
  String get onboardingStepConnections;

  /// No description provided for @insightCalorieGoal.
  ///
  /// In en, this message translates to:
  /// **'Your daily calorie goal is {goal} kcal.'**
  String insightCalorieGoal(int goal);

  /// No description provided for @stepsToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Steps'**
  String get stepsToday;

  /// No description provided for @stepsGoal.
  ///
  /// In en, this message translates to:
  /// **'Step Goal'**
  String get stepsGoal;

  /// No description provided for @stepsDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get stepsDistance;

  /// No description provided for @stepsCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories Burned'**
  String get stepsCalories;

  /// No description provided for @foodCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get foodCalories;

  /// No description provided for @foodProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get foodProtein;

  /// No description provided for @foodCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get foodCarbs;

  /// No description provided for @foodFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get foodFat;

  /// No description provided for @foodSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search food...'**
  String get foodSearchPlaceholder;

  /// No description provided for @foodLogMeal.
  ///
  /// In en, this message translates to:
  /// **'Log Meal'**
  String get foodLogMeal;

  /// No description provided for @sleepDuration.
  ///
  /// In en, this message translates to:
  /// **'Sleep Duration'**
  String get sleepDuration;

  /// No description provided for @sleepQuality.
  ///
  /// In en, this message translates to:
  /// **'Sleep Quality'**
  String get sleepQuality;

  /// No description provided for @sleepDebt.
  ///
  /// In en, this message translates to:
  /// **'Sleep Debt'**
  String get sleepDebt;

  /// No description provided for @bpSystolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get bpSystolic;

  /// No description provided for @bpDiastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get bpDiastolic;

  /// No description provided for @bpPulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get bpPulse;

  /// No description provided for @glucoseFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get glucoseFasting;

  /// No description provided for @glucosePostMeal.
  ///
  /// In en, this message translates to:
  /// **'Post Meal'**
  String get glucosePostMeal;

  /// No description provided for @glucoseRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get glucoseRandom;

  /// No description provided for @karmaTotalXP.
  ///
  /// In en, this message translates to:
  /// **'Total XP'**
  String get karmaTotalXP;

  /// No description provided for @karmaLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get karmaLevel;

  /// No description provided for @karmaNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get karmaNextLevel;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLowDataMode.
  ///
  /// In en, this message translates to:
  /// **'Low Data Mode'**
  String get settingsLowDataMode;

  /// No description provided for @settingsSyncInterval.
  ///
  /// In en, this message translates to:
  /// **'Sync Interval'**
  String get settingsSyncInterval;

  /// No description provided for @settingsBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric Lock'**
  String get settingsBiometric;

  /// No description provided for @settingsExportData.
  ///
  /// In en, this message translates to:
  /// **'Export My Data'**
  String get settingsExportData;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full FitKarma'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionMonthly;

  /// No description provided for @subscriptionQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get subscriptionQuarterly;

  /// No description provided for @subscriptionYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscriptionYearly;

  /// No description provided for @subscriptionFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get subscriptionFamily;

  /// No description provided for @subscriptionPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get subscriptionPopular;

  /// No description provided for @subscriptionBestValue.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get subscriptionBestValue;

  /// No description provided for @subscriptionRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get subscriptionRestore;

  /// No description provided for @subscriptionTrial.
  ///
  /// In en, this message translates to:
  /// **'7-day free trial, cancel anytime'**
  String get subscriptionTrial;

  /// No description provided for @emergencyBloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get emergencyBloodGroup;

  /// No description provided for @emergencyAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get emergencyAllergies;

  /// No description provided for @emergencyMedications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get emergencyMedications;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @emergencyDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get emergencyDoctor;

  /// No description provided for @festDiwali.
  ///
  /// In en, this message translates to:
  /// **'Diwali'**
  String get festDiwali;

  /// No description provided for @festHoli.
  ///
  /// In en, this message translates to:
  /// **'Holi'**
  String get festHoli;

  /// No description provided for @festEid.
  ///
  /// In en, this message translates to:
  /// **'Eid-ul-Fitr'**
  String get festEid;

  /// No description provided for @festChristmas.
  ///
  /// In en, this message translates to:
  /// **'Christmas'**
  String get festChristmas;

  /// No description provided for @festRakshaBandhan.
  ///
  /// In en, this message translates to:
  /// **'Raksha Bandhan'**
  String get festRakshaBandhan;

  /// No description provided for @festGaneshChaturthi.
  ///
  /// In en, this message translates to:
  /// **'Ganesh Chaturthi'**
  String get festGaneshChaturthi;

  /// No description provided for @festNavratri.
  ///
  /// In en, this message translates to:
  /// **'Navratri'**
  String get festNavratri;

  /// No description provided for @festDurgaPuja.
  ///
  /// In en, this message translates to:
  /// **'Durga Puja'**
  String get festDurgaPuja;

  /// No description provided for @festJanmashtami.
  ///
  /// In en, this message translates to:
  /// **'Janmashtami'**
  String get festJanmashtami;

  /// No description provided for @festBaisakhi.
  ///
  /// In en, this message translates to:
  /// **'Baisakhi'**
  String get festBaisakhi;

  /// No description provided for @festPongal.
  ///
  /// In en, this message translates to:
  /// **'Pongal'**
  String get festPongal;

  /// No description provided for @festOnam.
  ///
  /// In en, this message translates to:
  /// **'Onam'**
  String get festOnam;

  /// No description provided for @festLohri.
  ///
  /// In en, this message translates to:
  /// **'Lohri'**
  String get festLohri;

  /// No description provided for @festMahaShivratri.
  ///
  /// In en, this message translates to:
  /// **'Maha Shivratri'**
  String get festMahaShivratri;

  /// No description provided for @festKarwaChauth.
  ///
  /// In en, this message translates to:
  /// **'Karwa Chauth'**
  String get festKarwaChauth;

  /// No description provided for @festBhaidooj.
  ///
  /// In en, this message translates to:
  /// **'Bhai Dooj'**
  String get festBhaidooj;

  /// No description provided for @wedHaldi.
  ///
  /// In en, this message translates to:
  /// **'Haldi'**
  String get wedHaldi;

  /// No description provided for @wedMehendi.
  ///
  /// In en, this message translates to:
  /// **'Mehendi'**
  String get wedMehendi;

  /// No description provided for @wedSangeet.
  ///
  /// In en, this message translates to:
  /// **'Sangeet'**
  String get wedSangeet;

  /// No description provided for @wedBaraat.
  ///
  /// In en, this message translates to:
  /// **'Baraat'**
  String get wedBaraat;

  /// No description provided for @wedVivah.
  ///
  /// In en, this message translates to:
  /// **'Vivah'**
  String get wedVivah;

  /// No description provided for @wedReception.
  ///
  /// In en, this message translates to:
  /// **'Reception'**
  String get wedReception;

  /// No description provided for @wedRoleBride.
  ///
  /// In en, this message translates to:
  /// **'Bride'**
  String get wedRoleBride;

  /// No description provided for @wedRoleGroom.
  ///
  /// In en, this message translates to:
  /// **'Groom'**
  String get wedRoleGroom;

  /// No description provided for @wedRoleGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get wedRoleGuest;

  /// No description provided for @wedRoleRelative.
  ///
  /// In en, this message translates to:
  /// **'Relative'**
  String get wedRoleRelative;

  /// No description provided for @doshaVata.
  ///
  /// In en, this message translates to:
  /// **'Vata'**
  String get doshaVata;

  /// No description provided for @doshaPitta.
  ///
  /// In en, this message translates to:
  /// **'Pitta'**
  String get doshaPitta;

  /// No description provided for @doshaKapha.
  ///
  /// In en, this message translates to:
  /// **'Kapha'**
  String get doshaKapha;

  /// No description provided for @labelMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get labelMale;

  /// No description provided for @labelFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get labelFemale;

  /// No description provided for @labelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get labelOther;

  /// No description provided for @labelLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked'**
  String get labelLinked;

  /// No description provided for @labelUnlinked.
  ///
  /// In en, this message translates to:
  /// **'Unlinked'**
  String get labelUnlinked;

  /// No description provided for @labelNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get labelNormal;

  /// No description provided for @labelHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get labelHigh;

  /// No description provided for @labelLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get labelLow;

  /// No description provided for @labelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get labelConfirm;

  /// No description provided for @labelEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get labelEdit;

  /// No description provided for @labelViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get labelViewAll;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'as',
    'bn',
    'brx',
    'doi',
    'en',
    'gu',
    'hi',
    'kn',
    'kok',
    'ks',
    'mai',
    'ml',
    'mni',
    'mr',
    'ne',
    'or',
    'pa',
    'sa',
    'sat',
    'sd',
    'ta',
    'te',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'as':
      return AppLocalizationsAs();
    case 'bn':
      return AppLocalizationsBn();
    case 'brx':
      return AppLocalizationsBrx();
    case 'doi':
      return AppLocalizationsDoi();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'kok':
      return AppLocalizationsKok();
    case 'ks':
      return AppLocalizationsKs();
    case 'mai':
      return AppLocalizationsMai();
    case 'ml':
      return AppLocalizationsMl();
    case 'mni':
      return AppLocalizationsMni();
    case 'mr':
      return AppLocalizationsMr();
    case 'ne':
      return AppLocalizationsNe();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
    case 'sa':
      return AppLocalizationsSa();
    case 'sat':
      return AppLocalizationsSat();
    case 'sd':
      return AppLocalizationsSd();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
