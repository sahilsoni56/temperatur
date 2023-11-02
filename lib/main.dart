import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double val;
  int groupValue = 0; // Initialize with an initial value
  String finalAnswer = '';

  handleTemperature(int value) {
    setState(() {
      if (value == 1) {
        // Fahrenheit to Celsius
        groupValue = 1;
        var ans = (val - 32.0) / 1.8;
        finalAnswer = ans.toStringAsFixed(2) + " °C";
      } else if (value == 2) {
        // Celsius to Fahrenheit
        groupValue = 2;
        var ans = (val * 1.8) + 32;
        finalAnswer = "${ans.toStringAsFixed(2)} °F";
      }
    });
  }

  clearAnswer() {
    setState(() {
      finalAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),
          TextField(
            decoration: const InputDecoration(labelText: 'Enter value'),
            onChanged: (String value) {
              setState(() {
                if (value.isEmpty) {
                  finalAnswer = '';
                } else {
                  double? parsedValue = double.tryParse(value);
                  if (parsedValue != null) {
                    val = parsedValue;
                    finalAnswer = '';
                  } else {
                    finalAnswer = 'Invalid input';
                  }
                }
              });
            },
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Radio(
                activeColor: Colors.red,
                value: 1,
                groupValue: groupValue,
                onChanged: (e) => handleTemperature(e!),
              ),
              const Text("Fahrenheit To Celsius"),
              const SizedBox(height: 5.0),
              Radio(
                activeColor: Colors.red,
                value: 2,
                groupValue: groupValue,
                onChanged: (e) => handleTemperature(e!),
              ),
              const Text("Celsius To Fahrenheit"),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: clearAnswer,
            child: const Text('Clear'),
          ),
          const SizedBox(height: 20.0),
          Text(finalAnswer),
        ],
      ),
    );
  }
}
