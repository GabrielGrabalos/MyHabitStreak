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
  String get noDescription => 'Nenhuma descrição fornecida。';

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
  String get invalidHabitMessage => 'Por favor, verifique se o título do hábito não está vazio e é único。';

  @override
  String get deleteConfirmationTitle => 'Excluir Hábito?';

  @override
  String get deleteConfirmationMessage => 'Tem certeza de que deseja excluir este hábito? Esta ação não pode ser desfeita。';

  @override
  String get markDoneConfirmation => 'Marcar como feito?';

  @override
  String get markNotDoneConfirmation => 'Marcar como não feito?';

  @override
  String get markDoneMessage => 'Tem certeza de que deseja marcar este hábito como feito?\nLembre-se, estamos aqui para ajudar. Não minta para si!';

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
  String get notificationsTitle => 'Notificações';

  @override
  String get notificationsMessage => 'Permita-nos enviar notificações para ajudá-lo a nunca esquecer seus novos hábitos! Prometemos não abusar!';

  @override
  String get permanentlyDeniedMessage => 'Tem certeza que deseja negar permanentemente as notificações?';

  @override
  String get openSettings => 'Abrir Configurações';

  @override
  String get dontAskAgain => 'Não perguntar novamente';

  @override
  String notificationTitle(Object count) {
    return 'Você tem $count hábitos para completar';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '\"$habitName\" está esperando por você!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '\"$firstHabitName\" e \"$secondHabitName\" estão esperando por você!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, e mais $remainingCount estão esperando por você!';
  }

  @override
  String get countDownNotificationTitle => 'Seu tempo está se esgotando!';

  @override
  String get deleteHabitGroupTitle => 'Excluir Grupo?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Tem certeza de que deseja excluir o grupo \"$groupName\"? Não se preocupe, esta ação NÃO excluirá os hábitos dentro dele.';
  }

  @override
  String get all => 'Todos';

  @override
  String get notDone => 'Pendentes';

  @override
  String get done => 'Concluídos';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get invalidGroupTitle => 'Grupo Inválido';

  @override
  String get invalidGroupMessage => 'Por favor, forneça um nome único e válido para o grupo de hábitos.';

  @override
  String get groupTitle => 'Título do Grupo';

  @override
  String get editHabitGroup => 'Editar Grupo';

  @override
  String get createHabitGroup => 'Criar Grupo';

  @override
  String get selectHabits => 'Selecionar Hábitos:';

  @override
  String get create => 'Criar';

  @override
  String get update => 'Atualizar';

  @override
  String get habitSelected => 'selecionado';

  @override
  String get habitsSelected => 'selecionados';
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
  String get noDescription => 'Nenhuma descrição fornecida。';

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
  String get invalidHabitMessage => 'Por favor, verifique se o título do hábito não está vazio e é único。';

  @override
  String get deleteConfirmationTitle => 'Excluir Hábito?';

  @override
  String get deleteConfirmationMessage => 'Tem certeza de que deseja excluir este hábito? Esta ação não pode ser desfeita。';

  @override
  String get markDoneConfirmation => 'Marcar como feito?';

  @override
  String get markNotDoneConfirmation => 'Marcar como não feito?';

  @override
  String get markDoneMessage => 'Tem certeza de que deseja marcar este hábito como feito?\nLembre-se, estamos aqui para ajudar. Não minta para si!';

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
  String get notificationsTitle => 'Notificações';

  @override
  String get notificationsMessage => 'Permita-nos enviar notificações para ajudá-lo a nunca esquecer seus novos hábitos! Prometemos não abusar!';

  @override
  String get permanentlyDeniedMessage => 'Tem certeza que deseja negar permanentemente as notificações?';

  @override
  String get openSettings => 'Abrir Configurações';

  @override
  String get dontAskAgain => 'Não perguntar novamente';

  @override
  String notificationTitle(Object count) {
    return 'Você tem $count hábitos para completar';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '\"$habitName\" está esperando por você!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '\"$firstHabitName\" e \"$secondHabitName\" estão esperando por você!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, e mais $remainingCount estão esperando por você!';
  }

  @override
  String get countDownNotificationTitle => 'Seu tempo está se esgotando!';

  @override
  String get deleteHabitGroupTitle => 'Excluir Grupo?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Tem certeza de que deseja excluir o grupo \"$groupName\"? Não se preocupe, esta ação NÃO excluirá os hábitos dentro dele.';
  }

  @override
  String get all => 'Todos';

  @override
  String get notDone => 'Pendentes';

  @override
  String get done => 'Concluídos';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get invalidGroupTitle => 'Grupo Inválido';

  @override
  String get invalidGroupMessage => 'Por favor, forneça um nome único e válido para o grupo de hábitos.';

  @override
  String get groupTitle => 'Título do Grupo';

  @override
  String get editHabitGroup => 'Editar Grupo';

  @override
  String get createHabitGroup => 'Criar Grupo';

  @override
  String get selectHabits => 'Selecionar Hábitos:';

  @override
  String get create => 'Criar';

  @override
  String get update => 'Atualizar';

  @override
  String get habitSelected => 'selecionado';

  @override
  String get habitsSelected => 'selecionados';
}
