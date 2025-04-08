import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
