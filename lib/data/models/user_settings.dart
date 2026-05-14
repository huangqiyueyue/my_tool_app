import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final bool darkMode;
  final String language;

  const UserSettings({
    this.darkMode = false,
    this.language = 'zh',
  });

  UserSettings copyWith({
    bool? darkMode,
    String? language,
  }) {
    return UserSettings(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [darkMode, language];
}
