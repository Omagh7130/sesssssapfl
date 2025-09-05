import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/models/user_progress.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressModel = Provider.of<ProgressModel>(context);
    final progress = progressModel.progress;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await progressModel.resetProgress();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress reset successfully')),
              );
            },
          ),
        ],
      ),
      body: progress == null
          ? const Center(
              child: Text(
                'No progress data available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                _buildProgressSummary(progress),
                const Divider(),
                Expanded(
                  child: _buildAnsweredList(progress),
                ),
              ],
            ),
    );
  }

  Widget _buildProgressSummary(UserProgress progress) {
    final totalQuestions = progress.answers.length;
    final correctAnswers = progress.answers.values
        .where((answer) => answer.isCorrect)
        .length;
    final percentage = totalQuestions > 0
        ? (correctAnswers / totalQuestions * 100).toStringAsFixed(1)
        : '0.0';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Overall Progress',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Total', totalQuestions.toString()),
              _buildStatCard('Correct', correctAnswers.toString()),
              _buildStatCard('Accuracy', '$percentage%'),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: totalQuestions > 0 ? correctAnswers / totalQuestions : 0,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildAnsweredList(UserProgress progress) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: progress.answers.length,
      itemBuilder: (context, index) {
        final questionId = progress.answers.keys.elementAt(index);
        final answer = progress.answers[questionId]!;
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: Text(questionId),
            subtitle: Text(
              'Answered: ${answer.selectedOption} on ${answer.answeredAt.toString().substring(0, 10)}',
            ),
            trailing: Icon(
              answer.isCorrect ? Icons.check_circle : Icons.cancel,
              color: answer.isCorrect ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }
}
```

### 11. Widgets

```dart