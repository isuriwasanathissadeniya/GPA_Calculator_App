import 'package:flutter/material.dart';

double calculateGPA(List<TextEditingController> creditControllers, List<TextEditingController> gradeControllers) {
  double totalCredits = 0;
  double totalGradePoints = 0;

  for (int i = 0; i < creditControllers.length; i++) {
    double credits = double.tryParse(creditControllers[i].text) ?? 0;
    double gradePoint = _getGradePoint(gradeControllers[i].text.toUpperCase());
    totalCredits += credits;
    totalGradePoints += (credits * gradePoint);
  }

  return totalCredits > 0 ? totalGradePoints / totalCredits : 0.0;
}

double _getGradePoint(String grade) {
  switch (grade) {
    case 'A+': return 4.0;
    case 'A': return 4.0;
    case 'A-': return 3.7;
    case 'B+': return 3.3;
    case 'B': return 3.0;
    case 'B-': return 2.7;
    case 'C+': return 2.3;
    case 'C': return 2.0;
    case 'C-': return 1.7;
    case 'D+': return 1.3;
    case 'D': return 1.0;
    case 'E': return 0.7;
    default: return 0.0;
  }
}
