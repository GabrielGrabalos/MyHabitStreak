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
  String get invalidHabitMessage => 'Veuillez vérifier que le titre de l\'habitude n\'est pas vacant et qu\'il est unique.';

  @override
  String get deleteConfirmationTitle => 'Supprimer l\'Habitude ?';

  @override
  String get deleteConfirmationMessage => 'Êtes-vous sûr de vouloir supprimer cette habitude ? Cette action ne peut pas être annulée.';

  @override
  String get markDoneConfirmation => 'Marquer comme fait ?';

  @override
  String get markNotDoneConfirmation => 'Marquer comme non fait ?';

  @override
  String get markDoneMessage => 'Êtes-vous sûr de vouloir marquer cette habitude comme faite ?\nN\'oubliez pas, nous sommes là pour vous aider. Soyez honnête !';

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
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMessage => 'Autorisez-nous à vous envoyer des notifications pour ne jamais oublier vos nouvelles habitudes ! Nous promettons de ne pas en abuser !';

  @override
  String get permanentlyDeniedMessage => 'Êtes-vous sûr de vouloir refuser définitivement les notifications ?';

  @override
  String get openSettings => 'Ouvrir les Paramètres';

  @override
  String get dontAskAgain => 'Ne plus demander';

  @override
  String notificationTitle(Object count) {
    return 'Vous avez $count habitudes à terminer';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '« $habitName » vous attend !';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '« $firstHabitName » et « $secondHabitName » vous attendent !';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, et $remainingCount autres vous attendent !';
  }

  @override
  String get countDownNotificationTitle => 'Votre temps est compté !';

  @override
  String get deleteHabitGroupTitle => 'Supprimer le Groupe ?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Êtes-vous sûr de vouloir supprimer le groupe \"$groupName\" ? Ne vous inquiétez pas, cette action ne supprimera PAS les habitudes qu\'il contient.';
  }

  @override
  String get all => 'Tous';

  @override
  String get notDone => 'En attente';

  @override
  String get done => 'Terminés';

  @override
  String get edit => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get invalidGroupTitle => 'Groupe Invalide';

  @override
  String get invalidGroupMessage => 'Veuillez fournir un nom unique et valide pour le groupe d\'habitudes.';

  @override
  String get groupTitle => 'Titre du Groupe';

  @override
  String get editHabitGroup => 'Modifier le Groupe';

  @override
  String get createHabitGroup => 'Créer un Groupe';

  @override
  String get selectHabits => 'Sélectionner les Habitudes:';

  @override
  String get create => 'Créer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get habitSelected => 'sélectionné';

  @override
  String get habitsSelected => 'sélectionnés';

  @override
  String get nothingMuchHere => 'Pas grand-chose ici...';

  @override
  String get goToGroupAll => 'Aller à \"Tous\"';
}
