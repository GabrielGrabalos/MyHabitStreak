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
  String get markDoneMessage => '确定要将此习惯标记为完成吗？\n记住，我们在此帮助您。请对自己诚实！';

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
  String get notificationsTitle => '通知';

  @override
  String get notificationsMessage => '请允许我们向您发送通知，帮助您永不忘记新习惯！我们保证不会滥用！';

  @override
  String get permanentlyDeniedMessage => '您确定要永久拒绝通知吗？';

  @override
  String get openSettings => '打开设置';

  @override
  String get dontAskAgain => '不再询问';

  @override
  String notificationTitle(Object count) {
    return '您有$count个习惯需要完成';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '「$habitName」正在等待完成！';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '「$firstHabitName」和「$secondHabitName」正在等待完成！';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames，还有$remainingCount个习惯正在等待完成！';
  }

  @override
  String get countDownNotificationTitle => '时间不多了！';

  @override
  String get deleteHabitGroupTitle => '删除分组？';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return '确定要删除分组「$groupName」吗？请放心，此操作不会删除其中的习惯。';
  }

  @override
  String get all => '全部';

  @override
  String get notDone => '未完成';

  @override
  String get done => '已完成';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get invalidGroupTitle => '无效分组';

  @override
  String get invalidGroupMessage => '请为习惯分组提供一个唯一且有效的名称。';

  @override
  String get groupTitle => '分组标题';

  @override
  String get editHabitGroup => '编辑分组';

  @override
  String get createHabitGroup => '创建分组';
}
