import 'package:flutter/material.dart';
import 'package:sesap_app/models/sesap_model.dart';
import 'package:sesap_app/screens/question_list_screen.dart';

class VolumeListScreen extends StatelessWidget {
  final String volumeKey;
  final Volume volume;

  const VolumeListScreen({
    super.key,
    required this.volumeKey,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(volumeKey),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: volume.parts.length,
        itemBuilder: (context, index) {
          final partKey = volume.parts.keys.elementAt(index);
          final part = volume.parts[partKey]!;
          
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                partKey,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text('${part.items.length} questions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionListScreen(
                      volumeKey: volumeKey,
                      partKey: partKey,
                      questions: part.items,
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

### 8. Question List Screen

```dart