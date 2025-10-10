// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String get idiom => 'Idioma';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get appTitle => 'Mi Racha de Hábitos';

  @override
  String get createHabit => 'Crear Hábito';

  @override
  String get editHabit => 'Editar Hábito';

  @override
  String get habitTitle => 'Título del Hábito';

  @override
  String get description => 'Descripción';

  @override
  String get noDescription => 'No se proporcionó descripción。';

  @override
  String get saveHabit => 'Guardar Hábito';

  @override
  String get deleteHabit => 'Eliminar Hábito';

  @override
  String get markDone => 'Marcar como hecho';

  @override
  String get markNotDone => 'Marcar como no hecho';

  @override
  String get streakHistory => 'Tu historial de rachas';

  @override
  String get invalidHabit => 'Hábito Inválido';

  @override
  String get invalidHabitMessage => 'Por favor, asegúrese de que el título del hábito no esté vacío y sea único。';

  @override
  String get deleteConfirmationTitle => '¿Eliminar hábito?';

  @override
  String get deleteConfirmationMessage => '¿Está seguro de que desea eliminar este hábito? Esta acción no se puede deshacer。';

  @override
  String get markDoneConfirmation => '¿Marcar como hecho?';

  @override
  String get markNotDoneConfirmation => '¿Marcar como no hecho?';

  @override
  String get markDoneMessage => '¿Está seguro de que desea marcar este hábito como hecho?\nRecuerde, estamos aquí para ayudar. ¡No se engañe!';

  @override
  String get markNotDoneMessage => '¿Está seguro de que desea marcar este hábito como no hecho?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get myHabits => 'Mis Hábitos';

  @override
  String get notDoneToday => 'No Hecho Hoy';

  @override
  String get doneToday => 'Hecho Hoy';

  @override
  String get startCreating => '¡Comience creando\nun nuevo hábito!';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsMessage => '¡Permítenos enviarte notificaciones para ayudarte a nunca olvidar tus nuevos hábitos! ¡Prometemos no abusar!';

  @override
  String get permanentlyDeniedMessage => '¿Estás seguro de que deseas denegar permanentemente las notificaciones?';

  @override
  String get openSettings => 'Abrir Ajustes';

  @override
  String get dontAskAgain => 'No volver a preguntar';

  @override
  String notificationTitle(Object count) {
    return 'Tienes $count hábitos por completar';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '¡\"$habitName\" te está esperando!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '¡\"$firstHabitName\" y \"$secondHabitName\" te están esperando!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '¡$firstTwoNames, y $remainingCount más te están esperando!';
  }

  @override
  String get countDownNotificationTitle => '¡Se te acaba el tiempo!';

  @override
  String get deleteHabitGroupTitle => '¿Eliminar Grupo?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return '¿Está seguro de que desea eliminar el grupo \"$groupName\"? No se preocupe, esta acción NO eliminará los hábitos dentro de él.';
  }

  @override
  String get all => 'Todos';

  @override
  String get notDone => 'Pendientes';

  @override
  String get done => 'Completados';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get invalidGroupTitle => 'Grupo Inválido';

  @override
  String get invalidGroupMessage => 'Por favor, proporcione un nombre único y válido para el grupo de hábitos.';

  @override
  String get groupTitle => 'Título del Grupo';

  @override
  String get editHabitGroup => 'Editar Grupo';

  @override
  String get createHabitGroup => 'Crear Grupo';

  @override
  String get selectHabits => 'Seleccionar Hábitos:';

  @override
  String get create => 'Crear';

  @override
  String get update => 'Actualizar';

  @override
  String get habitSelected => 'seleccionado';

  @override
  String get habitsSelected => 'seleccionados';
}
