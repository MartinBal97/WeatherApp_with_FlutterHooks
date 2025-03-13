import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_manager.g.dart';

@Riverpod(keepAlive: true)
class DarkMode extends _$DarkMode {
  @override
  bool build() => false;

  void changeThemeMode(bool storedTheme) => state = storedTheme;
}
