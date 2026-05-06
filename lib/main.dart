// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Services/Logic_Impl.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>LogicImpl())
      ],
      child: const MyApp()));
}


