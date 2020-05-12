import 'package:flutter/material.dart';
import 'screenhome.dart';
import 'screenuserhandler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'EazyAuth',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.black,
          appBarTheme: ThemeData.light()
              .appBarTheme
              .copyWith(color: ThemeData.light().scaffoldBackgroundColor)),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          appBarTheme: ThemeData.dark()
              .appBarTheme
              .copyWith(color: ThemeData.dark().scaffoldBackgroundColor)),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomeScreen());
            break;
          case '/userhandler':
            return MaterialPageRoute(builder: (context) => UserHandlerScreen());
            break;
          default:
            return null;
            break;
        }
      },
    ),
  );
}
