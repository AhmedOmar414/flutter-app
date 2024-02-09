import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToMainScreen();
  }

  Future<void> navigateToMainScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images2/1024.png'), // Replace with your logo
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),          
          ],
        ),
      ),
    );
  }
}