import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/screens/home_screen.dart';
import 'package:sesap_app/services/data_service.dart';
import 'package:sesap_app/services/progress_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load initial data
  final sesapData = await DataService.loadSesapData();
  final userProgress = await ProgressService.getUserProgress();
  
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: sesapData),
        ChangeNotifierProvider(
          create: (_) => ProgressModel(userProgress),
        ),
      ],
      child: const SesapApp(),
    ),
  );
}

class SesapApp extends StatelessWidget {
  const SesapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SESAP 17 Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      routes: {
        '/progress': (context) => const ProgressScreen(),
      },
    );
  }
}

class ProgressModel extends ChangeNotifier {
  UserProgress? _progress;
  
  ProgressModel(UserProgress? progress) {
    _progress = progress;
  }
  
  UserProgress? get progress => _progress;
  
  Future<void> saveAnswer(
    String questionId,
    String selectedOption,
    bool isCorrect,
  ) async {
    await ProgressService.saveAnswer(questionId, selectedOption, isCorrect);
    _progress = await ProgressService.getUserProgress();
    notifyListeners();
  }
  
  Future<void> resetProgress() async {
    await ProgressService.resetProgress();
    _progress = null;
    notifyListeners();
  }
}
```

### 6. Home Screen

```dart