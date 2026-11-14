import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'PointagePro'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In fr, this message translates to:
  /// **'Pointage simple et professionnel par QR code'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navScanner.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get navScanner;

  /// No description provided for @navEmployees.
  ///
  /// In fr, this message translates to:
  /// **'Employés'**
  String get navEmployees;

  /// No description provided for @navReports.
  ///
  /// In fr, this message translates to:
  /// **'Rapports'**
  String get navReports;

  /// No description provided for @navSettings.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get navSettings;

  /// No description provided for @commonSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get commonAdd;

  /// No description provided for @commonClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get commonClose;

  /// No description provided for @commonConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get commonConfirm;

  /// No description provided for @commonSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get commonSearch;

  /// No description provided for @commonRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get commonRetry;

  /// No description provided for @commonError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get commonError;

  /// No description provided for @commonLoading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement…'**
  String get commonLoading;

  /// No description provided for @commonNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get commonNone;

  /// No description provided for @commonAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get commonAll;

  /// No description provided for @commonToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get commonToday;

  /// No description provided for @commonWeek.
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get commonWeek;

  /// No description provided for @commonMonth.
  ///
  /// In fr, this message translates to:
  /// **'Mois'**
  String get commonMonth;

  /// No description provided for @commonQuarter.
  ///
  /// In fr, this message translates to:
  /// **'Trimestre'**
  String get commonQuarter;

  /// No description provided for @commonYear.
  ///
  /// In fr, this message translates to:
  /// **'Année'**
  String get commonYear;

  /// No description provided for @commonCustom.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisé'**
  String get commonCustom;

  /// No description provided for @commonFrom.
  ///
  /// In fr, this message translates to:
  /// **'Du'**
  String get commonFrom;

  /// No description provided for @commonTo.
  ///
  /// In fr, this message translates to:
  /// **'Au'**
  String get commonTo;

  /// No description provided for @commonApply.
  ///
  /// In fr, this message translates to:
  /// **'Appliquer'**
  String get commonApply;

  /// No description provided for @commonReset.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser'**
  String get commonReset;

  /// No description provided for @commonShare.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get commonShare;

  /// No description provided for @commonPrint.
  ///
  /// In fr, this message translates to:
  /// **'Imprimer'**
  String get commonPrint;

  /// No description provided for @commonExport.
  ///
  /// In fr, this message translates to:
  /// **'Exporter'**
  String get commonExport;

  /// No description provided for @commonRefresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser'**
  String get commonRefresh;

  /// No description provided for @commonBack.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get commonBack;

  /// No description provided for @commonNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get commonNext;

  /// No description provided for @commonFinish.
  ///
  /// In fr, this message translates to:
  /// **'Terminer'**
  String get commonFinish;

  /// No description provided for @commonSkip.
  ///
  /// In fr, this message translates to:
  /// **'Passer'**
  String get commonSkip;

  /// No description provided for @commonYes.
  ///
  /// In fr, this message translates to:
  /// **'Oui'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get commonNo;

  /// No description provided for @commonOptional.
  ///
  /// In fr, this message translates to:
  /// **'Facultatif'**
  String get commonOptional;

  /// No description provided for @commonRequired.
  ///
  /// In fr, this message translates to:
  /// **'Obligatoire'**
  String get commonRequired;

  /// No description provided for @commonUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Inconnu'**
  String get commonUnknown;

  /// No description provided for @commonNoData.
  ///
  /// In fr, this message translates to:
  /// **'Aucune donnée'**
  String get commonNoData;

  /// No description provided for @commonSeeAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout voir'**
  String get commonSeeAll;

  /// No description provided for @commonDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails'**
  String get commonDetails;

  /// No description provided for @commonArchived.
  ///
  /// In fr, this message translates to:
  /// **'Archivé'**
  String get commonArchived;

  /// No description provided for @commonActive.
  ///
  /// In fr, this message translates to:
  /// **'Actif'**
  String get commonActive;

  /// No description provided for @commonActions.
  ///
  /// In fr, this message translates to:
  /// **'Actions'**
  String get commonActions;

  /// No description provided for @commonOk.
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get commonDone;

  /// No description provided for @commonVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get commonVersion;

  /// No description provided for @commonErrorGeneric.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Veuillez réessayer.'**
  String get commonErrorGeneric;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue sur PointagePro'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In fr, this message translates to:
  /// **'Scannez les badges QR de vos employés pour enregistrer les arrivées et départs, puis consultez des rapports clairs et professionnels.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingCompanyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre entreprise'**
  String get onboardingCompanyTitle;

  /// No description provided for @onboardingCompanyName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'entreprise'**
  String get onboardingCompanyName;

  /// No description provided for @onboardingCompanyNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. : Atelier Horizon'**
  String get onboardingCompanyNameHint;

  /// No description provided for @onboardingCompanyLogo.
  ///
  /// In fr, this message translates to:
  /// **'Logo de l\'entreprise'**
  String get onboardingCompanyLogo;

  /// No description provided for @onboardingPickLogo.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un logo'**
  String get onboardingPickLogo;

  /// No description provided for @onboardingRemoveLogo.
  ///
  /// In fr, this message translates to:
  /// **'Retirer le logo'**
  String get onboardingRemoveLogo;

  /// No description provided for @onboardingThemeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre style'**
  String get onboardingThemeTitle;

  /// No description provided for @onboardingThemeBody.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez la couleur principale de l\'application.'**
  String get onboardingThemeBody;

  /// No description provided for @onboardingScheduleTitle.
  ///
  /// In fr, this message translates to:
  /// **'Horaires de travail'**
  String get onboardingScheduleTitle;

  /// No description provided for @onboardingScheduleBody.
  ///
  /// In fr, this message translates to:
  /// **'Ces réglages s\'appliquent à tous les employés, sauf horaire personnalisé.'**
  String get onboardingScheduleBody;

  /// No description provided for @onboardingSecurityTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get onboardingSecurityTitle;

  /// No description provided for @onboardingSecurityBody.
  ///
  /// In fr, this message translates to:
  /// **'Protégez l\'accès aux données de pointage.'**
  String get onboardingSecurityBody;

  /// No description provided for @onboardingEnablePin.
  ///
  /// In fr, this message translates to:
  /// **'Activer un code PIN'**
  String get onboardingEnablePin;

  /// No description provided for @onboardingPin.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN (4 à 6 chiffres)'**
  String get onboardingPin;

  /// No description provided for @onboardingConfirmPin.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le code PIN'**
  String get onboardingConfirmPin;

  /// No description provided for @onboardingPinMismatch.
  ///
  /// In fr, this message translates to:
  /// **'Les codes PIN ne correspondent pas.'**
  String get onboardingPinMismatch;

  /// No description provided for @onboardingPinInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Le code PIN doit contenir 4 à 6 chiffres.'**
  String get onboardingPinInvalid;

  /// No description provided for @onboardingBiometric.
  ///
  /// In fr, this message translates to:
  /// **'Déverrouillage biométrique'**
  String get onboardingBiometric;

  /// No description provided for @onboardingBiometricUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'La biométrie n\'est pas disponible sur cet appareil.'**
  String get onboardingBiometricUnavailable;

  /// No description provided for @onboardingDone.
  ///
  /// In fr, this message translates to:
  /// **'PointagePro est prêt'**
  String get onboardingDone;

  /// No description provided for @onboardingCompanyRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom de l\'entreprise est obligatoire.'**
  String get onboardingCompanyRequired;

  /// No description provided for @onboardingPinRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez et confirmez un code PIN valide.'**
  String get onboardingPinRequired;

  /// No description provided for @dashboardGreeting.
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get dashboardGreeting;

  /// No description provided for @dashboardPresent.
  ///
  /// In fr, this message translates to:
  /// **'Présents'**
  String get dashboardPresent;

  /// No description provided for @dashboardLate.
  ///
  /// In fr, this message translates to:
  /// **'En retard'**
  String get dashboardLate;

  /// No description provided for @dashboardAbsent.
  ///
  /// In fr, this message translates to:
  /// **'Absents'**
  String get dashboardAbsent;

  /// No description provided for @dashboardNotYet.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore arrivés'**
  String get dashboardNotYet;

  /// No description provided for @dashboardAttendanceRate.
  ///
  /// In fr, this message translates to:
  /// **'Taux de présence'**
  String get dashboardAttendanceRate;

  /// No description provided for @dashboardQuickScan.
  ///
  /// In fr, this message translates to:
  /// **'Scanner un badge'**
  String get dashboardQuickScan;

  /// No description provided for @dashboardWhoIsIn.
  ///
  /// In fr, this message translates to:
  /// **'Actuellement sur site'**
  String get dashboardWhoIsIn;

  /// No description provided for @dashboardRecentScans.
  ///
  /// In fr, this message translates to:
  /// **'Scans récents'**
  String get dashboardRecentScans;

  /// No description provided for @dashboardWeekly.
  ///
  /// In fr, this message translates to:
  /// **'Activité des 7 derniers jours'**
  String get dashboardWeekly;

  /// No description provided for @dashboardAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Alertes'**
  String get dashboardAlerts;

  /// No description provided for @dashboardNoEmployeesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez votre premier employé'**
  String get dashboardNoEmployeesTitle;

  /// No description provided for @dashboardNoEmployeesBody.
  ///
  /// In fr, this message translates to:
  /// **'Créez une fiche employé pour générer son badge QR et commencer le pointage.'**
  String get dashboardNoEmployeesBody;

  /// No description provided for @dashboardNoScans.
  ///
  /// In fr, this message translates to:
  /// **'Aucun scan enregistré aujourd\'hui.'**
  String get dashboardNoScans;

  /// No description provided for @dashboardInAt.
  ///
  /// In fr, this message translates to:
  /// **'Arrivée'**
  String get dashboardInAt;

  /// No description provided for @dashboardOutAt.
  ///
  /// In fr, this message translates to:
  /// **'Départ'**
  String get dashboardOutAt;

  /// No description provided for @dashboardSince.
  ///
  /// In fr, this message translates to:
  /// **'Depuis'**
  String get dashboardSince;

  /// No description provided for @dashboardNotClockedOut.
  ///
  /// In fr, this message translates to:
  /// **'Départ non pointé'**
  String get dashboardNotClockedOut;

  /// No description provided for @dashboardRepeatedLateness.
  ///
  /// In fr, this message translates to:
  /// **'Retards répétés'**
  String get dashboardRepeatedLateness;

  /// No description provided for @dashboardUnjustifiedAbsences.
  ///
  /// In fr, this message translates to:
  /// **'Absences non justifiées'**
  String get dashboardUnjustifiedAbsences;

  /// No description provided for @dashboardNoAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Aucune alerte. Tout est en ordre.'**
  String get dashboardNoAlerts;

  /// No description provided for @scannerTitle.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get scannerTitle;

  /// No description provided for @scannerHint.
  ///
  /// In fr, this message translates to:
  /// **'Placez le badge QR dans le cadre'**
  String get scannerHint;

  /// No description provided for @scannerFlash.
  ///
  /// In fr, this message translates to:
  /// **'Torche'**
  String get scannerFlash;

  /// No description provided for @scannerSwitchCamera.
  ///
  /// In fr, this message translates to:
  /// **'Changer de caméra'**
  String get scannerSwitchCamera;

  /// No description provided for @scannerPermissionTitle.
  ///
  /// In fr, this message translates to:
  /// **'Accès à la caméra requis'**
  String get scannerPermissionTitle;

  /// No description provided for @scannerPermissionBody.
  ///
  /// In fr, this message translates to:
  /// **'Autorisez l\'accès à la caméra dans les réglages Android pour scanner les badges.'**
  String get scannerPermissionBody;

  /// No description provided for @scannerOpenSettings.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir les réglages'**
  String get scannerOpenSettings;

  /// No description provided for @scannerInvalidQr.
  ///
  /// In fr, this message translates to:
  /// **'QR code invalide ou falsifié'**
  String get scannerInvalidQr;

  /// No description provided for @scannerUnknownBadge.
  ///
  /// In fr, this message translates to:
  /// **'Badge inconnu'**
  String get scannerUnknownBadge;

  /// No description provided for @scannerArchivedBadge.
  ///
  /// In fr, this message translates to:
  /// **'Badge d\'un employé archivé'**
  String get scannerArchivedBadge;

  /// No description provided for @scannerOutdatedBadge.
  ///
  /// In fr, this message translates to:
  /// **'Badge obsolète — régénérez-le'**
  String get scannerOutdatedBadge;

  /// No description provided for @scannerScanAgain.
  ///
  /// In fr, this message translates to:
  /// **'Scanner à nouveau'**
  String get scannerScanAgain;

  /// No description provided for @scannerDuplicate.
  ///
  /// In fr, this message translates to:
  /// **'Scan ignoré : déjà pointé à l\'instant'**
  String get scannerDuplicate;

  /// No description provided for @scannerCheckoutUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Départ mis à jour'**
  String get scannerCheckoutUpdated;

  /// No description provided for @scannerAlreadyClockedOut.
  ///
  /// In fr, this message translates to:
  /// **'Pointage déjà complet pour aujourd\'hui'**
  String get scannerAlreadyClockedOut;

  /// No description provided for @scannerCheckInSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Arrivée enregistrée'**
  String get scannerCheckInSuccess;

  /// No description provided for @scannerCheckOutSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Départ enregistré'**
  String get scannerCheckOutSuccess;

  /// No description provided for @scannerLateArrival.
  ///
  /// In fr, this message translates to:
  /// **'Arrivée tardive'**
  String get scannerLateArrival;

  /// No description provided for @scannerOnTime.
  ///
  /// In fr, this message translates to:
  /// **'À l\'heure'**
  String get scannerOnTime;

  /// No description provided for @scannerManualBlocked.
  ///
  /// In fr, this message translates to:
  /// **'Journée verrouillée par une correction manuelle'**
  String get scannerManualBlocked;

  /// No description provided for @scannerError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de traiter ce badge'**
  String get scannerError;

  /// No description provided for @scannerTip.
  ///
  /// In fr, this message translates to:
  /// **'Le scan reste actif : présentez les badges les uns après les autres.'**
  String get scannerTip;

  /// No description provided for @employeesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Employés'**
  String get employeesTitle;

  /// No description provided for @employeesAdd.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel employé'**
  String get employeesAdd;

  /// No description provided for @employeesEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'employé'**
  String get employeesEdit;

  /// No description provided for @employeesFirstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get employeesFirstName;

  /// No description provided for @employeesLastName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get employeesLastName;

  /// No description provided for @employeesMatricule.
  ///
  /// In fr, this message translates to:
  /// **'Matricule'**
  String get employeesMatricule;

  /// No description provided for @employeesPosition.
  ///
  /// In fr, this message translates to:
  /// **'Poste'**
  String get employeesPosition;

  /// No description provided for @employeesDepartment.
  ///
  /// In fr, this message translates to:
  /// **'Département'**
  String get employeesDepartment;

  /// No description provided for @employeesPhone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get employeesPhone;

  /// No description provided for @employeesHireDate.
  ///
  /// In fr, this message translates to:
  /// **'Date d\'embauche'**
  String get employeesHireDate;

  /// No description provided for @employeesPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Photo'**
  String get employeesPhoto;

  /// No description provided for @employeesTakePhoto.
  ///
  /// In fr, this message translates to:
  /// **'Prendre une photo'**
  String get employeesTakePhoto;

  /// No description provided for @employeesGallery.
  ///
  /// In fr, this message translates to:
  /// **'Choisir dans la galerie'**
  String get employeesGallery;

  /// No description provided for @employeesCustomSchedule.
  ///
  /// In fr, this message translates to:
  /// **'Horaire personnalisé'**
  String get employeesCustomSchedule;

  /// No description provided for @employeesUseCustomSchedule.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser un horaire propre à cet employé'**
  String get employeesUseCustomSchedule;

  /// No description provided for @employeesSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un nom, un matricule…'**
  String get employeesSearch;

  /// No description provided for @employeesFilter.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer'**
  String get employeesFilter;

  /// No description provided for @employeesSort.
  ///
  /// In fr, this message translates to:
  /// **'Trier'**
  String get employeesSort;

  /// No description provided for @employeesSortName.
  ///
  /// In fr, this message translates to:
  /// **'Nom (A–Z)'**
  String get employeesSortName;

  /// No description provided for @employeesSortRecent.
  ///
  /// In fr, this message translates to:
  /// **'Ajout récent'**
  String get employeesSortRecent;

  /// No description provided for @employeesSortDepartment.
  ///
  /// In fr, this message translates to:
  /// **'Département'**
  String get employeesSortDepartment;

  /// No description provided for @employeesDetail.
  ///
  /// In fr, this message translates to:
  /// **'Fiche employé'**
  String get employeesDetail;

  /// No description provided for @employeesArchive.
  ///
  /// In fr, this message translates to:
  /// **'Archiver'**
  String get employeesArchive;

  /// No description provided for @employeesArchiveConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Archiver cet employé ? Son historique sera conservé.'**
  String get employeesArchiveConfirm;

  /// No description provided for @employeesUnarchive.
  ///
  /// In fr, this message translates to:
  /// **'Réactiver'**
  String get employeesUnarchive;

  /// No description provided for @employeesDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer définitivement'**
  String get employeesDelete;

  /// No description provided for @employeesDeleteConfirm1.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cet employé et tout son historique ?'**
  String get employeesDeleteConfirm1;

  /// No description provided for @employeesDeleteConfirm2.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible. Confirmez la suppression définitive.'**
  String get employeesDeleteConfirm2;

  /// No description provided for @employeesDeleteWarning.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les pointages, badges et corrections de cet employé seront supprimés.'**
  String get employeesDeleteWarning;

  /// No description provided for @employeesPersonalInfo.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get employeesPersonalInfo;

  /// No description provided for @employeesSchedule.
  ///
  /// In fr, this message translates to:
  /// **'Horaire'**
  String get employeesSchedule;

  /// No description provided for @employeesSummary.
  ///
  /// In fr, this message translates to:
  /// **'Résumé de présence'**
  String get employeesSummary;

  /// No description provided for @employeesBadges.
  ///
  /// In fr, this message translates to:
  /// **'Badges'**
  String get employeesBadges;

  /// No description provided for @employeesEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun employé'**
  String get employeesEmptyTitle;

  /// No description provided for @employeesEmptyBody.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez un employé pour générer son badge QR.'**
  String get employeesEmptyBody;

  /// No description provided for @employeesNoResults.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat pour cette recherche.'**
  String get employeesNoResults;

  /// No description provided for @employeesRequiredField.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ est obligatoire.'**
  String get employeesRequiredField;

  /// No description provided for @employeesSaved.
  ///
  /// In fr, this message translates to:
  /// **'Employé enregistré'**
  String get employeesSaved;

  /// No description provided for @employeesArchived.
  ///
  /// In fr, this message translates to:
  /// **'Employé archivé'**
  String get employeesArchived;

  /// No description provided for @employeesDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Employé supprimé'**
  String get employeesDeleted;

  /// No description provided for @employeesShowArchived.
  ///
  /// In fr, this message translates to:
  /// **'Afficher les archivés'**
  String get employeesShowArchived;

  /// No description provided for @badgesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Badges'**
  String get badgesTitle;

  /// No description provided for @badgesBadge.
  ///
  /// In fr, this message translates to:
  /// **'Badge QR'**
  String get badgesBadge;

  /// No description provided for @badgesView.
  ///
  /// In fr, this message translates to:
  /// **'Voir le badge'**
  String get badgesView;

  /// No description provided for @badgesPrint.
  ///
  /// In fr, this message translates to:
  /// **'Imprimer'**
  String get badgesPrint;

  /// No description provided for @badgesShare.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get badgesShare;

  /// No description provided for @badgesRegenerate.
  ///
  /// In fr, this message translates to:
  /// **'Régénérer'**
  String get badgesRegenerate;

  /// No description provided for @badgesRegenerateConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Régénérer ce badge ? L\'ancien badge ne fonctionnera plus.'**
  String get badgesRegenerateConfirm;

  /// No description provided for @badgesRegenerated.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau badge généré'**
  String get badgesRegenerated;

  /// No description provided for @badgesFormat.
  ///
  /// In fr, this message translates to:
  /// **'Format'**
  String get badgesFormat;

  /// No description provided for @badgesCardSize.
  ///
  /// In fr, this message translates to:
  /// **'Carte'**
  String get badgesCardSize;

  /// No description provided for @badgesA6.
  ///
  /// In fr, this message translates to:
  /// **'A6'**
  String get badgesA6;

  /// No description provided for @badgesMultiple.
  ///
  /// In fr, this message translates to:
  /// **'Plusieurs par page'**
  String get badgesMultiple;

  /// No description provided for @badgesPrintAll.
  ///
  /// In fr, this message translates to:
  /// **'Imprimer tous les badges'**
  String get badgesPrintAll;

  /// No description provided for @badgesShareAll.
  ///
  /// In fr, this message translates to:
  /// **'Partager tous les badges'**
  String get badgesShareAll;

  /// No description provided for @badgesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun badge à afficher'**
  String get badgesEmpty;

  /// No description provided for @badgesPreview.
  ///
  /// In fr, this message translates to:
  /// **'Aperçu du badge'**
  String get badgesPreview;

  /// No description provided for @badgesSingle.
  ///
  /// In fr, this message translates to:
  /// **'Un seul badge'**
  String get badgesSingle;

  /// No description provided for @badgesAllActive.
  ///
  /// In fr, this message translates to:
  /// **'Tous les employés actifs'**
  String get badgesAllActive;

  /// No description provided for @attendanceTitle.
  ///
  /// In fr, this message translates to:
  /// **'Pointages'**
  String get attendanceTitle;

  /// No description provided for @attendanceHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get attendanceHistory;

  /// No description provided for @attendanceDay.
  ///
  /// In fr, this message translates to:
  /// **'Jour'**
  String get attendanceDay;

  /// No description provided for @attendanceWeek.
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get attendanceWeek;

  /// No description provided for @attendanceMonth.
  ///
  /// In fr, this message translates to:
  /// **'Mois'**
  String get attendanceMonth;

  /// No description provided for @attendanceCalendar.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier'**
  String get attendanceCalendar;

  /// No description provided for @attendanceFilters.
  ///
  /// In fr, this message translates to:
  /// **'Filtres'**
  String get attendanceFilters;

  /// No description provided for @attendanceStatus.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get attendanceStatus;

  /// No description provided for @attendanceManualEntry.
  ///
  /// In fr, this message translates to:
  /// **'Correction manuelle'**
  String get attendanceManualEntry;

  /// No description provided for @attendanceAddRecord.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un pointage'**
  String get attendanceAddRecord;

  /// No description provided for @attendanceEditRecord.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le pointage'**
  String get attendanceEditRecord;

  /// No description provided for @attendanceDeleteRecord.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le pointage'**
  String get attendanceDeleteRecord;

  /// No description provided for @attendanceCheckIn.
  ///
  /// In fr, this message translates to:
  /// **'Heure d\'arrivée'**
  String get attendanceCheckIn;

  /// No description provided for @attendanceCheckOut.
  ///
  /// In fr, this message translates to:
  /// **'Heure de départ'**
  String get attendanceCheckOut;

  /// No description provided for @attendanceNote.
  ///
  /// In fr, this message translates to:
  /// **'Note / justification'**
  String get attendanceNote;

  /// No description provided for @attendanceStatusPresent.
  ///
  /// In fr, this message translates to:
  /// **'Présent'**
  String get attendanceStatusPresent;

  /// No description provided for @attendanceStatusLate.
  ///
  /// In fr, this message translates to:
  /// **'En retard'**
  String get attendanceStatusLate;

  /// No description provided for @attendanceStatusAbsent.
  ///
  /// In fr, this message translates to:
  /// **'Absent'**
  String get attendanceStatusAbsent;

  /// No description provided for @attendanceStatusLeftEarly.
  ///
  /// In fr, this message translates to:
  /// **'Parti tôt'**
  String get attendanceStatusLeftEarly;

  /// No description provided for @attendanceStatusJustified.
  ///
  /// In fr, this message translates to:
  /// **'Absence justifiée'**
  String get attendanceStatusJustified;

  /// No description provided for @attendanceStatusLeave.
  ///
  /// In fr, this message translates to:
  /// **'Congé'**
  String get attendanceStatusLeave;

  /// No description provided for @attendanceStatusHoliday.
  ///
  /// In fr, this message translates to:
  /// **'Férié'**
  String get attendanceStatusHoliday;

  /// No description provided for @attendanceStatusNotYet.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore arrivé'**
  String get attendanceStatusNotYet;

  /// No description provided for @attendanceStatusDayOff.
  ///
  /// In fr, this message translates to:
  /// **'Repos'**
  String get attendanceStatusDayOff;

  /// No description provided for @attendanceMissingCheckout.
  ///
  /// In fr, this message translates to:
  /// **'Départ manquant'**
  String get attendanceMissingCheckout;

  /// No description provided for @attendanceSaved.
  ///
  /// In fr, this message translates to:
  /// **'Pointage enregistré'**
  String get attendanceSaved;

  /// No description provided for @attendanceDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Pointage supprimé'**
  String get attendanceDeleted;

  /// No description provided for @attendanceAudit.
  ///
  /// In fr, this message translates to:
  /// **'Journal des modifications'**
  String get attendanceAudit;

  /// No description provided for @attendancePreviousValue.
  ///
  /// In fr, this message translates to:
  /// **'Ancienne valeur'**
  String get attendancePreviousValue;

  /// No description provided for @attendanceNewValue.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle valeur'**
  String get attendanceNewValue;

  /// No description provided for @attendanceChangedAt.
  ///
  /// In fr, this message translates to:
  /// **'Modifié le'**
  String get attendanceChangedAt;

  /// No description provided for @attendanceNoRecords.
  ///
  /// In fr, this message translates to:
  /// **'Aucun pointage pour cette période.'**
  String get attendanceNoRecords;

  /// No description provided for @attendanceSelectEmployee.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un employé'**
  String get attendanceSelectEmployee;

  /// No description provided for @attendanceSelectDate.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une date'**
  String get attendanceSelectDate;

  /// No description provided for @attendanceWorkHours.
  ///
  /// In fr, this message translates to:
  /// **'Heures travaillées'**
  String get attendanceWorkHours;

  /// No description provided for @attendanceOvertime.
  ///
  /// In fr, this message translates to:
  /// **'Heures supplémentaires'**
  String get attendanceOvertime;

  /// No description provided for @attendanceLateMinutes.
  ///
  /// In fr, this message translates to:
  /// **'Minutes de retard'**
  String get attendanceLateMinutes;

  /// No description provided for @attendanceEarlyLeave.
  ///
  /// In fr, this message translates to:
  /// **'Départ anticipé'**
  String get attendanceEarlyLeave;

  /// No description provided for @attendanceNoTimes.
  ///
  /// In fr, this message translates to:
  /// **'Aucune heure saisie (statut manuel)'**
  String get attendanceNoTimes;

  /// No description provided for @reportsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Rapports'**
  String get reportsTitle;

  /// No description provided for @reportsGlobal.
  ///
  /// In fr, this message translates to:
  /// **'Rapport global'**
  String get reportsGlobal;

  /// No description provided for @reportsIndividual.
  ///
  /// In fr, this message translates to:
  /// **'Rapport individuel'**
  String get reportsIndividual;

  /// No description provided for @reportsPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Période'**
  String get reportsPeriod;

  /// No description provided for @reportsCompare.
  ///
  /// In fr, this message translates to:
  /// **'Comparer à la période précédente'**
  String get reportsCompare;

  /// No description provided for @reportsPresenceRate.
  ///
  /// In fr, this message translates to:
  /// **'Taux de présence'**
  String get reportsPresenceRate;

  /// No description provided for @reportsPunctualityRate.
  ///
  /// In fr, this message translates to:
  /// **'Taux de ponctualité'**
  String get reportsPunctualityRate;

  /// No description provided for @reportsAbsenceRate.
  ///
  /// In fr, this message translates to:
  /// **'Taux d\'absence'**
  String get reportsAbsenceRate;

  /// No description provided for @reportsTotalHours.
  ///
  /// In fr, this message translates to:
  /// **'Heures totales'**
  String get reportsTotalHours;

  /// No description provided for @reportsOvertimeHours.
  ///
  /// In fr, this message translates to:
  /// **'Heures supplémentaires'**
  String get reportsOvertimeHours;

  /// No description provided for @reportsAverageArrival.
  ///
  /// In fr, this message translates to:
  /// **'Arrivée moyenne'**
  String get reportsAverageArrival;

  /// No description provided for @reportsMostPunctual.
  ///
  /// In fr, this message translates to:
  /// **'Les plus ponctuels'**
  String get reportsMostPunctual;

  /// No description provided for @reportsLeastPunctual.
  ///
  /// In fr, this message translates to:
  /// **'Les moins ponctuels'**
  String get reportsLeastPunctual;

  /// No description provided for @reportsDepartmentComparison.
  ///
  /// In fr, this message translates to:
  /// **'Comparaison par département'**
  String get reportsDepartmentComparison;

  /// No description provided for @reportsHeatmap.
  ///
  /// In fr, this message translates to:
  /// **'Carte de présence'**
  String get reportsHeatmap;

  /// No description provided for @reportsHoursPerDay.
  ///
  /// In fr, this message translates to:
  /// **'Heures par jour'**
  String get reportsHoursPerDay;

  /// No description provided for @reportsLatenessTrend.
  ///
  /// In fr, this message translates to:
  /// **'Évolution des retards'**
  String get reportsLatenessTrend;

  /// No description provided for @reportsStatusDistribution.
  ///
  /// In fr, this message translates to:
  /// **'Répartition des statuts'**
  String get reportsStatusDistribution;

  /// No description provided for @reportsKpis.
  ///
  /// In fr, this message translates to:
  /// **'Indicateurs clés'**
  String get reportsKpis;

  /// No description provided for @reportsTimeline.
  ///
  /// In fr, this message translates to:
  /// **'Chronologie'**
  String get reportsTimeline;

  /// No description provided for @reportsExportPdf.
  ///
  /// In fr, this message translates to:
  /// **'Exporter en PDF'**
  String get reportsExportPdf;

  /// No description provided for @reportsExportCsv.
  ///
  /// In fr, this message translates to:
  /// **'Exporter en CSV'**
  String get reportsExportCsv;

  /// No description provided for @reportsExportXlsx.
  ///
  /// In fr, this message translates to:
  /// **'Exporter en Excel (XLSX)'**
  String get reportsExportXlsx;

  /// No description provided for @reportsNoData.
  ///
  /// In fr, this message translates to:
  /// **'Aucune donnée pour cette période.'**
  String get reportsNoData;

  /// No description provided for @reportsVsPrevious.
  ///
  /// In fr, this message translates to:
  /// **'vs période précédente'**
  String get reportsVsPrevious;

  /// No description provided for @reportsWorkedDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours travaillés'**
  String get reportsWorkedDays;

  /// No description provided for @reportsExpectedDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours attendus'**
  String get reportsExpectedDays;

  /// No description provided for @reportsAbsentDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours absents'**
  String get reportsAbsentDays;

  /// No description provided for @reportsLateDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours en retard'**
  String get reportsLateDays;

  /// No description provided for @reportsEarlyLeaveDays.
  ///
  /// In fr, this message translates to:
  /// **'Départs anticipés'**
  String get reportsEarlyLeaveDays;

  /// No description provided for @reportsJustifiedDays.
  ///
  /// In fr, this message translates to:
  /// **'Absences justifiées'**
  String get reportsJustifiedDays;

  /// No description provided for @reportsLeaveDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours de congé'**
  String get reportsLeaveDays;

  /// No description provided for @reportsHolidayDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours fériés'**
  String get reportsHolidayDays;

  /// No description provided for @reportsAvgHours.
  ///
  /// In fr, this message translates to:
  /// **'Heures moyennes / jour'**
  String get reportsAvgHours;

  /// No description provided for @reportsBestDay.
  ///
  /// In fr, this message translates to:
  /// **'Meilleur jour'**
  String get reportsBestDay;

  /// No description provided for @reportsEmployeeReport.
  ///
  /// In fr, this message translates to:
  /// **'Rapport de {name}'**
  String reportsEmployeeReport(String name);

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get settingsAppearance;

  /// No description provided for @settingsPrimaryColor.
  ///
  /// In fr, this message translates to:
  /// **'Couleur principale'**
  String get settingsPrimaryColor;

  /// No description provided for @settingsAccentColor.
  ///
  /// In fr, this message translates to:
  /// **'Couleur d\'accent'**
  String get settingsAccentColor;

  /// No description provided for @settingsThemeMode.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settingsThemeMode;

  /// No description provided for @settingsLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get settingsLight;

  /// No description provided for @settingsDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get settingsDark;

  /// No description provided for @settingsSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get settingsSystem;

  /// No description provided for @settingsFontSize.
  ///
  /// In fr, this message translates to:
  /// **'Taille du texte'**
  String get settingsFontSize;

  /// No description provided for @settingsCornerRadius.
  ///
  /// In fr, this message translates to:
  /// **'Arrondi des cartes'**
  String get settingsCornerRadius;

  /// No description provided for @settingsDensity.
  ///
  /// In fr, this message translates to:
  /// **'Densité'**
  String get settingsDensity;

  /// No description provided for @settingsCompact.
  ///
  /// In fr, this message translates to:
  /// **'Compacte'**
  String get settingsCompact;

  /// No description provided for @settingsComfortable.
  ///
  /// In fr, this message translates to:
  /// **'Confortable'**
  String get settingsComfortable;

  /// No description provided for @settingsSpacious.
  ///
  /// In fr, this message translates to:
  /// **'Spacieuse'**
  String get settingsSpacious;

  /// No description provided for @settingsAppName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'application'**
  String get settingsAppName;

  /// No description provided for @settingsCompanyLogo.
  ///
  /// In fr, this message translates to:
  /// **'Logo de l\'entreprise'**
  String get settingsCompanyLogo;

  /// No description provided for @settingsWorkRules.
  ///
  /// In fr, this message translates to:
  /// **'Règles de travail'**
  String get settingsWorkRules;

  /// No description provided for @settingsBreakMinutes.
  ///
  /// In fr, this message translates to:
  /// **'Pause (minutes)'**
  String get settingsBreakMinutes;

  /// No description provided for @employeesWorkDays.
  ///
  /// In fr, this message translates to:
  /// **'Jours travaillés'**
  String get employeesWorkDays;

  /// No description provided for @settingsDefaultSchedule.
  ///
  /// In fr, this message translates to:
  /// **'Horaire par défaut'**
  String get settingsDefaultSchedule;

  /// No description provided for @settingsLateTolerance.
  ///
  /// In fr, this message translates to:
  /// **'Tolérance de retard (min)'**
  String get settingsLateTolerance;

  /// No description provided for @settingsEarlyTolerance.
  ///
  /// In fr, this message translates to:
  /// **'Tolérance de départ anticipé (min)'**
  String get settingsEarlyTolerance;

  /// No description provided for @settingsOvertimeThreshold.
  ///
  /// In fr, this message translates to:
  /// **'Seuil d\'heures supplémentaires (min/jour)'**
  String get settingsOvertimeThreshold;

  /// No description provided for @settingsDuplicateWindow.
  ///
  /// In fr, this message translates to:
  /// **'Fenêtre anti-doublon (min)'**
  String get settingsDuplicateWindow;

  /// No description provided for @settingsDayCutoff.
  ///
  /// In fr, this message translates to:
  /// **'Heure de bascule du jour'**
  String get settingsDayCutoff;

  /// No description provided for @settingsHolidays.
  ///
  /// In fr, this message translates to:
  /// **'Jours fériés'**
  String get settingsHolidays;

  /// No description provided for @settingsAddHoliday.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un jour férié'**
  String get settingsAddHoliday;

  /// No description provided for @settingsHolidayName.
  ///
  /// In fr, this message translates to:
  /// **'Libellé'**
  String get settingsHolidayName;

  /// No description provided for @settingsDeleteHoliday.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce jour férié ?'**
  String get settingsDeleteHoliday;

  /// No description provided for @settingsScan.
  ///
  /// In fr, this message translates to:
  /// **'Scan'**
  String get settingsScan;

  /// No description provided for @settingsScanSound.
  ///
  /// In fr, this message translates to:
  /// **'Son de scan'**
  String get settingsScanSound;

  /// No description provided for @settingsScanVibration.
  ///
  /// In fr, this message translates to:
  /// **'Vibration'**
  String get settingsScanVibration;

  /// No description provided for @settingsAutoReturn.
  ///
  /// In fr, this message translates to:
  /// **'Délai de retour automatique (s)'**
  String get settingsAutoReturn;

  /// No description provided for @settingsShowPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Afficher la photo sur le résultat'**
  String get settingsShowPhoto;

  /// No description provided for @settingsReports.
  ///
  /// In fr, this message translates to:
  /// **'Rapports'**
  String get settingsReports;

  /// No description provided for @settingsDefaultPeriod.
  ///
  /// In fr, this message translates to:
  /// **'Période par défaut'**
  String get settingsDefaultPeriod;

  /// No description provided for @settingsVisibleKpis.
  ///
  /// In fr, this message translates to:
  /// **'Indicateurs affichés'**
  String get settingsVisibleKpis;

  /// No description provided for @settingsPdfHeader.
  ///
  /// In fr, this message translates to:
  /// **'Texte d\'en-tête PDF'**
  String get settingsPdfHeader;

  /// No description provided for @settingsPdfFooter.
  ///
  /// In fr, this message translates to:
  /// **'Texte de pied de page PDF'**
  String get settingsPdfFooter;

  /// No description provided for @settingsSecurity.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get settingsSecurity;

  /// No description provided for @settingsPin.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN'**
  String get settingsPin;

  /// No description provided for @settingsChangePin.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le code PIN'**
  String get settingsChangePin;

  /// No description provided for @settingsBiometric.
  ///
  /// In fr, this message translates to:
  /// **'Déverrouillage biométrique'**
  String get settingsBiometric;

  /// No description provided for @settingsAutoLock.
  ///
  /// In fr, this message translates to:
  /// **'Verrouillage automatique'**
  String get settingsAutoLock;

  /// No description provided for @settingsAutoLockImmediate.
  ///
  /// In fr, this message translates to:
  /// **'Immédiat'**
  String get settingsAutoLockImmediate;

  /// No description provided for @settingsAutoLock1.
  ///
  /// In fr, this message translates to:
  /// **'1 minute'**
  String get settingsAutoLock1;

  /// No description provided for @settingsAutoLock5.
  ///
  /// In fr, this message translates to:
  /// **'5 minutes'**
  String get settingsAutoLock5;

  /// No description provided for @settingsAutoLock15.
  ///
  /// In fr, this message translates to:
  /// **'15 minutes'**
  String get settingsAutoLock15;

  /// No description provided for @settingsDisableLock.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver le verrouillage'**
  String get settingsDisableLock;

  /// No description provided for @settingsData.
  ///
  /// In fr, this message translates to:
  /// **'Données'**
  String get settingsData;

  /// No description provided for @settingsBackup.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder'**
  String get settingsBackup;

  /// No description provided for @settingsBackupPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe de sauvegarde'**
  String get settingsBackupPassword;

  /// No description provided for @settingsBackupNoPassword.
  ///
  /// In fr, this message translates to:
  /// **'Sans mot de passe'**
  String get settingsBackupNoPassword;

  /// No description provided for @settingsRestore.
  ///
  /// In fr, this message translates to:
  /// **'Restaurer'**
  String get settingsRestore;

  /// No description provided for @settingsExportAll.
  ///
  /// In fr, this message translates to:
  /// **'Exporter toutes les données'**
  String get settingsExportAll;

  /// No description provided for @settingsReset.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser l\'application'**
  String get settingsReset;

  /// No description provided for @settingsResetConfirm1.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser toutes les données ?'**
  String get settingsResetConfirm1;

  /// No description provided for @settingsResetConfirm2.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les données, badges et réglages seront effacés. Action irréversible.'**
  String get settingsResetConfirm2;

  /// No description provided for @settingsBackupCreated.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarde créée'**
  String get settingsBackupCreated;

  /// No description provided for @settingsRestoreSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Données restaurées'**
  String get settingsRestoreSuccess;

  /// No description provided for @settingsRestoreFailed.
  ///
  /// In fr, this message translates to:
  /// **'Restauration impossible'**
  String get settingsRestoreFailed;

  /// No description provided for @settingsInvalidBackup.
  ///
  /// In fr, this message translates to:
  /// **'Fichier de sauvegarde invalide ou mot de passe incorrect.'**
  String get settingsInvalidBackup;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get settingsFrench;

  /// No description provided for @settingsEnglish.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsAbout.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get settingsAbout;

  /// No description provided for @settingsAboutBody.
  ///
  /// In fr, this message translates to:
  /// **'PointagePro — pointage par badge QR, hors ligne et privé. Aucune donnée ne quitte l\'appareil.'**
  String get settingsAboutBody;

  /// No description provided for @settingsPrivacy.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyBody.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les données restent sur cet appareil. Aucun réseau, aucune télémétrie, aucune publicité.'**
  String get settingsPrivacyBody;

  /// No description provided for @settingsResetDone.
  ///
  /// In fr, this message translates to:
  /// **'Application réinitialisée'**
  String get settingsResetDone;

  /// No description provided for @settingsHolidayAdded.
  ///
  /// In fr, this message translates to:
  /// **'Jour férié ajouté'**
  String get settingsHolidayAdded;

  /// No description provided for @settingsLogoUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Logo mis à jour'**
  String get settingsLogoUpdated;

  /// No description provided for @settingsPinChanged.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN modifié'**
  String get settingsPinChanged;

  /// No description provided for @settingsPinWrong.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN incorrect'**
  String get settingsPinWrong;

  /// No description provided for @settingsPinDisabled.
  ///
  /// In fr, this message translates to:
  /// **'Verrouillage désactivé'**
  String get settingsPinDisabled;

  /// No description provided for @settingsBackupPasswordOptional.
  ///
  /// In fr, this message translates to:
  /// **'Laissez vide pour une sauvegarde non chiffrée.'**
  String get settingsBackupPasswordOptional;

  /// No description provided for @daysMonday.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get daysMonday;

  /// No description provided for @daysTuesday.
  ///
  /// In fr, this message translates to:
  /// **'Mardi'**
  String get daysTuesday;

  /// No description provided for @daysWednesday.
  ///
  /// In fr, this message translates to:
  /// **'Mercredi'**
  String get daysWednesday;

  /// No description provided for @daysThursday.
  ///
  /// In fr, this message translates to:
  /// **'Jeudi'**
  String get daysThursday;

  /// No description provided for @daysFriday.
  ///
  /// In fr, this message translates to:
  /// **'Vendredi'**
  String get daysFriday;

  /// No description provided for @daysSaturday.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get daysSaturday;

  /// No description provided for @daysSunday.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get daysSunday;

  /// No description provided for @daysMon.
  ///
  /// In fr, this message translates to:
  /// **'Lun'**
  String get daysMon;

  /// No description provided for @daysTue.
  ///
  /// In fr, this message translates to:
  /// **'Mar'**
  String get daysTue;

  /// No description provided for @daysWed.
  ///
  /// In fr, this message translates to:
  /// **'Mer'**
  String get daysWed;

  /// No description provided for @daysThu.
  ///
  /// In fr, this message translates to:
  /// **'Jeu'**
  String get daysThu;

  /// No description provided for @daysFri.
  ///
  /// In fr, this message translates to:
  /// **'Ven'**
  String get daysFri;

  /// No description provided for @daysSat.
  ///
  /// In fr, this message translates to:
  /// **'Sam'**
  String get daysSat;

  /// No description provided for @daysSun.
  ///
  /// In fr, this message translates to:
  /// **'Dim'**
  String get daysSun;

  /// No description provided for @hoursShort.
  ///
  /// In fr, this message translates to:
  /// **'h'**
  String get hoursShort;

  /// No description provided for @minutesShort.
  ///
  /// In fr, this message translates to:
  /// **'min'**
  String get minutesShort;

  /// No description provided for @lockTitle.
  ///
  /// In fr, this message translates to:
  /// **'PointagePro verrouillé'**
  String get lockTitle;

  /// No description provided for @lockEnterPin.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez votre code PIN'**
  String get lockEnterPin;

  /// No description provided for @lockUnlock.
  ///
  /// In fr, this message translates to:
  /// **'Déverrouiller'**
  String get lockUnlock;

  /// No description provided for @lockUseBiometrics.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser la biométrie'**
  String get lockUseBiometrics;

  /// No description provided for @lockWrongPin.
  ///
  /// In fr, this message translates to:
  /// **'Code incorrect'**
  String get lockWrongPin;

  /// No description provided for @lockBiometricReason.
  ///
  /// In fr, this message translates to:
  /// **'Déverrouillez PointagePro'**
  String get lockBiometricReason;

  /// No description provided for @scanResultCheckInFor.
  ///
  /// In fr, this message translates to:
  /// **'Arrivée enregistrée : {name}'**
  String scanResultCheckInFor(String name);

  /// No description provided for @scanResultCheckOutFor.
  ///
  /// In fr, this message translates to:
  /// **'Départ enregistré : {name}'**
  String scanResultCheckOutFor(String name);

  /// No description provided for @scanResultErrorFor.
  ///
  /// In fr, this message translates to:
  /// **'Badge refusé : {reason}'**
  String scanResultErrorFor(String reason);

  /// No description provided for @employeeCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun employé} =1{1 employé} other{{count} employés}}'**
  String employeeCount(int count);

  /// No description provided for @badgeRegeneratedFor.
  ///
  /// In fr, this message translates to:
  /// **'Badge régénéré pour {name}'**
  String badgeRegeneratedFor(String name);

  /// No description provided for @deleteEmployeeWarningFor.
  ///
  /// In fr, this message translates to:
  /// **'Cette action supprimera définitivement {name} et tout son historique.'**
  String deleteEmployeeWarningFor(String name);

  /// No description provided for @reportsPeriodLabel.
  ///
  /// In fr, this message translates to:
  /// **'Du {start} au {end}'**
  String reportsPeriodLabel(String start, String end);

  /// No description provided for @compareUp.
  ///
  /// In fr, this message translates to:
  /// **'+{value} % vs période précédente'**
  String compareUp(String value);

  /// No description provided for @compareDown.
  ///
  /// In fr, this message translates to:
  /// **'−{value} % vs période précédente'**
  String compareDown(String value);

  /// No description provided for @compareSame.
  ///
  /// In fr, this message translates to:
  /// **'Identique à la période précédente'**
  String get compareSame;

  /// No description provided for @commonCamera.
  ///
  /// In fr, this message translates to:
  /// **'Appareil photo'**
  String get commonCamera;

  /// No description provided for @commonGallery.
  ///
  /// In fr, this message translates to:
  /// **'Galerie'**
  String get commonGallery;

  /// No description provided for @commonRemove.
  ///
  /// In fr, this message translates to:
  /// **'Retirer'**
  String get commonRemove;

  /// No description provided for @commonValidate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get commonValidate;

  /// No description provided for @commonStart.
  ///
  /// In fr, this message translates to:
  /// **'Début'**
  String get commonStart;

  /// No description provided for @commonEnd.
  ///
  /// In fr, this message translates to:
  /// **'Fin'**
  String get commonEnd;

  /// No description provided for @settingsCompany.
  ///
  /// In fr, this message translates to:
  /// **'Entreprise'**
  String get settingsCompany;

  /// No description provided for @settingsSaved.
  ///
  /// In fr, this message translates to:
  /// **'Réglages enregistrés'**
  String get settingsSaved;

  /// No description provided for @settingsNoHolidays.
  ///
  /// In fr, this message translates to:
  /// **'Aucun jour férié enregistré.'**
  String get settingsNoHolidays;

  /// No description provided for @settingsHolidayNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. : Fête du Travail'**
  String get settingsHolidayNameHint;

  /// No description provided for @settingsPinEnterCurrent.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le code PIN actuel'**
  String get settingsPinEnterCurrent;

  /// No description provided for @settingsPinSet.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN activé'**
  String get settingsPinSet;

  /// No description provided for @settingsBackupBody.
  ///
  /// In fr, this message translates to:
  /// **'Exportez toutes les données dans un fichier, puis partagez-le vers Drive ou Gmail.'**
  String get settingsBackupBody;

  /// No description provided for @settingsAudit.
  ///
  /// In fr, this message translates to:
  /// **'Journal des modifications'**
  String get settingsAudit;

  /// No description provided for @employeesDepartmentFilter.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer par département'**
  String get employeesDepartmentFilter;

  /// No description provided for @employeesPhotoUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Photo mise à jour'**
  String get employeesPhotoUpdated;

  /// No description provided for @employeesPhotoRemoved.
  ///
  /// In fr, this message translates to:
  /// **'Photo supprimée'**
  String get employeesPhotoRemoved;

  /// No description provided for @badgesDownloadPng.
  ///
  /// In fr, this message translates to:
  /// **'Télécharger PNG'**
  String get badgesDownloadPng;

  /// No description provided for @badgesImageSaved.
  ///
  /// In fr, this message translates to:
  /// **'Image PNG enregistrée'**
  String get badgesImageSaved;

  /// No description provided for @badgesImageFailed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'enregistrer l\'image'**
  String get badgesImageFailed;

  /// No description provided for @dashboardOnSite.
  ///
  /// In fr, this message translates to:
  /// **'Sur site'**
  String get dashboardOnSite;

  /// No description provided for @scannerCameraUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Caméra indisponible'**
  String get scannerCameraUnavailable;

  /// No description provided for @scannerCameraBusy.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez qu’aucune autre application n’utilise la caméra, puis réessayez.'**
  String get scannerCameraBusy;

  /// No description provided for @scannerTapAgain.
  ///
  /// In fr, this message translates to:
  /// **'Touchez pour scanner à nouveau'**
  String get scannerTapAgain;

  /// No description provided for @scannerManualTitle.
  ///
  /// In fr, this message translates to:
  /// **'Saisir un badge'**
  String get scannerManualTitle;

  /// No description provided for @scannerManualLabel.
  ///
  /// In fr, this message translates to:
  /// **'Contenu du QR code'**
  String get scannerManualLabel;

  /// No description provided for @scannerRestart.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get scannerRestart;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
