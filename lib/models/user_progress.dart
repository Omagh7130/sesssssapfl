class UserProgress {
  final Map<String, UserAnswer> answers;
  final DateTime lastAccessed;

  UserProgress({required this.answers, required this.lastAccessed});

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    Map<String, UserAnswer> answersMap = {};
    if (json['answers'] != null) {
      json['answers'].forEach((key, value) {
        answersMap[key] = UserAnswer.fromJson(value);
      });
    }
    return UserProgress(
      answers: answersMap,
      lastAccessed: DateTime.parse(json['lastAccessed']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': answers.map((key, value) => MapEntry(key, value.toJson())),
      'lastAccessed': lastAccessed.toIso8601String(),
    };
  }
}

class UserAnswer {
  final String selectedOption;
  final bool isCorrect;
  final DateTime answeredAt;

  UserAnswer({
    required this.selectedOption,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory UserAnswer.fromJson(Map<String, dynamic> json) {
    return UserAnswer(
      selectedOption: json['selectedOption'],
      isCorrect: json['isCorrect'],
      answeredAt: DateTime.parse(json['answeredAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedOption': selectedOption,
      'isCorrect': isCorrect,
      'answeredAt': answeredAt.toIso8601String(),
    };
  }
}
```

### 3. Data Service

```dart