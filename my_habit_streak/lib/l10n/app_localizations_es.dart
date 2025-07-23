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
  String get noDescription => 'No se proporcionó descripción.';

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
  String get invalidHabitMessage => 'Por favor, asegúrese de que el título del hábito no esté vacío y sea único.';

  @override
  String get deleteConfirmationTitle => '¿Eliminar hábito?';

  @override
  String get deleteConfirmationMessage => '¿Está seguro de que desea eliminar este hábito? Esta acción no se puede deshacer.';

  @override
  String get markDoneConfirmation => '¿Marcar como hecho?';

  @override
  String get markNotDoneConfirmation => '¿Marcar como no hecho?';

  @override
  String get markDoneMessage => '¿Está seguro de que desea marcar este hábito como hecho?\nRecuerde, estamos aquí para ayudar. ¡No se mienta a sí mismo!';

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
  String get testNotificationTitle => 'Notificación de Prueba';

  @override
  String get testNotificationBody => 'Esta es una notificación de prueba programada para aparecer 1 minuto después de la configuración';

  @override
  String get goodMorning => '¡Buenos Días!';

  @override
  String get middayCheckin => 'Registro del Mediodía';

  @override
  String get eveningUpdate => 'Actualización de la Tarde';

  @override
  String get nightlyReflection => 'Reflexión Nocturna';

  @override
  String get finalReminder => 'Recordatorio Final';

  @override
  String get morningHabitCheck => 'Hora de revisar tus hábitos del día';

  @override
  String get middayProgress => '¿Cómo van tus hábitos?';

  @override
  String get eveningReview => 'Hora de revisar tus hábitos diarios';

  @override
  String get dailyPerformance => '¿Cómo te fue con tus hábitos hoy?';

  @override
  String get lastChance => 'Última oportunidad para completar tus hábitos hoy';

  @override
  String progressComplete(Object progress) {
    return 'Progreso de hoy: $progress% completo';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed de $total hábitos realizados';
  }

  @override
  String get motivationStart => '¡Tú puedes! Empieza con un pequeño hábito.';

  @override
  String get motivationKeepGoing => '¡Sigue adelante! Cada hábito cuenta.';

  @override
  String get motivationGreatProgress => '¡Gran progreso! ¡Termina fuerte!';

  @override
  String get motivationAmazing => '¡Increíble! ¡Completaste todos tus hábitos hoy!';

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
}
