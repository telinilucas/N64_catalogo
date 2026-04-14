import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const N64CatalogApp(),
    ),
  );
}

class N64CatalogApp extends StatelessWidget {
  const N64CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N64 Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2A2A2A), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFE52521),
          secondary: const Color(0xFF008345),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}