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
  String get markDoneMessage => 'Вы уверены, что хотите отметить эту привычку как выполненную?\nПомните, мы здесь, чтобы помочь. Будьте честны с собой!';

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
  String get notificationsTitle => 'Уведомления';

  @override
  String get notificationsMessage => 'Разрешите нам отправлять уведомления, чтобы помочь вам не забывать о новых привычках! Обещаем не злоупотреблять!';

  @override
  String get permanentlyDeniedMessage => 'Вы уверены, что хотите навсегда отключить уведомления?';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get dontAskAgain => 'Не спрашивать снова';

  @override
  String notificationTitle(Object count) {
    return 'У вас есть $count привычек для выполнения';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '«$habitName» ждет выполнения!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '«$firstHabitName» и «$secondHabitName» ждут выполнения!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, и еще $remainingCount ждут выполнения!';
  }

  @override
  String get countDownNotificationTitle => 'Время истекает!';

  @override
  String get deleteHabitGroupTitle => 'Удалить Группу?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Вы уверены, что хотите удалить группу \"$groupName\"? Не волнуйтесь, это действие НЕ удалит привычки внутри нее.';
  }

  @override
  String get all => 'Все';

  @override
  String get notDone => 'Ожидающие';

  @override
  String get done => 'Выполненные';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get invalidGroupTitle => 'Неверная группа';

  @override
  String get invalidGroupMessage => 'Пожалуйста, укажите уникальное и допустимое название для группы привычек.';

  @override
  String get groupTitle => 'Название группы';

  @override
  String get editHabitGroup => 'Редактировать группу';

  @override
  String get createHabitGroup => 'Создать группу';

  @override
  String get selectHabits => 'Выбрать привычки:';

  @override
  String get create => '作成';

  @override
  String get update => '更新';

  @override
  String get habitSelected => '選択済み';

  @override
  String get habitsSelected => '選択済み';

  @override
  String get nothingMuchHere => 'Здесь ничего нет...';

  @override
  String get goToGroupAll => 'Перейти в \"Все\"';
}
