import 'package:flutter/material.dart';

void main() {
  runApp(MyApp13());
}

class MyApp13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SaveDataScreen(),
    );
  }
}

class SaveDataScreen extends StatefulWidget {
  @override
  _SaveDataScreenState createState() => _SaveDataScreenState();
}

class _SaveDataScreenState extends State<SaveDataScreen> {
  // Hardcoded list to store data
  List<String> savedData = [];

  // Controller for input text field
  TextEditingController _controller = TextEditingController();

  // Method to save data to the list
  void _saveData() {
    setState(() {
      // Add the text from the controller to the savedData list
      if (_controller.text.isNotEmpty) {
        savedData.add(_controller.text);
        _controller.clear(); // Clear the text field after saving
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Data to List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Input text field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter data',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Save button
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            // Display saved data
            Expanded(
              child: ListView.builder(
                itemCount: savedData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(savedData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}