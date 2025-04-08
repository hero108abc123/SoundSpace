import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {
  final String languageCode;

  LanguageInitial({this.languageCode = 'en'});

  @override
  List<Object?> get props => [languageCode];
}
