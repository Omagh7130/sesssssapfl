class SesapData {
  final Map<String, Volume> volumes;

  SesapData({required this.volumes});

  factory SesapData.fromJson(Map<String, dynamic> json) {
    Map<String, Volume> volumesMap = {};
    json.forEach((key, value) {
      volumesMap[key] = Volume.fromJson(value);
    });
    return SesapData(volumes: volumesMap);
  }
}

class Volume {
  final Map<String, Part> parts;

  Volume({required this.parts});

  factory Volume.fromJson(Map<String, dynamic> json) {
    Map<String, Part> partsMap = {};
    json.forEach((key, value) {
      partsMap[key] = Part.fromJson(value);
    });
    return Volume(parts: partsMap);
  }
}

class Part {
  final List<Question> items;

  Part({required this.items});

  factory Part.fromJson(Map<String, dynamic> json) {
    List<Question> itemsList = [];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        itemsList.add(Question.fromJson(v));
      });
    }
    return Part(items: itemsList);
  }
}

class Question {
  final String itemNumber;
  final String? scenario;
  final String question;
  final Map<String, String> options;
  final String correctAnswer;
  final String? explanation;
  final List<String> figures;
  final List<String> tables;

  Question({
    required this.itemNumber,
    this.scenario,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    required this.figures,
    required this.tables,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    Map<String, String> optionsMap = {};
    if (json['options'] != null) {
      json['options'].forEach((key, value) {
        optionsMap[key] = value;
      });
    }

    return Question(
      itemNumber: json['item_number'],
      scenario: json['scenario'],
      question: json['question'],
      options: optionsMap,
      correctAnswer: json['correct_answer'],
      explanation: json['explanation'],
      figures: json['figures'] != null ? List<String>.from(json['figures']) : [],
      tables: json['tables'] != null ? List<String>.from(json['tables']) : [],
    );
  }
}