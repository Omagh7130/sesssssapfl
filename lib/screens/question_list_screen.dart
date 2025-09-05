import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/models/sesap_model.dart';
import 'package:sesap_app/models/user_progress.dart';
import 'package:sesap_app/screens/question_detail_screen.dart';

class QuestionListScreen extends StatelessWidget {
  final String volumeKey;
  final String partKey;
  final List<Question> questions;

  const QuestionListScreen({
    super.key,
    required this.volumeKey,
    required this.partKey,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$volumeKey > $partKey'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final questionId = '${volumeKey}_${partKey}_${question.itemNumber}';
          final userAnswer = progressModel.progress?.answers[questionId];
          
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              title: Text('Question ${question.itemNumber}'),
              subtitle: userAnswer != null
                  ? Text(
                      'Answered: ${userAnswer.selectedOption} ${userAnswer.isCorrect ? '✓' : '✗'}',
                      style: TextStyle(
                        color: userAnswer.isCorrect ? Colors.green : Colors.red,
                      ),
                    )
                  : const Text('Not answered'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionDetailScreen(
                      volumeKey: volumeKey,
                      partKey: partKey,
                      question: question,
                      questionId: questionId,
                      userAnswer: userAnswer,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

### 9. Question Detail Screen

```dart