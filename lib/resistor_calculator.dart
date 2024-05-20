import 'package:flutter/material.dart';
import 'dart:math';

class ResistorCalculator extends StatefulWidget {
  @override
  _ResistorCalculatorState createState() => _ResistorCalculatorState();
}

class _ResistorCalculatorState extends State<ResistorCalculator> {
  List<String> colorOptions = ['Black', 'Brown', 'Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Violet', 'Gray', 'White'];
  List<String> toleranceOptions = ['Brown', 'Red', 'Green', 'Blue', 'Violet', 'Gray', 'Gold', 'Silver'];
  
  String selectedColor1 = 'Brown';
  String selectedColor2 = 'Brown';
  String selectedColor3 = 'Red';
  String selectedColor4 = 'Green'; 
  String selectedTolerance = 'Gold';

  bool isFiveColorResistor = false;

  double calculateResistance() {
    Map<String, int> colorValues = {
      'Black': 0,
      'Brown': 1,
      'Red': 2,
      'Orange': 3,
      'Yellow': 4,
      'Green': 5,
      'Blue': 6,
      'Violet': 7,
      'Gray': 8,
      'White': 9,
    };

    int digit1 = colorValues[selectedColor1] ?? 0;
    int digit2 = colorValues[selectedColor2] ?? 0;
    int digit3 = colorValues[selectedColor3] ?? 0;
    int multiplier; 

    double resistance;

    if (isFiveColorResistor) {
      multiplier = colorValues[selectedColor4] ?? 0;
      resistance = (digit1 * 100 + digit2 * 10 + digit3) * pow(10, multiplier).toDouble();
    } else {
      multiplier = colorValues[selectedColor3] ?? 0;
      resistance = (digit1 * 10 + digit2) * pow(10, multiplier).toDouble();
    }

    return resistance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resistor Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pilih Warna Resistor',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: selectedColor1,
              items: colorOptions.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor1 = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Warna 1'),
            ),
            DropdownButtonFormField(
              value: selectedColor2,
              items: colorOptions.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor2 = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Warna 2'),
            ),
            DropdownButtonFormField(
              value: selectedColor3,
              items: colorOptions.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor3 = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Warna 3'),
            ),
            
            if (isFiveColorResistor)
              DropdownButtonFormField(
                value: selectedColor4,
                items: colorOptions.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Text(color),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedColor4 = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Warna 4'),
              ),
            DropdownButtonFormField(
              value: selectedTolerance,
              items: toleranceOptions.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTolerance = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Toleransi'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Pilih tipe resistor:'),
                SizedBox(width: 10),
                DropdownButton(
                  value: isFiveColorResistor,
                  items: [
                    DropdownMenuItem(
                      value: false,
                      child: Text('4 Warna'),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text('5 Warna'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      isFiveColorResistor = value ?? false; 
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double resistance = calculateResistance();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Nilai Resistor'),
                      content: Text('Nilai resistansi dari resistor adalah $resistance ohms dengan warna toleransi $selectedTolerance.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Hitung'),
            ),
          ],
        ),
      ),
    );
  }
}
