// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Русский';

  @override
  String get idiom => 'Язык';

  @override
  String get privacyPolicy => 'Политика Конфиденциальности';

  @override
  String get appTitle => 'Мой Трекер Привычек';

  @override
  String get createHabit => 'Создать Привычку';

  @override
  String get editHabit => 'Редактировать Привычку';

  @override
  String get habitTitle => 'Название Привычки';

  @override
  String get description => 'Описание';

  @override
  String get noDescription => 'Описание отсутствует.';

  @override
  String get saveHabit => 'Сохранить Привычку';

  @override
  String get deleteHabit => 'Удалить Привычку';

  @override
  String get markDone => 'Отметить как выполненное';

  @override
  String get markNotDone => 'Отметить как невыполненное';

  @override
  String get streakHistory => 'История ваших серий';

  @override
  String get invalidHabit => 'Недействительная Привычка';

  @override
  String get invalidHabitMessage => 'Пожалуйста, убедитесь, что название привычки не пустое и уникальное.';

  @override
  String get deleteConfirmationTitle => 'Удалить Привычку?';

  @override
  String get deleteConfirmationMessage => 'Вы уверены, что хотите удалить эту привычку? Это действие нельзя отменить.';

  @override
  String get markDoneConfirmation => 'Отметить как выполненное?';

  @override
  String get markNotDoneConfirmation => 'Отметить как невыполненное?';

  @override
  String get markDoneMessage => 'Вы уверены, что хотите отметить эту привычку как выполненную?\nПомните, мы здесь, чтобы помочь. Не обманывайте себя!';

  @override
  String get markNotDoneMessage => 'Вы уверены, что хотите отметить эту привычку как невыполненную?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get myHabits => 'Мои Привычки';

  @override
  String get notDoneToday => 'Не Выполнено Сегодня';

  @override
  String get doneToday => 'Выполнено Сегодня';

  @override
  String get startCreating => 'Начните с создания\nновой привычки!';

  @override
  String get testNotificationTitle => 'Тестовое уведомление';

  @override
  String get testNotificationBody => 'Это тестовое уведомление появится через 1 минуту после настройки';

  @override
  String get goodMorning => 'Доброе утро!';

  @override
  String get middayCheckin => 'Проверка в полдень';

  @override
  String get eveningUpdate => 'Вечернее обновление';

  @override
  String get nightlyReflection => 'Вечерняя рефлексия';

  @override
  String get finalReminder => 'Последнее напоминание';

  @override
  String get morningHabitCheck => 'Пора проверить ваши привычки на день';

  @override
  String get middayProgress => 'Как продвигаются ваши привычки?';

  @override
  String get eveningReview => 'Пора пересмотреть ваши ежедневные привычки';

  @override
  String get dailyPerformance => 'Как у вас сегодня с привычками?';

  @override
  String get lastChance => 'Последний шанс выполнить ваши привычки сегодня';

  @override
  String progressComplete(Object progress) {
    return 'Сегодняшний прогресс: $progress% завершено';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed из $total привычек выполнено';
  }

  @override
  String get motivationStart => 'У вас получится! Начните с одной маленькой привычки.';

  @override
  String get motivationKeepGoing => 'Продолжайте! Каждая привычка имеет значение.';

  @override
  String get motivationGreatProgress => 'Отличный прогресс! Заканчивайте сильно!';

  @override
  String get motivationAmazing => 'Удивительно! Вы выполнили все свои привычки сегодня!';

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get notificationsMessage => 'Разрешите нам отправлять уведомления, чтобы помочь вам не забывать о новых привычках! Обещаем не злоупотреблять!';

  @override
  String get permanentlyDeniedMessage => 'Вы уверены, что хотите навсегда отключить уведомления?';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get dontAskAgain => 'Не спрашивать снова';
}
