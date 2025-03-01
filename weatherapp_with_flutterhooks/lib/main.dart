import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weatherapp_with_flutterhooks/core/constants/sizes.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/theme_manager.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      home: Scaffold(
        drawer: DrawerHomeScreen(),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

class DrawerHomeScreen extends HookConsumerWidget {
  const DrawerHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryContainer,
            ),
            child: Text('Hello User!', style: context.s20w6),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          gapH64,
          ListTile(
            title: Text('Change Theme'),
            onTap: () {
              log('message');
              ref.read(darkModeProvider.notifier).changeThemeMode();
            },
          ),
        ],
      ),
    );
  }
}
