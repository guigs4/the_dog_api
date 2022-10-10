import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dog_app/view_models/dog_image_list_view_model.dart';

import 'Views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfffefdfd),
        appBarTheme: const AppBarTheme(
          color: Color(0xfffefdfd),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DogImageListViewModel(),
          ),
        ],
        child: const MainPage(
          title: 'bilonga',
        ),
      ),
    );
  }
}
