// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get language => '中文';

  @override
  String get idiom => '语言';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get appTitle => '我的习惯打卡';

  @override
  String get createHabit => '创建习惯';

  @override
  String get editHabit => '编辑习惯';

  @override
  String get habitTitle => '习惯标题';

  @override
  String get description => '描述';

  @override
  String get noDescription => '未提供描述。';

  @override
  String get saveHabit => '保存习惯';

  @override
  String get deleteHabit => '删除习惯';

  @override
  String get markDone => '标记为完成';

  @override
  String get markNotDone => '标记为未完成';

  @override
  String get streakHistory => '您的打卡历史';

  @override
  String get invalidHabit => '无效习惯';

  @override
  String get invalidHabitMessage => '请确保习惯标题不为空且唯一。';

  @override
  String get deleteConfirmationTitle => '删除习惯？';

  @override
  String get deleteConfirmationMessage => '确定要删除此习惯吗？此操作无法撤消。';

  @override
  String get markDoneConfirmation => '标记为完成？';

  @override
  String get markNotDoneConfirmation => '标记为未完成？';

  @override
  String get markDoneMessage => '确定要将此习惯标记为完成吗？\n记住，我们在此帮助您。不要欺骗自己！';

  @override
  String get markNotDoneMessage => '确定要将此习惯标记为未完成吗？';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get myHabits => '我的习惯';

  @override
  String get notDoneToday => '今日未完成';

  @override
  String get doneToday => '今日已完成';

  @override
  String get startCreating => '开始创建\n新习惯！';

  @override
  String get testNotificationTitle => '测试通知';

  @override
  String get testNotificationBody => '这是一个测试通知，将在设置后1分钟出现';

  @override
  String get goodMorning => '早上好！';

  @override
  String get middayCheckin => '中午检查';

  @override
  String get eveningUpdate => '晚间更新';

  @override
  String get nightlyReflection => '夜间反思';

  @override
  String get finalReminder => '最终提醒';

  @override
  String get morningHabitCheck => '该检查你今天的习惯了';

  @override
  String get middayProgress => '你的习惯进展如何？';

  @override
  String get eveningReview => '该回顾你的日常习惯了';

  @override
  String get dailyPerformance => '今天你的习惯完成得怎么样？';

  @override
  String get lastChance => '完成今天的习惯的最后机会';

  @override
  String progressComplete(Object progress) {
    return '今日进度：$progress% 完成';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '完成 $completed 个习惯，共 $total 个';
  }

  @override
  String get motivationStart => '你能行！从一个小的习惯开始。';

  @override
  String get motivationKeepGoing => '继续加油！每一个习惯都很重要。';

  @override
  String get motivationGreatProgress => '进展不错！坚持完成！';

  @override
  String get motivationAmazing => '太棒了！你今天完成了所有的习惯！';

  @override
  String get notificationsTitle => '通知';

  @override
  String get notificationsMessage => '请允许我们向您发送通知，帮助您永不忘记新习惯！我们保证不会滥用！';

  @override
  String get permanentlyDeniedMessage => '您确定要永久拒绝通知吗？';

  @override
  String get openSettings => '打开设置';

  @override
  String get dontAskAgain => '不再询问';
}
