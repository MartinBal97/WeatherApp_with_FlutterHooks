import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/services/local_storage_service.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/theme_manager.dart';
import 'package:weatherapp_with_flutterhooks/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize dotenv
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final isDarkModeNotifier = ref.read(darkModeProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        final storedTheme = await LocalStorageService.loadIsDarkTheme();
        if (ref.read(darkModeProvider) != storedTheme) {
          isDarkModeNotifier.changeThemeMode(storedTheme);
        }
      });
      return null;
    }, const []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      home: HomeScreen(),
    );
  }
}
