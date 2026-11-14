// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'PointagePro';

  @override
  String get appTagline => 'Pointage simple et professionnel par QR code';

  @override
  String get navHome => 'Accueil';

  @override
  String get navScanner => 'Scanner';

  @override
  String get navEmployees => 'Employés';

  @override
  String get navReports => 'Rapports';

  @override
  String get navSettings => 'Réglages';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonError => 'Erreur';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonNone => 'Aucun';

  @override
  String get commonAll => 'Tous';

  @override
  String get commonToday => 'Aujourd\'hui';

  @override
  String get commonWeek => 'Semaine';

  @override
  String get commonMonth => 'Mois';

  @override
  String get commonQuarter => 'Trimestre';

  @override
  String get commonYear => 'Année';

  @override
  String get commonCustom => 'Personnalisé';

  @override
  String get commonFrom => 'Du';

  @override
  String get commonTo => 'Au';

  @override
  String get commonApply => 'Appliquer';

  @override
  String get commonReset => 'Réinitialiser';

  @override
  String get commonShare => 'Partager';

  @override
  String get commonPrint => 'Imprimer';

  @override
  String get commonExport => 'Exporter';

  @override
  String get commonRefresh => 'Actualiser';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonFinish => 'Terminer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonYes => 'Oui';

  @override
  String get commonNo => 'Non';

  @override
  String get commonOptional => 'Facultatif';

  @override
  String get commonRequired => 'Obligatoire';

  @override
  String get commonUnknown => 'Inconnu';

  @override
  String get commonNoData => 'Aucune donnée';

  @override
  String get commonSeeAll => 'Tout voir';

  @override
  String get commonDetails => 'Détails';

  @override
  String get commonArchived => 'Archivé';

  @override
  String get commonActive => 'Actif';

  @override
  String get commonActions => 'Actions';

  @override
  String get commonOk => 'OK';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonVersion => 'Version';

  @override
  String get commonErrorGeneric =>
      'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur PointagePro';

  @override
  String get onboardingWelcomeBody =>
      'Scannez les badges QR de vos employés pour enregistrer les arrivées et départs, puis consultez des rapports clairs et professionnels.';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboardingCompanyTitle => 'Votre entreprise';

  @override
  String get onboardingCompanyName => 'Nom de l\'entreprise';

  @override
  String get onboardingCompanyNameHint => 'Ex. : Atelier Horizon';

  @override
  String get onboardingCompanyLogo => 'Logo de l\'entreprise';

  @override
  String get onboardingPickLogo => 'Choisir un logo';

  @override
  String get onboardingRemoveLogo => 'Retirer le logo';

  @override
  String get onboardingThemeTitle => 'Votre style';

  @override
  String get onboardingThemeBody =>
      'Choisissez la couleur principale de l\'application.';

  @override
  String get onboardingScheduleTitle => 'Horaires de travail';

  @override
  String get onboardingScheduleBody =>
      'Ces réglages s\'appliquent à tous les employés, sauf horaire personnalisé.';

  @override
  String get onboardingSecurityTitle => 'Sécurité';

  @override
  String get onboardingSecurityBody =>
      'Protégez l\'accès aux données de pointage.';

  @override
  String get onboardingEnablePin => 'Activer un code PIN';

  @override
  String get onboardingPin => 'Code PIN (4 à 6 chiffres)';

  @override
  String get onboardingConfirmPin => 'Confirmer le code PIN';

  @override
  String get onboardingPinMismatch => 'Les codes PIN ne correspondent pas.';

  @override
  String get onboardingPinInvalid =>
      'Le code PIN doit contenir 4 à 6 chiffres.';

  @override
  String get onboardingBiometric => 'Déverrouillage biométrique';

  @override
  String get onboardingBiometricUnavailable =>
      'La biométrie n\'est pas disponible sur cet appareil.';

  @override
  String get onboardingDone => 'PointagePro est prêt';

  @override
  String get onboardingCompanyRequired =>
      'Le nom de l\'entreprise est obligatoire.';

  @override
  String get onboardingPinRequired =>
      'Saisissez et confirmez un code PIN valide.';

  @override
  String get dashboardGreeting => 'Tableau de bord';

  @override
  String get dashboardPresent => 'Présents';

  @override
  String get dashboardLate => 'En retard';

  @override
  String get dashboardAbsent => 'Absents';

  @override
  String get dashboardNotYet => 'Pas encore arrivés';

  @override
  String get dashboardAttendanceRate => 'Taux de présence';

  @override
  String get dashboardQuickScan => 'Scanner un badge';

  @override
  String get dashboardWhoIsIn => 'Actuellement sur site';

  @override
  String get dashboardRecentScans => 'Scans récents';

  @override
  String get dashboardWeekly => 'Activité des 7 derniers jours';

  @override
  String get dashboardAlerts => 'Alertes';

  @override
  String get dashboardNoEmployeesTitle => 'Ajoutez votre premier employé';

  @override
  String get dashboardNoEmployeesBody =>
      'Créez une fiche employé pour générer son badge QR et commencer le pointage.';

  @override
  String get dashboardNoScans => 'Aucun scan enregistré aujourd\'hui.';

  @override
  String get dashboardInAt => 'Arrivée';

  @override
  String get dashboardOutAt => 'Départ';

  @override
  String get dashboardSince => 'Depuis';

  @override
  String get dashboardNotClockedOut => 'Départ non pointé';

  @override
  String get dashboardRepeatedLateness => 'Retards répétés';

  @override
  String get dashboardUnjustifiedAbsences => 'Absences non justifiées';

  @override
  String get dashboardNoAlerts => 'Aucune alerte. Tout est en ordre.';

  @override
  String get scannerTitle => 'Scanner';

  @override
  String get scannerHint => 'Placez le badge QR dans le cadre';

  @override
  String get scannerFlash => 'Torche';

  @override
  String get scannerSwitchCamera => 'Changer de caméra';

  @override
  String get scannerPermissionTitle => 'Accès à la caméra requis';

  @override
  String get scannerPermissionBody =>
      'Autorisez l\'accès à la caméra dans les réglages Android pour scanner les badges.';

  @override
  String get scannerOpenSettings => 'Ouvrir les réglages';

  @override
  String get scannerInvalidQr => 'QR code invalide ou falsifié';

  @override
  String get scannerUnknownBadge => 'Badge inconnu';

  @override
  String get scannerArchivedBadge => 'Badge d\'un employé archivé';

  @override
  String get scannerOutdatedBadge => 'Badge obsolète — régénérez-le';

  @override
  String get scannerScanAgain => 'Scanner à nouveau';

  @override
  String get scannerDuplicate => 'Scan ignoré : déjà pointé à l\'instant';

  @override
  String get scannerCheckoutUpdated => 'Départ mis à jour';

  @override
  String get scannerAlreadyClockedOut =>
      'Pointage déjà complet pour aujourd\'hui';

  @override
  String get scannerCheckInSuccess => 'Arrivée enregistrée';

  @override
  String get scannerCheckOutSuccess => 'Départ enregistré';

  @override
  String get scannerLateArrival => 'Arrivée tardive';

  @override
  String get scannerOnTime => 'À l\'heure';

  @override
  String get scannerManualBlocked =>
      'Journée verrouillée par une correction manuelle';

  @override
  String get scannerError => 'Impossible de traiter ce badge';

  @override
  String get scannerTip =>
      'Le scan reste actif : présentez les badges les uns après les autres.';

  @override
  String get employeesTitle => 'Employés';

  @override
  String get employeesAdd => 'Nouvel employé';

  @override
  String get employeesEdit => 'Modifier l\'employé';

  @override
  String get employeesFirstName => 'Prénom';

  @override
  String get employeesLastName => 'Nom';

  @override
  String get employeesMatricule => 'Matricule';

  @override
  String get employeesPosition => 'Poste';

  @override
  String get employeesDepartment => 'Département';

  @override
  String get employeesPhone => 'Téléphone';

  @override
  String get employeesHireDate => 'Date d\'embauche';

  @override
  String get employeesPhoto => 'Photo';

  @override
  String get employeesTakePhoto => 'Prendre une photo';

  @override
  String get employeesGallery => 'Choisir dans la galerie';

  @override
  String get employeesCustomSchedule => 'Horaire personnalisé';

  @override
  String get employeesUseCustomSchedule =>
      'Utiliser un horaire propre à cet employé';

  @override
  String get employeesSearch => 'Rechercher un nom, un matricule…';

  @override
  String get employeesFilter => 'Filtrer';

  @override
  String get employeesSort => 'Trier';

  @override
  String get employeesSortName => 'Nom (A–Z)';

  @override
  String get employeesSortRecent => 'Ajout récent';

  @override
  String get employeesSortDepartment => 'Département';

  @override
  String get employeesDetail => 'Fiche employé';

  @override
  String get employeesArchive => 'Archiver';

  @override
  String get employeesArchiveConfirm =>
      'Archiver cet employé ? Son historique sera conservé.';

  @override
  String get employeesUnarchive => 'Réactiver';

  @override
  String get employeesDelete => 'Supprimer définitivement';

  @override
  String get employeesDeleteConfirm1 =>
      'Supprimer cet employé et tout son historique ?';

  @override
  String get employeesDeleteConfirm2 =>
      'Cette action est irréversible. Confirmez la suppression définitive.';

  @override
  String get employeesDeleteWarning =>
      'Toutes les pointages, badges et corrections de cet employé seront supprimés.';

  @override
  String get employeesPersonalInfo => 'Informations personnelles';

  @override
  String get employeesSchedule => 'Horaire';

  @override
  String get employeesSummary => 'Résumé de présence';

  @override
  String get employeesBadges => 'Badges';

  @override
  String get employeesEmptyTitle => 'Aucun employé';

  @override
  String get employeesEmptyBody =>
      'Ajoutez un employé pour générer son badge QR.';

  @override
  String get employeesNoResults => 'Aucun résultat pour cette recherche.';

  @override
  String get employeesRequiredField => 'Ce champ est obligatoire.';

  @override
  String get employeesSaved => 'Employé enregistré';

  @override
  String get employeesArchived => 'Employé archivé';

  @override
  String get employeesDeleted => 'Employé supprimé';

  @override
  String get employeesShowArchived => 'Afficher les archivés';

  @override
  String get badgesTitle => 'Badges';

  @override
  String get badgesBadge => 'Badge QR';

  @override
  String get badgesView => 'Voir le badge';

  @override
  String get badgesPrint => 'Imprimer';

  @override
  String get badgesShare => 'Partager';

  @override
  String get badgesRegenerate => 'Régénérer';

  @override
  String get badgesRegenerateConfirm =>
      'Régénérer ce badge ? L\'ancien badge ne fonctionnera plus.';

  @override
  String get badgesRegenerated => 'Nouveau badge généré';

  @override
  String get badgesFormat => 'Format';

  @override
  String get badgesCardSize => 'Carte';

  @override
  String get badgesA6 => 'A6';

  @override
  String get badgesMultiple => 'Plusieurs par page';

  @override
  String get badgesPrintAll => 'Imprimer tous les badges';

  @override
  String get badgesShareAll => 'Partager tous les badges';

  @override
  String get badgesEmpty => 'Aucun badge à afficher';

  @override
  String get badgesPreview => 'Aperçu du badge';

  @override
  String get badgesSingle => 'Un seul badge';

  @override
  String get badgesAllActive => 'Tous les employés actifs';

  @override
  String get attendanceTitle => 'Pointages';

  @override
  String get attendanceHistory => 'Historique';

  @override
  String get attendanceDay => 'Jour';

  @override
  String get attendanceWeek => 'Semaine';

  @override
  String get attendanceMonth => 'Mois';

  @override
  String get attendanceCalendar => 'Calendrier';

  @override
  String get attendanceFilters => 'Filtres';

  @override
  String get attendanceStatus => 'Statut';

  @override
  String get attendanceManualEntry => 'Correction manuelle';

  @override
  String get attendanceAddRecord => 'Ajouter un pointage';

  @override
  String get attendanceEditRecord => 'Modifier le pointage';

  @override
  String get attendanceDeleteRecord => 'Supprimer le pointage';

  @override
  String get attendanceCheckIn => 'Heure d\'arrivée';

  @override
  String get attendanceCheckOut => 'Heure de départ';

  @override
  String get attendanceNote => 'Note / justification';

  @override
  String get attendanceStatusPresent => 'Présent';

  @override
  String get attendanceStatusLate => 'En retard';

  @override
  String get attendanceStatusAbsent => 'Absent';

  @override
  String get attendanceStatusLeftEarly => 'Parti tôt';

  @override
  String get attendanceStatusJustified => 'Absence justifiée';

  @override
  String get attendanceStatusLeave => 'Congé';

  @override
  String get attendanceStatusHoliday => 'Férié';

  @override
  String get attendanceStatusNotYet => 'Pas encore arrivé';

  @override
  String get attendanceStatusDayOff => 'Repos';

  @override
  String get attendanceMissingCheckout => 'Départ manquant';

  @override
  String get attendanceSaved => 'Pointage enregistré';

  @override
  String get attendanceDeleted => 'Pointage supprimé';

  @override
  String get attendanceAudit => 'Journal des modifications';

  @override
  String get attendancePreviousValue => 'Ancienne valeur';

  @override
  String get attendanceNewValue => 'Nouvelle valeur';

  @override
  String get attendanceChangedAt => 'Modifié le';

  @override
  String get attendanceNoRecords => 'Aucun pointage pour cette période.';

  @override
  String get attendanceSelectEmployee => 'Choisir un employé';

  @override
  String get attendanceSelectDate => 'Choisir une date';

  @override
  String get attendanceWorkHours => 'Heures travaillées';

  @override
  String get attendanceOvertime => 'Heures supplémentaires';

  @override
  String get attendanceLateMinutes => 'Minutes de retard';

  @override
  String get attendanceEarlyLeave => 'Départ anticipé';

  @override
  String get attendanceNoTimes => 'Aucune heure saisie (statut manuel)';

  @override
  String get reportsTitle => 'Rapports';

  @override
  String get reportsGlobal => 'Rapport global';

  @override
  String get reportsIndividual => 'Rapport individuel';

  @override
  String get reportsPeriod => 'Période';

  @override
  String get reportsCompare => 'Comparer à la période précédente';

  @override
  String get reportsPresenceRate => 'Taux de présence';

  @override
  String get reportsPunctualityRate => 'Taux de ponctualité';

  @override
  String get reportsAbsenceRate => 'Taux d\'absence';

  @override
  String get reportsTotalHours => 'Heures totales';

  @override
  String get reportsOvertimeHours => 'Heures supplémentaires';

  @override
  String get reportsAverageArrival => 'Arrivée moyenne';

  @override
  String get reportsMostPunctual => 'Les plus ponctuels';

  @override
  String get reportsLeastPunctual => 'Les moins ponctuels';

  @override
  String get reportsDepartmentComparison => 'Comparaison par département';

  @override
  String get reportsHeatmap => 'Carte de présence';

  @override
  String get reportsHoursPerDay => 'Heures par jour';

  @override
  String get reportsLatenessTrend => 'Évolution des retards';

  @override
  String get reportsStatusDistribution => 'Répartition des statuts';

  @override
  String get reportsKpis => 'Indicateurs clés';

  @override
  String get reportsTimeline => 'Chronologie';

  @override
  String get reportsExportPdf => 'Exporter en PDF';

  @override
  String get reportsExportCsv => 'Exporter en CSV';

  @override
  String get reportsExportXlsx => 'Exporter en Excel (XLSX)';

  @override
  String get reportsNoData => 'Aucune donnée pour cette période.';

  @override
  String get reportsVsPrevious => 'vs période précédente';

  @override
  String get reportsWorkedDays => 'Jours travaillés';

  @override
  String get reportsExpectedDays => 'Jours attendus';

  @override
  String get reportsAbsentDays => 'Jours absents';

  @override
  String get reportsLateDays => 'Jours en retard';

  @override
  String get reportsEarlyLeaveDays => 'Départs anticipés';

  @override
  String get reportsJustifiedDays => 'Absences justifiées';

  @override
  String get reportsLeaveDays => 'Jours de congé';

  @override
  String get reportsHolidayDays => 'Jours fériés';

  @override
  String get reportsAvgHours => 'Heures moyennes / jour';

  @override
  String get reportsBestDay => 'Meilleur jour';

  @override
  String reportsEmployeeReport(String name) {
    return 'Rapport de $name';
  }

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsPrimaryColor => 'Couleur principale';

  @override
  String get settingsAccentColor => 'Couleur d\'accent';

  @override
  String get settingsThemeMode => 'Thème';

  @override
  String get settingsLight => 'Clair';

  @override
  String get settingsDark => 'Sombre';

  @override
  String get settingsSystem => 'Système';

  @override
  String get settingsFontSize => 'Taille du texte';

  @override
  String get settingsCornerRadius => 'Arrondi des cartes';

  @override
  String get settingsDensity => 'Densité';

  @override
  String get settingsCompact => 'Compacte';

  @override
  String get settingsComfortable => 'Confortable';

  @override
  String get settingsSpacious => 'Spacieuse';

  @override
  String get settingsAppName => 'Nom de l\'application';

  @override
  String get settingsCompanyLogo => 'Logo de l\'entreprise';

  @override
  String get settingsWorkRules => 'Règles de travail';

  @override
  String get settingsBreakMinutes => 'Pause (minutes)';

  @override
  String get employeesWorkDays => 'Jours travaillés';

  @override
  String get settingsDefaultSchedule => 'Horaire par défaut';

  @override
  String get settingsLateTolerance => 'Tolérance de retard (min)';

  @override
  String get settingsEarlyTolerance => 'Tolérance de départ anticipé (min)';

  @override
  String get settingsOvertimeThreshold =>
      'Seuil d\'heures supplémentaires (min/jour)';

  @override
  String get settingsDuplicateWindow => 'Fenêtre anti-doublon (min)';

  @override
  String get settingsDayCutoff => 'Heure de bascule du jour';

  @override
  String get settingsHolidays => 'Jours fériés';

  @override
  String get settingsAddHoliday => 'Ajouter un jour férié';

  @override
  String get settingsHolidayName => 'Libellé';

  @override
  String get settingsDeleteHoliday => 'Supprimer ce jour férié ?';

  @override
  String get settingsScan => 'Scan';

  @override
  String get settingsScanSound => 'Son de scan';

  @override
  String get settingsScanVibration => 'Vibration';

  @override
  String get settingsAutoReturn => 'Délai de retour automatique (s)';

  @override
  String get settingsShowPhoto => 'Afficher la photo sur le résultat';

  @override
  String get settingsReports => 'Rapports';

  @override
  String get settingsDefaultPeriod => 'Période par défaut';

  @override
  String get settingsVisibleKpis => 'Indicateurs affichés';

  @override
  String get settingsPdfHeader => 'Texte d\'en-tête PDF';

  @override
  String get settingsPdfFooter => 'Texte de pied de page PDF';

  @override
  String get settingsSecurity => 'Sécurité';

  @override
  String get settingsPin => 'Code PIN';

  @override
  String get settingsChangePin => 'Modifier le code PIN';

  @override
  String get settingsBiometric => 'Déverrouillage biométrique';

  @override
  String get settingsAutoLock => 'Verrouillage automatique';

  @override
  String get settingsAutoLockImmediate => 'Immédiat';

  @override
  String get settingsAutoLock1 => '1 minute';

  @override
  String get settingsAutoLock5 => '5 minutes';

  @override
  String get settingsAutoLock15 => '15 minutes';

  @override
  String get settingsDisableLock => 'Désactiver le verrouillage';

  @override
  String get settingsData => 'Données';

  @override
  String get settingsBackup => 'Sauvegarder';

  @override
  String get settingsBackupPassword => 'Mot de passe de sauvegarde';

  @override
  String get settingsBackupNoPassword => 'Sans mot de passe';

  @override
  String get settingsRestore => 'Restaurer';

  @override
  String get settingsExportAll => 'Exporter toutes les données';

  @override
  String get settingsReset => 'Réinitialiser l\'application';

  @override
  String get settingsResetConfirm1 => 'Réinitialiser toutes les données ?';

  @override
  String get settingsResetConfirm2 =>
      'Toutes les données, badges et réglages seront effacés. Action irréversible.';

  @override
  String get settingsBackupCreated => 'Sauvegarde créée';

  @override
  String get settingsRestoreSuccess => 'Données restaurées';

  @override
  String get settingsRestoreFailed => 'Restauration impossible';

  @override
  String get settingsInvalidBackup =>
      'Fichier de sauvegarde invalide ou mot de passe incorrect.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsFrench => 'Français';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsAboutBody =>
      'PointagePro — pointage par badge QR, hors ligne et privé. Aucune donnée ne quitte l\'appareil.';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacyBody =>
      'Toutes les données restent sur cet appareil. Aucun réseau, aucune télémétrie, aucune publicité.';

  @override
  String get settingsResetDone => 'Application réinitialisée';

  @override
  String get settingsHolidayAdded => 'Jour férié ajouté';

  @override
  String get settingsLogoUpdated => 'Logo mis à jour';

  @override
  String get settingsPinChanged => 'Code PIN modifié';

  @override
  String get settingsPinWrong => 'Code PIN incorrect';

  @override
  String get settingsPinDisabled => 'Verrouillage désactivé';

  @override
  String get settingsBackupPasswordOptional =>
      'Laissez vide pour une sauvegarde non chiffrée.';

  @override
  String get daysMonday => 'Lundi';

  @override
  String get daysTuesday => 'Mardi';

  @override
  String get daysWednesday => 'Mercredi';

  @override
  String get daysThursday => 'Jeudi';

  @override
  String get daysFriday => 'Vendredi';

  @override
  String get daysSaturday => 'Samedi';

  @override
  String get daysSunday => 'Dimanche';

  @override
  String get daysMon => 'Lun';

  @override
  String get daysTue => 'Mar';

  @override
  String get daysWed => 'Mer';

  @override
  String get daysThu => 'Jeu';

  @override
  String get daysFri => 'Ven';

  @override
  String get daysSat => 'Sam';

  @override
  String get daysSun => 'Dim';

  @override
  String get hoursShort => 'h';

  @override
  String get minutesShort => 'min';

  @override
  String get lockTitle => 'PointagePro verrouillé';

  @override
  String get lockEnterPin => 'Saisissez votre code PIN';

  @override
  String get lockUnlock => 'Déverrouiller';

  @override
  String get lockUseBiometrics => 'Utiliser la biométrie';

  @override
  String get lockWrongPin => 'Code incorrect';

  @override
  String get lockBiometricReason => 'Déverrouillez PointagePro';

  @override
  String scanResultCheckInFor(String name) {
    return 'Arrivée enregistrée : $name';
  }

  @override
  String scanResultCheckOutFor(String name) {
    return 'Départ enregistré : $name';
  }

  @override
  String scanResultErrorFor(String reason) {
    return 'Badge refusé : $reason';
  }

  @override
  String employeeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count employés',
      one: '1 employé',
      zero: 'Aucun employé',
    );
    return '$_temp0';
  }

  @override
  String badgeRegeneratedFor(String name) {
    return 'Badge régénéré pour $name';
  }

  @override
  String deleteEmployeeWarningFor(String name) {
    return 'Cette action supprimera définitivement $name et tout son historique.';
  }

  @override
  String reportsPeriodLabel(String start, String end) {
    return 'Du $start au $end';
  }

  @override
  String compareUp(String value) {
    return '+$value % vs période précédente';
  }

  @override
  String compareDown(String value) {
    return '−$value % vs période précédente';
  }

  @override
  String get compareSame => 'Identique à la période précédente';

  @override
  String get commonCamera => 'Appareil photo';

  @override
  String get commonGallery => 'Galerie';

  @override
  String get commonRemove => 'Retirer';

  @override
  String get commonValidate => 'Valider';

  @override
  String get commonStart => 'Début';

  @override
  String get commonEnd => 'Fin';

  @override
  String get settingsCompany => 'Entreprise';

  @override
  String get settingsSaved => 'Réglages enregistrés';

  @override
  String get settingsNoHolidays => 'Aucun jour férié enregistré.';

  @override
  String get settingsHolidayNameHint => 'Ex. : Fête du Travail';

  @override
  String get settingsPinEnterCurrent => 'Saisissez le code PIN actuel';

  @override
  String get settingsPinSet => 'Code PIN activé';

  @override
  String get settingsBackupBody =>
      'Exportez toutes les données dans un fichier, puis partagez-le vers Drive ou Gmail.';

  @override
  String get settingsAudit => 'Journal des modifications';

  @override
  String get employeesDepartmentFilter => 'Filtrer par département';

  @override
  String get employeesPhotoUpdated => 'Photo mise à jour';

  @override
  String get employeesPhotoRemoved => 'Photo supprimée';

  @override
  String get badgesDownloadPng => 'Télécharger PNG';

  @override
  String get badgesImageSaved => 'Image PNG enregistrée';

  @override
  String get badgesImageFailed => 'Impossible d\'enregistrer l\'image';

  @override
  String get dashboardOnSite => 'Sur site';

  @override
  String get scannerCameraUnavailable => 'Caméra indisponible';

  @override
  String get scannerCameraBusy =>
      'Vérifiez qu’aucune autre application n’utilise la caméra, puis réessayez.';

  @override
  String get scannerTapAgain => 'Touchez pour scanner à nouveau';

  @override
  String get scannerManualTitle => 'Saisir un badge';

  @override
  String get scannerManualLabel => 'Contenu du QR code';

  @override
  String get scannerRestart => 'Réessayer';
}
