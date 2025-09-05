import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/models/sesap_model.dart';
import 'package:sesap_app/models/user_progress.dart';
import 'package:sesap_app/widgets/answer_option.dart';

class QuestionDetailScreen extends StatefulWidget {
  final String volumeKey;
  final String partKey;
  final Question question;
  final String questionId;
  final UserAnswer? userAnswer;

  const QuestionDetailScreen({
    super.key,
    required this.volumeKey,
    required this.partKey,
    required this.question,
    required this.questionId,
    this.userAnswer,
  });

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  String? selectedOption;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    if (widget.userAnswer != null) {
      selectedOption = widget.userAnswer!.selectedOption;
      showFeedback = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${widget.question.itemNumber}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.question.scenario != null) ...[
              const Text(
                'Scenario:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                widget.question.scenario!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'Question:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.question.question,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Options:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...widget.question.options.entries.map((entry) {
              return AnswerOption(
                optionKey: entry.key,
                optionText: entry.value,
                isSelected: selectedOption == entry.key,
                isCorrect: widget.question.correctAnswer == entry.key,
                showFeedback: showFeedback,
                onTap: !showFeedback
                    ? () {
                        setState(() {
                          selectedOption = entry.key;
                        });
                      }
                    : null,
              );
            }).toList(),
            const SizedBox(height: 24),
            if (!showFeedback)
              Center(
                child: ElevatedButton(
                  onPressed: selectedOption == null
                      ? null
                      : () {
                          setState(() {
                            showFeedback = true;
                          });
                          progressModel.saveAnswer(
                            widget.questionId,
                            selectedOption!,
                            selectedOption == widget.question.correctAnswer,
                          );
                        },
                  child: const Text('Submit Answer'),
                ),
              ),
            if (showFeedback) ...[
              const Text(
                'Feedback:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selectedOption == widget.question.correctAnswer
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your answer: ${selectedOption}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedOption == widget.question.correctAnswer
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    if (selectedOption != widget.question.correctAnswer)
                      Text(
                        'Correct answer: ${widget.question.correctAnswer}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Explanation:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                widget.question.explanation ?? 'No explanation available.',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

### 10. Progress Screen

```dart