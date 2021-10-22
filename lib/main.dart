import 'package:flutter/material.dart';
import 'package:movie_db_provider/Data/model/user_table.dart';
import 'package:movie_db_provider/Provider/movies_provider.dart';
import 'package:movie_db_provider/Screens/home_screen/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserTableAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (_) => MovieProvider(),
          child: const HomeScreen(userName: "Shaan")),
    );
  }
}
