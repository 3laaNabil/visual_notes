import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/business%20_logic/add_visual_cubit.dart';
import 'package:visual_notes/constants/Colors.dart';
import 'package:visual_notes/ui/Screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddVisualCubit()..getNotes(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,

        home: HomeScreen(),
      ),
    );
  }
}
