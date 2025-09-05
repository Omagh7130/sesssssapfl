import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesap_app/models/sesap_model.dart';
import 'package:sesap_app/screens/volume_list_screen.dart';
import 'package:sesap_app/screens/progress_screen.dart';
import 'package:sesap_app/widgets/progress_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sesapData = Provider.of<SesapData>(context);
    final progressModel = Provider.of<ProgressModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('SESAP 17 Learning'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.pushNamed(context, '/progress');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select a volume to begin studying',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: sesapData.volumes.length,
              itemBuilder: (context, index) {
                final volumeKey = sesapData.volumes.keys.elementAt(index);
                final volume = sesapData.volumes[volumeKey]!;
                
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      volumeKey,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text('${volume.parts.length} parts'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VolumeListScreen(
                            volumeKey: volumeKey,
                            volume: volume,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ProgressIndicatorWidget(progressModel: progressModel),
        ],
      ),
    );
  }
}
```

### 7. Volume List Screen

```dart