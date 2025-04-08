import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial(languageCode: 'en'));

  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeLanguage) {
      yield LanguageInitial(languageCode: event.languageCode);
    }
  }
}
