part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final String language;

  const LanguageState(this.language);

  @override
  List<Object?> get props => [language];
}
