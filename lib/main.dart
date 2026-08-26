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
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const GoogleSignInScreen(),
    );
  }
}

// 1. Home Screen - Google Sign-In Button First
class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.train, size: 70, color: Colors.amber),
                    SizedBox(height: 15),
                    Text(
                      "Bolta Dibba",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Welcome! Please sign in to continue",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 30),
              // Google Sign-In Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.g_mobiledata, size: 36, color: Colors.indigo),
                label: const Text(
                  "Continue with Google",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "100% Privacy Secure • Fast & Reliable",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Language Selection Screen with Text-to-Speech
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String selectedLanguage = "Not Selected";

  final List<Map<String, String>> languages = [
    {"name": "Hindi (हिन्दी)", "code": "hi-IN", "speak": "You have selected Hindi."},
    {"name": "Rajasthani (राजस्थानी)", "code": "hi-IN", "speak": "You have selected Rajasthani."},
    {"name": "Bengali (বাংলা)", "code": "bn-IN", "speak": "You have selected Bengali."},
    {"name": "Marathi (मराठी)", "code": "mr-IN", "speak": "You have selected Marathi."},
    {"name": "Gujarati (ગુજરાતી)", "code": "gu-IN", "speak": "You have selected Gujarati."},
    {"name": "English (Global)", "code": "en-US", "speak": "You have selected English."},
  ];

  Future<void> speakText(String text, String langCode) async {
    await flutterTts.setLanguage(langCode);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Language"),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language, color: Colors.black87),
                  const SizedBox(width: 10),
                  Text(
                    "Selected: $selectedLanguage",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF1E293B),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(
                        languages[index]["name"]!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.volume_up, size: 20, color: Colors.amber),
                      onTap: () {
                        setState(() {
                          selectedLanguage = languages[index]["name"]!;
                        });
                        
                        speakText(languages[index]["speak"]!, languages[index]["code"]!);

                        Future.delayed(const Duration(seconds: 1), () {
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TrainSearchScreen(langCode: languages[index]["code"]!)),
                            );
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Train Search Screen with Text-to-Speech
class TrainSearchScreen extends StatefulWidget {
  final String langCode;
  const TrainSearchScreen({super.key, required this.langCode});

  @override
  State<TrainSearchScreen> createState() => _TrainSearchScreenState();
}

class _TrainSearchScreenState extends State<TrainSearchScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController trainController = TextEditingController();

  Future<void> speakDetails(String text) async {
    await flutterTts.setLanguage(widget.langCode);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bolta Dibba 🔊"),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Train Number or Name",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: trainController,
                    decoration: InputDecoration(
                      hintText: "e.g., 12952 (Avantika Express)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleForm(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 52),
              ),
              icon: const Icon(Icons.volume_up),
              label: const Text(
                "Search Coach & Speak",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                String trainInfo = trainController.text;
                if (trainInfo.isEmpty) {
                  trainInfo = "Please enter a valid train number.";
                } else {
                  trainInfo = "Searching coach details for train number $trainInfo.";
                }
                speakDetails(trainInfo);
              },
            ),
          ],
        ),
      ),
    );
  }
}

