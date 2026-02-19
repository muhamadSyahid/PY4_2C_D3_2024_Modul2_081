import 'package:flutter/material.dart';
import 'package:logbook_app_081/features/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int step = 0;
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/34541940.jpg',
      'text':
          'Selamat datang di Aplikasi Logbook! Catat setiap progresmu dengan mudah.',
    },
    {
      'image': 'assets/dkr6f7i-c937ac76-01a5-4a1d-87ad-50e6aba58df3.png',
      'text': 'Pantau riwayat aktivitasmu setiap hari tanpa ribet.',
    },
    {
      'image': 'assets/photo_2025-09-14_23-46-09.jpg',
      'text': 'Mulai perjalanan produktivitasmu sekarang juga!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Halaman Onboarding",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Image.asset(
                onboardingData[step]['image']!,
                height: 300,
              ),
              const SizedBox(height: 20),
              Text(
                onboardingData[step]['text']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingData.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: step == index ? 12 : 8,
                    height: step == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: step == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              // Tombol Navigasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (step > 0)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          step--;
                        });
                      },
                      child: const Text("Kembali"),
                    )
                  else
                    const SizedBox(
                        width: 80), // Placeholder agar layout seimbang
                  ElevatedButton(
                    onPressed: () async {
                      if (step < onboardingData.length - 1) {
                        setState(() {
                          step++;
                        });
                      } else {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('is_onboarding_done', true);
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        }
                      }
                    },
                    child: Text(
                        step == onboardingData.length - 1 ? "Mulai" : "Lanjut"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
