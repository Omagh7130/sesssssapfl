import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/models/user_progress.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final ProgressModel progressModel;

  const ProgressIndicatorWidget({super.key, required this.progressModel});

  @override
  Widget build(BuildContext context) {
    final progress = progressModel.progress;
    
    if (progress == null) {
      return const SizedBox.shrink();
    }

    final totalQuestions = progress.answers.length;
    final correctAnswers = progress.answers.values
        .where((answer) => answer.isCorrect)
        .length;
    final percentage = totalQuestions > 0
        ? (correctAnswers / totalQuestions * 100).toStringAsFixed(1)
        : '0.0';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Progress',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('$percentage% correct'),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: totalQuestions > 0 ? correctAnswers / totalQuestions : 0,
            minHeight: 6,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}
```

### 12. Setup Instructions

1. **Create a new Flutter project**:
   ```bash
   flutter create sesap_app
   cd sesap_app
   ```

2. **Add dependencies** to `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     provider: ^6.0.5
     shared_preferences: ^2.0.15
     path_provider: ^2.0.15
   ```

3. **Create assets folder** and add your JSON data:
   - Create `assets` folder in project root
   - Add `sesap_data.json` with your content
   - Update `pubspec.yaml`:
     ```yaml
     flutter:
       uses-material-design: true
       assets:
         - assets/sesap_data.json
     ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## Features Included

1. **Structured Navigation**:
   - Volume → Part → Question hierarchy
   - Easy navigation between sections

2. **Interactive Question Interface**:
   - Clear display of scenarios and questions
   - Selectable answer options
   - Immediate feedback on answers

3. **Progress Tracking**:
   - Saves user answers locally
   - Tracks correct/incorrect answers
   - Visual progress indicators
   - Progress summary screen

4. **Visual Feedback**:
   - Color-coded answer feedback
   - Detailed explanations
   - Progress visualization

5. **Data Persistence**:
   - Uses SharedPreferences for local storage
   - Tracks last accessed date
   - Option to reset progress

## Enhancements You Can Add

1. **Search Functionality**:
   - Search questions by keywords
   - Filter by category or difficulty

2. **Study Modes**:
   - Quiz mode with timer
   - Review mode for incorrect answers
   - Random question selection

3. **Visual Aids**:
   - Display figures and tables
   - Image zoom functionality
   - Interactive diagrams

4. **Statistics**:
   - Detailed performance analytics
   - Study time tracking
   - Weak area identification

5. **Collaboration Features**:
   - Share progress with peers
   - Discussion forums for questions
   - Study group creation

This Flutter app provides a solid foundation for your SESAP 17 medical learning application. You can extend it further based on your specific requirements and user feedback.