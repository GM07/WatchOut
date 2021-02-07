import 'package:flutter/material.dart';
import 'classes/client.dart';
import 'classes/file_handler.dart';
import 'routes/home.dart';
import 'theme.dart';
import 'routes/new_list.dart';
import 'package:camera/camera.dart';
import 'package:WatchOut/classes/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  Camera.mainCamera = cameras.first;

  await Client.openStorage();

  Client.items = (await loadJsonIngredients('assets/ingredients.json'));

  // print(Client.items);

  Client.addRandomLists();
  await Client.addListToBackup();

  await Client.loadListsFromBackup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WatchOut',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/new_list': (context) => NewList(),
      },
      theme: watchOutTheme,
    );
  }
}
