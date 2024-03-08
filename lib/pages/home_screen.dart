import 'package:flutter/material.dart';
import 'package:hiss_app/auth/spotify_auth.dart';
import 'package:hiss_app/view/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

YetkilendirmeSonuclari yetkilendirmeSonuclari = YetkilendirmeSonuclari();

class _HomeScreenState extends State<HomeScreen> {
  String displayName = '';

  @override
  void initState() {
    super.initState();
    loadDisplayName();
  }

  Future<void> loadDisplayName() async {
    displayName = (await yetkilendirmeSonuclari.getCurrentUserProfile())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE9EFF),
        title: Text('Hoş Geldin $displayName!'),
      ),
      body: const MapScreen(),
    );
  }
}
