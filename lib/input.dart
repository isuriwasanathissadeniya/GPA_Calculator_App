import 'package:flutter/material.dart';
import 'calculator.dart';
import 'output.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List<TextEditingController> _courseControllers = [];
  List<TextEditingController> _creditControllers = [];
  List<TextEditingController> _gradeControllers = [];

  @override
  void initState() {
    super.initState();
    _addCourseRow(); // Add initial row
    _addCourseRow();
    _addCourseRow();
  }

  void _addCourseRow() {
    setState(() {
      _courseControllers.add(TextEditingController());
      _creditControllers.add(TextEditingController());
      _gradeControllers.add(TextEditingController());
    });
  }

  void _removeCourseRow(int index) {
    setState(() {
      _courseControllers.removeAt(index);
      _creditControllers.removeAt(index);
      _gradeControllers.removeAt(index);
    });
  }

  void _calculateGPA() {
    double gpa = calculateGPA(_creditControllers, _gradeControllers);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OutputScreen(gpa: gpa)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: const Color.fromARGB(255, 105, 104, 104)),
              columnWidths: {
                0: FlexColumnWidth(3), // Course Name
                1: FlexColumnWidth(2), // Credits
                2: FlexColumnWidth(2), // Grade
                3: FlexColumnWidth(1), // Remove Button
              },
              children: [
                // Table Header
                TableRow(
                  decoration: BoxDecoration(color: const Color(0xff6BA8A8)),
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text('Course (Optional)', textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text('Credits', textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text('Grade', textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text('')),
                  ],
                ),
                // Dynamic Rows
                for (int i = 0; i < _courseControllers.length; i++)
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(controller: _courseControllers[i], decoration: InputDecoration(border: InputBorder.none)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: _creditControllers[i],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: DropdownButtonFormField<String>(
                          value: _gradeControllers[i].text.isNotEmpty ? _gradeControllers[i].text : null,
                          onChanged: (value) => setState(() => _gradeControllers[i].text = value ?? ''),
                          items: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'E', '-']
                              .map((grade) => DropdownMenuItem(value: grade, child: Text(grade)))
                              .toList(),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(Icons.remove_circle, color: const Color(0xffA3CDCD)),
                          onPressed: _courseControllers.length > 1 ? () => _removeCourseRow(i) : null,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _addCourseRow,
              child: Text('+ Add More Courses', style: TextStyle(color: const Color(0xff579797))),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateGPA,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff6BA8A8)),
                  child: Text('Calculate', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _courseControllers.forEach((controller) => controller.clear());
                    _creditControllers.forEach((controller) => controller.clear());
                    _gradeControllers.forEach((controller) => controller.clear());
                  }),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff6BAEAE)),
                  child: Text('Clear', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
