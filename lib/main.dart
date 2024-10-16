import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/cache/cache_helper.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheData.cacheInitialization();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider()..loadSettings(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      locale: Locale(provider.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: provider.themeMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
