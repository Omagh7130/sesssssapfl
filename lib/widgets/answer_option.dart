import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String optionKey;
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool showFeedback;
  final VoidCallback? onTap;

  const AnswerOption({
    super.key,
    required this.optionKey,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.showFeedback,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey;
    Color backgroundColor = Colors.transparent;
    
    if (showFeedback) {
      if (isCorrect) {
        borderColor = Colors.green;
        backgroundColor = Colors.green.withOpacity(0.1);
      } else if (isSelected) {
        borderColor = Colors.red;
        backgroundColor = Colors.red.withOpacity(0.1);
      }
    } else if (isSelected) {
      borderColor = Colors.blue;
      backgroundColor = Colors.blue.withOpacity(0.1);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.blue : Colors.transparent,
                  border: Border.all(color: borderColor),
                ),
                child: Center(
                  child: Text(
                    optionKey,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  optionText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (showFeedback && isCorrect)
                const Icon(Icons.check_circle, color: Colors.green),
              if (showFeedback && isSelected && !isCorrect)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}