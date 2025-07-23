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
  String get markDoneMessage => 'この習慣を完了としてマークしますか？\nご注意ください、私たちはあなたを助けるためにここにいます。自分に嘘をつかないでください！';

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
  String get testNotificationTitle => 'テスト通知';

  @override
  String get testNotificationBody => 'これはセットアップ1分後に表示されるテスト通知です';

  @override
  String get goodMorning => 'おはようございます！';

  @override
  String get middayCheckin => '昼のチェックイン';

  @override
  String get eveningUpdate => '夕方の更新';

  @override
  String get nightlyReflection => '夜の振り返り';

  @override
  String get finalReminder => '最終リマインダー';

  @override
  String get morningHabitCheck => '今日の習慣を確認する時間です';

  @override
  String get middayProgress => '習慣の進捗はいかがですか？';

  @override
  String get eveningReview => '毎日の習慣を振り返る時間です';

  @override
  String get dailyPerformance => '今日の習慣はどうでしたか？';

  @override
  String get lastChance => '今日の習慣を完了する最後の機会です';

  @override
  String progressComplete(Object progress) {
    return '今日の進捗: $progress% 完了';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed/$total の習慣を完了';
  }

  @override
  String get motivationStart => 'あなたならできます！小さな習慣から始めましょう。';

  @override
  String get motivationKeepGoing => '続けてください！すべての習慣が重要です。';

  @override
  String get motivationGreatProgress => '素晴らしい進捗です！最後まで頑張ってください！';

  @override
  String get motivationAmazing => 'すごい！今日はすべての習慣を完了しました！';

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
}
