// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get language => '日本語';

  @override
  String get idiom => '言語';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get appTitle => 'マイ習慣ストリーク';

  @override
  String get createHabit => '習慣を作成';

  @override
  String get editHabit => '習慣を編集';

  @override
  String get habitTitle => '習慣のタイトル';

  @override
  String get description => '説明';

  @override
  String get noDescription => '説明がありません。';

  @override
  String get saveHabit => '習慣を保存';

  @override
  String get deleteHabit => '習慣を削除';

  @override
  String get markDone => '完了としてマーク';

  @override
  String get markNotDone => '未完了としてマーク';

  @override
  String get streakHistory => 'ストリーク履歴';

  @override
  String get invalidHabit => '無効な習慣';

  @override
  String get invalidHabitMessage => '習慣のタイトルが空でなく、一意であることを確認してください。';

  @override
  String get deleteConfirmationTitle => '習慣を削除しますか？';

  @override
  String get deleteConfirmationMessage => 'この習慣を削除してもよろしいですか？この操作は元に戻せません。';

  @override
  String get markDoneConfirmation => '完了としてマークしますか？';

  @override
  String get markNotDoneConfirmation => '未完了としてマークしますか？';

  @override
  String get markDoneMessage => 'この習慣を完了としてマークしますか？\n覚えておいてください、私たちはサポートします。自分に正直になりましょう！';

  @override
  String get markNotDoneMessage => 'この習慣を未完了としてマークしますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get myHabits => 'マイ習慣';

  @override
  String get notDoneToday => '今日未完了';

  @override
  String get doneToday => '今日完了';

  @override
  String get startCreating => '新しい習慣を\n作成しましょう！';

  @override
  String get notificationsTitle => '通知';

  @override
  String get notificationsMessage => '新しい習慣を忘れないように通知を送信することを許可してください！乱用しないことを約束します！';

  @override
  String get permanentlyDeniedMessage => '通知を永久に拒否してもよろしいですか？';

  @override
  String get openSettings => '設定を開く';

  @override
  String get dontAskAgain => '再び確認しない';

  @override
  String notificationTitle(Object count) {
    return '完了する習慣が$count個あります';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '「$habitName」が完了待ちです！';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '「$firstHabitName」と「$secondHabitName」が完了待ちです！';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames、あと$remainingCount個の習慣が完了待ちです！';
  }

  @override
  String get countDownNotificationTitle => '時間がなくなりつつあります！';

  @override
  String get deleteHabitGroupTitle => 'グループを削除しますか？';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'グループ「$groupName」を削除してもよろしいですか？ご安心ください、この操作で中の習慣は削除されません。';
  }

  @override
  String get all => 'すべて';

  @override
  String get notDone => '未完了';

  @override
  String get done => '完了';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get invalidGroupTitle => '無効なグループ';

  @override
  String get invalidGroupMessage => '習慣グループに固有で有効な名前を入力してください。';

  @override
  String get groupTitle => 'グループタイトル';

  @override
  String get editHabitGroup => 'グループを編集';

  @override
  String get createHabitGroup => 'グループを作成';

  @override
  String get selectHabits => '習慣を選択:';

  @override
  String get create => '作成';

  @override
  String get update => '更新';

  @override
  String get habitSelected => '選択済み';

  @override
  String get habitsSelected => '選択済み';

  @override
  String get nothingMuchHere => 'ここには何もありません...';

  @override
  String get goToGroupAll => '「すべて」に移動';
}
