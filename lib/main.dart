import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const BoltaDibbaApp());
}

class BoltaDibbaApp extends StatelessWidget {
  const BoltaDibbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolta Dibba',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts tts = FlutterTts();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tts.setLanguage("hi-IN");
    tts.setSpeechRate(0.5);
  }

  void speak(String text) async {
    if (text.isNotEmpty) {
      await tts.speak(text);
    } else {
      await tts.speak("कृपया डिब्बा या ट्रेन नंबर दर्ज करें");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Bolta Dibba 🔊 ट्रेन बोलकर बताएगी"),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.train, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              "अपना ट्रेन और डिब्बा नंबर लिखें",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "जैसे: 12952 S-3",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.volume_up, size: 28),
              label: const Text(
                "बोलकर सुनाओ (Speak)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () => speak(controller.text),
            ),
          ],
        ),
      ),
    );
  }
}

