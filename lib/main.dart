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
        primaryColor: const Color(0xFF1A2B4C),
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
      ),
      home: const LoginScreen(),
    );
  }
}

// 1. पहली स्क्रीन: सुरक्षित लॉगिन और ब्रांडिंग
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2B4C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.train, size: 60, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'बोलता डिब्बा',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Icon(Icons.security, size: 80, color: Color(0xFF2A52BE)),
              const SizedBox(height: 20),
              const Text(
                'स्वागत है!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A2B4C)),
              ),
              const SizedBox(height: 8),
              const Text(
                'सुरक्षित लॉगिन के लिए',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // गूगल लॉगिन के बाद भाषा चयन स्क्रीन पर जाएं
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2B4C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text('Continue with Google (Gmail)', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              const Text(
                '100% प्राइवेसी सुरक्षित • नो डेटा मिक्स',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. भाषा चयन स्क्रीन (सभी भारतीय भाषाओं के साथ)
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> languages = [
    {'name': 'हिंदी (Hindi)', 'code': 'hi-IN', 'welcome': 'आपकी भाषा सफलतापूर्वक सेट हो गई है। वेलकम बोलता डिब्बा।'},
    {'name': 'മലയാളം (Malayalam)', 'code': 'ml-IN', 'welcome': 'നിങ്ങളുടെ ഭാഷ വിജയകരമായി സജ്ജീകരിച്ചിരിക്കുന്നു. വെൽക്കം ബോൾട്ട ഡിബ്ബ.'},
    {'name': 'বাংলা (Bengali)', 'code': 'bn-IN', 'welcome': 'আপনার ভাষা সফলভাবে সেট করা হয়েছে। ওয়েলকাম বোলতা ডিব্বা।'},
    {'name': 'मराठी (Marathi)', 'code': 'mr-IN', 'welcome': 'तुमची भाषा यशस्वीपणे सेट केली आहे. वेलकम बोलता डिब्बा.'},
    {'name': 'ગુજરાતી (Gujarati)', 'code': 'gu-IN', 'welcome': 'તમારી ભાષા સફળતાપૂર્વક સેટ થઈ ગઈ છે. વેલકમ બોલતા ડિબ્બા.'},
    {'name': 'राजस्थानी (Rajasthani/Hindi)', 'code': 'hi-IN', 'welcome': 'थारी भाषा सफलतासू सेट हो गी है। वेलकम बोलता डिब्बा।'},
    {'name': 'English', 'code': 'en-US', 'welcome': 'Your language has been successfully set. Welcome Bolta Dibba.'},
  ];

  Future<void> selectLanguage(String langCode, String welcomeMessage) async {
    await flutterTts.setLanguage(langCode);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(welcomeMessage);

    // अगले होम स्क्रीन पर बढ़ें
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('भाषा चुनें / Select Language'),
        backgroundColor: const Color(0xFF1A2B4C),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                languages[index]['name']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1A2B4C)),
              onTap: () {
                selectLanguage(languages[index]['code']!, languages[index]['welcome']!);
              },
            ),
          );
        },
      ),
    );
  }
}

// 3. मुख्य होम स्क्रीन (ट्रेन नंबर दर्ज करने के लिए)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2B4C),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('बोलता डिब्बा'),
            SizedBox(width: 8),
            Icon(Icons.volume_up, color: Colors.amber),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2B4C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ट्रेन नंबर या नाम दर्ज करें',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'उदा. 12952 (अवन्तििका एक्सप्रेस)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2B4C),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
              ),
              icon: const Icon(Icons.volume_up),
              label: const Text('डिब्बा खोजें (खोलें)', style: TextStyle(fontSize: 18)),
            ),
            const Spacer(),
            const Text(
              'भरोसेमंद अपडेट, 24x7',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
          ),
        ),
      ),
    );
  }
}



