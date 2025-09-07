import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 👇 Static constant data
  static const String title = "Welcome to My App";
  static const String description =
      "This is some static data for the Home Page.";
  static const List<String> features = [
    "🚀 Fast UI",
    "🎨 Beautiful Design",
    "⚡ Powered by Flutter"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          TextButton(
            onPressed: () {
              // 👇 Clear stack and go to login
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 20),
            const Text(
              "Features:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            ...features.map((item) => Text(item)).toList(),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                    child: const Text("Go to About Page"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: const Text("Go to Contact Page"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
