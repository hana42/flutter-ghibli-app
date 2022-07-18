import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/pages/auth_gate.dart';
import 'package:ghibli/pages/home_page.dart';
import 'package:ghibli/pages/profile_page.dart';
import 'package:ghibli/utils/custom_theme.dart';
import 'package:ghibli/firebase_options.dart';
import 'package:ghibli/utils/utils.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ghibli/models/movie_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.openBox('userMovies');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils().messengerKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => AuthGate(),
        '/home': (_) => const HomePage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
