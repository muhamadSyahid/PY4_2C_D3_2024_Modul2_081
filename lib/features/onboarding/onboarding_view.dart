import 'package:flutter/material.dart';
import 'package:logbook_app_081/features/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int step = 1;
  final List<String> images = [
    'assets/34541940.jpg',
    'assets/dkr6f7i-c937ac76-01a5-4a1d-87ad-50e6aba58df3.png',
    'assets/photo_2025-09-14_23-46-09.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Halaman Onboarding"),
            Image.asset(
              images[step - 1],
              height: 300,
            ),
            IconButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('is_onboarding_done', true);
                  setState(() {
                    step++;
                    if (step > 3) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    }
                  });
                },
                icon: Text("Lanjut"))
          ],
        ),
      ),
    );
  }
}
