import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/services/firebase_service.dart';
import 'package:partyapp/viewmodels/auth_VM.dart';
import 'package:partyapp/viewmodels/login_VM.dart';
import 'package:partyapp/viewmodels/signup_VM.dart';
import 'package:partyapp/views/language_view.dart';
import 'package:partyapp/views/login_view.dart';
import 'package:partyapp/views/signup_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel(FirebaseService())),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Satoshi'),
        title: 'Flutter MVVM Demo',
        initialRoute: '/signup',
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/languageselection': (context) => GetStartedView(),
          // Add more routes as needed
        },
      ),
    );
  }
}
