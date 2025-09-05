import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sesap_app/models/sesap_model.dart';

class DataService {
  static Future<SesapData> loadSesapData() async {
    final String jsonString = await rootBundle.loadString('assets/sesap_data.json');
    final jsonResponse = json.decode(jsonString);
    return SesapData.fromJson(jsonResponse);
  }
}
```

### 4. Progress Service

```dart