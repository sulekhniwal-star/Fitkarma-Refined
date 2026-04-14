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

  /// No description provided for @screenTitleYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga & Mindfulness'**
  String get screenTitleYoga;

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

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to FitKarma'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Modern science meets ancient wisdom.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingStepDosha.
  ///
  /// In en, this message translates to:
  /// **'Discover your Nature'**
  String get onboardingStepDosha;

  /// No description provided for @onboardingStepLanguage.
  ///
  /// In en, this message translates to:
  /// **'Your Health, Your Language'**
  String get onboardingStepLanguage;

  /// No description provided for @insightCalorieGoal.
  ///
  /// In en, this message translates to:
  /// **'Your daily calorie goal is {goal} kcal.'**
  String insightCalorieGoal(int goal);

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
