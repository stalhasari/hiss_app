import 'package:flutter/material.dart';
import 'package:hiss_app/auth/spotify_auth.dart';
import 'package:hiss_app/pages/navigation_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // PageView controller
  final PageController _pageController = PageController();

  // Current page index
  int _currentPage = 0;

  // List of vector images to display
  final List<String> _vectorImages = [
    "lib/vectors/vector1.jpg",
    "lib/vectors/vector2.jpg",
    "lib/vectors/vector3.jpg",
  ];

  @override
  void initState() {
    super.initState();
    // Add a listener to the page controller
    _pageController.addListener(() {
      // Update the current page index when the page changes
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the page controller
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hiss',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Müziği Arkadaşlarınla Paylaş',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 100),
            // PageView widget to display vector images
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _vectorImages.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      'lib/vectors/vector1.jpg',
                      width: 300,
                      height: 300,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authenticate(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigationMenu()),
                  );
                } catch (e) {
                  debugPrint('Buton hatası: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Spotify ile Giriş Yap',
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loop through the vector images and create a dot for each one
                for (int i = 0; i < _vectorImages.length; i++)
                  Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Change the color of the dot according to the current page index
                      color: _currentPage == i ? Colors.purple : Colors.grey,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
