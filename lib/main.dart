import 'package:flutter/material.dart';
import 'package:hiss_app/api_client.dart';
import 'package:hiss_app/pages/navigation_menu.dart';

void main() async {
  runApp(const MyApp());
}

final spotifyUserService = spotifyApiGateway.userClient;
final authClient = spotifyApiGateway.authClient;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const NavigationMenu(),
    );
  }
}
