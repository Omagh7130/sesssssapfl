import 'package:shared_preferences/shared_preferences.dart';
import 'package:sesap_app/models/user_progress.dart';

class ProgressService {
  static const String _progressKey = 'user_progress';

  static Future<UserProgress?> getUserProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString(_progressKey);
    
    if (progressJson != null) {
      return UserProgress.fromJson(json.decode(progressJson));
    }
    return null;
  }

  static Future<void> saveUserProgress(UserProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, json.encode(progress.toJson()));
  }

  static Future<void> saveAnswer(
    String questionId,
    String selectedOption,
    bool isCorrect,
  ) async {
    final progress = await getUserProgress() ?? UserProgress(
      answers: {},
      lastAccessed: DateTime.now(),
    );

    progress.answers[questionId] = UserAnswer(
      selectedOption: selectedOption,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
    );
    progress.lastAccessed = DateTime.now();

    await saveUserProgress(progress);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
  }
}
```

### 5. Main App Setup

```dart