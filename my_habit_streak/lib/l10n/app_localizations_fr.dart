// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get language => 'Français';

  @override
  String get idiom => 'Langue';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get appTitle => 'Ma Série d\'Habitudes';

  @override
  String get createHabit => 'Créer une Habitude';

  @override
  String get editHabit => 'Modifier l\'Habitude';

  @override
  String get habitTitle => 'Titre de l\'Habitude';

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'Aucune description fournie.';

  @override
  String get saveHabit => 'Enregistrer l\'Habitude';

  @override
  String get deleteHabit => 'Supprimer l\'Habitude';

  @override
  String get markDone => 'Marquer comme fait';

  @override
  String get markNotDone => 'Marquer comme non fait';

  @override
  String get streakHistory => 'Votre historique de séries';

  @override
  String get invalidHabit => 'Habitude Invalide';

  @override
  String get invalidHabitMessage => 'Veuillez vérifier que le titre de l\'habitude n\'est pas vide et qu\'il est unique.';

  @override
  String get deleteConfirmationTitle => 'Supprimer l\'Habitude ?';

  @override
  String get deleteConfirmationMessage => 'Êtes-vous sûr de vouloir supprimer cette habitude ? Cette action ne peut pas être annulée.';

  @override
  String get markDoneConfirmation => 'Marquer comme fait ?';

  @override
  String get markNotDoneConfirmation => 'Marquer comme non fait ?';

  @override
  String get markDoneMessage => 'Êtes-vous sûr de vouloir marquer cette habitude comme faite ?\nN\'oubliez pas, nous sommes là pour vous aider. Ne vous mentez pas à vous-même !';

  @override
  String get markNotDoneMessage => 'Êtes-vous sûr de vouloir marquer cette habitude comme non faite ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get myHabits => 'Mes Habitudes';

  @override
  String get notDoneToday => 'Pas Fait Aujourd\'hui';

  @override
  String get doneToday => 'Fait Aujourd\'hui';

  @override
  String get startCreating => 'Commencez par créer\nune nouvelle habitude !';

  @override
  String get testNotificationTitle => 'Notification de Test';

  @override
  String get testNotificationBody => 'Ceci est une notification de test programmée pour apparaître 1 minute après la configuration';

  @override
  String get goodMorning => 'Bonjour !';

  @override
  String get middayCheckin => 'Point de Mi-journée';

  @override
  String get eveningUpdate => 'Mise à Jour du Soir';

  @override
  String get nightlyReflection => 'Réflexion Nocturne';

  @override
  String get finalReminder => 'Rappel Final';

  @override
  String get morningHabitCheck => 'Il est temps de vérifier vos habitudes du jour';

  @override
  String get middayProgress => 'Comment vont vos habitudes ?';

  @override
  String get eveningReview => 'Il est temps de revoir vos habitudes quotidiennes';

  @override
  String get dailyPerformance => 'Comment avez-vous géré vos habitudes aujourd\'hui ?';

  @override
  String get lastChance => 'Dernière chance de terminer vos habitudes aujourd\'hui';

  @override
  String progressComplete(Object progress) {
    return 'Progrès du jour : $progress% terminé';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed sur $total habitudes faites';
  }

  @override
  String get motivationStart => 'Vous avez ça ! Commencez par une petite habitude.';

  @override
  String get motivationKeepGoing => 'Continuez ! Chaque habitude compte.';

  @override
  String get motivationGreatProgress => 'Super progression ! Terminez en force !';

  @override
  String get motivationAmazing => 'Incroyable ! Vous avez terminé toutes vos habitudes aujourd\'hui !';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMessage => 'Autorisez-nous à vous envoyer des notifications pour ne jamais oublier vos nouvelles habitudes ! Nous promettons de ne pas en abuser !';

  @override
  String get permanentlyDeniedMessage => 'Êtes-vous sûr de vouloir refuser définitivement les notifications ?';

  @override
  String get openSettings => 'Ouvrir les Paramètres';

  @override
  String get dontAskAgain => 'Ne plus demander';
}
