import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

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
    Locale('de'),
    Locale('en'),
  ];

  /// Titel of the app
  ///
  /// In en, this message translates to:
  /// **'Weather App'**
  String get title;

  /// Details about the weather
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Temperature in degrees Celsius
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// Humidity percentage
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// Atmospheric pressure in hPa
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @dewPoint.
  ///
  /// In en, this message translates to:
  /// **'Dew Point'**
  String get dewPoint;

  /// Visibility in km
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// Hourly weather forecast
  ///
  /// In en, this message translates to:
  /// **'Hourly Forecast'**
  String get hourly;

  /// Temperature forecast for the next days
  ///
  /// In en, this message translates to:
  /// **'Daily Temperature Forecast'**
  String get dailyTemp;

  /// Precipitation forecast for the next days
  ///
  /// In en, this message translates to:
  /// **'Daily Precipitation Forecast'**
  String get dailyPrecipitation;

  /// title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Header for the theme color selection
  ///
  /// In en, this message translates to:
  /// **'Design Color'**
  String get themeColor;

  /// Description for the theme color selection
  ///
  /// In en, this message translates to:
  /// **'Choose a color for the app design'**
  String get themeColorDescription;

  /// Header for the theme mode selection
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Use the system's default theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// Light theme for the app
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// Dark theme for the app
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// Header for the color mode selection
  ///
  /// In en, this message translates to:
  /// **'Color Mode'**
  String get colorMode;

  /// Seed color for the color mode
  ///
  /// In en, this message translates to:
  /// **'Seed Color'**
  String get colorModeSeed;

  /// Individual color for the color mode
  ///
  /// In en, this message translates to:
  /// **'Individual Color'**
  String get colorModeIndividual;

  /// Header for the individual color mode selection
  ///
  /// In en, this message translates to:
  /// **'Individual Color Mode'**
  String get individualColorMode;

  /// Description for the individual color mode selection
  ///
  /// In en, this message translates to:
  /// **'Select a custom color for each element in the app.'**
  String get individualColorModeDescription;

  /// Header for the primary color selection
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColor;

  /// Header for the on primary color selection
  ///
  /// In en, this message translates to:
  /// **'On Primary Color'**
  String get onPrimaryColor;

  /// Header for the secondary color selection
  ///
  /// In en, this message translates to:
  /// **'Secondary Color'**
  String get secondaryColor;

  /// Header for the on secondary color selection
  ///
  /// In en, this message translates to:
  /// **'On Secondary Color'**
  String get onSecondaryColor;

  /// Header for the surface color selection
  ///
  /// In en, this message translates to:
  /// **'Surface Color'**
  String get surfaceColor;

  /// Header for the on surface color selection
  ///
  /// In en, this message translates to:
  /// **'On Surface Color'**
  String get onSurfaceColor;

  /// Header for the error color selection
  ///
  /// In en, this message translates to:
  /// **'Error Color'**
  String get errorColor;

  /// Header for the on error color selection
  ///
  /// In en, this message translates to:
  /// **'On Error Color'**
  String get onErrorColor;

  /// Header for the theme selection
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Error message displayed when something goes wrong
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Description for the pull down to refresh action
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh the weather data.'**
  String get pullDownToRefresh;

  /// Description for the no weather data message
  ///
  /// In en, this message translates to:
  /// **'No weather data available.'**
  String get noWeatherDataAvail;

  /// Description for the weather data refresh failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh weather data.'**
  String get weatherDataRefreshFailed;

  /// Description for the cloud cover
  ///
  /// In en, this message translates to:
  /// **'Cloud Cover'**
  String get cloudCover;

  /// Description for the precipitation
  ///
  /// In en, this message translates to:
  /// **'Precipitation'**
  String get precipitation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
