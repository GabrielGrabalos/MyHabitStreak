// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get language => 'Português';

  @override
  String get idiom => 'Idioma';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get appTitle => 'Meus Hábitos';

  @override
  String get createHabit => 'Criar Hábito';

  @override
  String get editHabit => 'Editar Hábito';

  @override
  String get habitTitle => 'Título do Hábito';

  @override
  String get description => 'Descrição';

  @override
  String get noDescription => 'Nenhuma descrição fornecida.';

  @override
  String get saveHabit => 'Salvar Hábito';

  @override
  String get deleteHabit => 'Excluir Hábito';

  @override
  String get markDone => 'Marcar como feito';

  @override
  String get markNotDone => 'Marcar como não feito';

  @override
  String get streakHistory => 'Seu histórico de sequências';

  @override
  String get invalidHabit => 'Hábito Inválido';

  @override
  String get invalidHabitMessage => 'Por favor, verifique se o título do hábito não está vazio e é único.';

  @override
  String get deleteConfirmationTitle => 'Excluir Hábito?';

  @override
  String get deleteConfirmationMessage => 'Tem certeza de que deseja excluir este hábito? Esta ação não pode ser desfeita.';

  @override
  String get markDoneConfirmation => 'Marcar como feito?';

  @override
  String get markNotDoneConfirmation => 'Marcar como não feito?';

  @override
  String get markDoneMessage => 'Tem certeza de que deseja marcar este hábito como feito?\nLembre-se, estamos aqui para ajudar. Não minta para si mesmo!';

  @override
  String get markNotDoneMessage => 'Tem certeza de que deseja marcar este hábito como não feito?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get myHabits => 'Meus Hábitos';

  @override
  String get notDoneToday => 'Não Feito Hoje';

  @override
  String get doneToday => 'Feito Hoje';

  @override
  String get startCreating => 'Comece criando\num novo hábito!';

  @override
  String get testNotificationTitle => 'Notificação de Teste';

  @override
  String get testNotificationBody => 'Esta é uma notificação de teste agendada para aparecer 1 minuto após a configuração';

  @override
  String get goodMorning => 'Bom Dia!';

  @override
  String get middayCheckin => 'Check-in do Meio Dia';

  @override
  String get eveningUpdate => 'Atualização da Tarde';

  @override
  String get nightlyReflection => 'Reflexão Noturna';

  @override
  String get finalReminder => 'Lembrete Final';

  @override
  String get morningHabitCheck => 'Hora de verificar seus hábitos do dia';

  @override
  String get middayProgress => 'Como estão seus hábitos?';

  @override
  String get eveningReview => 'Hora de revisar seus hábitos diários';

  @override
  String get dailyPerformance => 'Como você foi com seus hábitos hoje?';

  @override
  String get lastChance => 'Última chance para completar seus hábitos hoje';

  @override
  String progressComplete(Object progress) {
    return 'Progresso de hoje: $progress% completo';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed de $total hábitos concluídos';
  }

  @override
  String get motivationStart => 'Você consegue! Comece com um pequeno hábito.';

  @override
  String get motivationKeepGoing => 'Continue! Cada hábito conta.';

  @override
  String get motivationGreatProgress => 'Ótimo progresso! Termine com força!';

  @override
  String get motivationAmazing => 'Incrível! Você completou todos os seus hábitos hoje!';

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get notificationsMessage => 'Permita-nos enviar notificações para ajudá-lo a nunca esquecer seus novos hábitos! Prometemos não abusar!';

  @override
  String get permanentlyDeniedMessage => 'Tem certeza que deseja negar permanentemente as notificações?';

  @override
  String get openSettings => 'Abrir Configurações';

  @override
  String get dontAskAgain => 'Não perguntar novamente';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr(): super('pt_BR');

  @override
  String get language => 'Português';

  @override
  String get idiom => 'Idioma';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get appTitle => 'Minha Sequência de Hábitos';

  @override
  String get createHabit => 'Criar Hábito';

  @override
  String get editHabit => 'Editar Hábito';

  @override
  String get habitTitle => 'Título do Hábito';

  @override
  String get description => 'Descrição';

  @override
  String get noDescription => 'Nenhuma descrição fornecida.';

  @override
  String get saveHabit => 'Salvar Hábito';

  @override
  String get deleteHabit => 'Excluir Hábito';

  @override
  String get markDone => 'Marcar como feito';

  @override
  String get markNotDone => 'Marcar como não feito';

  @override
  String get streakHistory => 'Histórico de sequências';

  @override
  String get invalidHabit => 'Hábito Inválido';

  @override
  String get invalidHabitMessage => 'Por favor, verifique se o título do hábito não está vazio e é único.';

  @override
  String get deleteConfirmationTitle => 'Excluir Hábito?';

  @override
  String get deleteConfirmationMessage => 'Tem certeza de que deseja excluir este hábito? Esta ação não pode ser desfeita.';

  @override
  String get markDoneConfirmation => 'Marcar como feito?';

  @override
  String get markNotDoneConfirmation => 'Marcar como não feito?';

  @override
  String get markDoneMessage => 'Tem certeza de que deseja marcar este hábito como feito?\nLembre-se, estamos aqui para ajudar. Não minta para si mesmo!';

  @override
  String get markNotDoneMessage => 'Tem certeza de que deseja marcar este hábito como não feito?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get myHabits => 'Meus Hábitos';

  @override
  String get notDoneToday => 'Não Feito Hoje';

  @override
  String get doneToday => 'Feito Hoje';

  @override
  String get startCreating => 'Comece criando\num novo hábito!';

  @override
  String get testNotificationTitle => 'Notificação de Teste';

  @override
  String get testNotificationBody => 'Esta é uma notificação de teste agendada para aparecer 1 minuto após a configuração';

  @override
  String get goodMorning => 'Bom Dia!';

  @override
  String get middayCheckin => 'Check-in do Meio Dia';

  @override
  String get eveningUpdate => 'Atualização da Tarde';

  @override
  String get nightlyReflection => 'Reflexão Noturna';

  @override
  String get finalReminder => 'Lembrete Final';

  @override
  String get morningHabitCheck => 'Hora de verificar seus hábitos do dia';

  @override
  String get middayProgress => 'Como estão seus hábitos?';

  @override
  String get eveningReview => 'Hora de revisar seus hábitos diários';

  @override
  String get dailyPerformance => 'Como você foi com seus hábitos hoje?';

  @override
  String get lastChance => 'Última chance para completar seus hábitos hoje';

  @override
  String progressComplete(Object progress) {
    return 'Progresso de hoje: $progress% completo';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed de $total hábitos concluídos';
  }

  @override
  String get motivationStart => 'Você consegue! Comece com um pequeno hábito.';

  @override
  String get motivationKeepGoing => 'Continue! Cada hábito conta.';

  @override
  String get motivationGreatProgress => 'Ótimo progresso! Termine com força!';

  @override
  String get motivationAmazing => 'Incrível! Você completou todos os seus hábitos hoje!';

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get notificationsMessage => 'Permita-nos enviar notificações para ajudá-lo a nunca esquecer seus novos hábitos! Prometemos não abusar!';

  @override
  String get permanentlyDeniedMessage => 'Tem certeza que deseja negar permanentemente as notificações?';

  @override
  String get openSettings => 'Abrir Configurações';

  @override
  String get dontAskAgain => 'Não perguntar novamente';
}
