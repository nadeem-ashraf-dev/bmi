import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  bool isMale = true;
  int height = 180; // in cm
  int weight = 60;  // in kg
  int age = 23;

  double calculateBMI() {
    // Convert height to meters
    double heightInMeters = height / 100;
    // Calculate BMI
    return weight / (heightInMeters * heightInMeters);
  }

  void showBMIResult() {
    double bmi = calculateBMI();
    String result;

    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi < 24.9) {
      result = "Normal weight";
    } else if (bmi < 29.9) {
      result = "Overweight";
    } else {
      result = "Obesity";
    }

    // Show dialog with the result
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Your BMI'),
          content: Text('BMI: ${bmi.toStringAsFixed(1)}\nStatus: $result'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: Container(
                      child: Icon(Icons.male, color: isMale ? Colors.white : Colors.grey),
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: isMale ? Colors.blue : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Container(
                      child: Icon(Icons.female, color: isMale ? Colors.grey : Colors.white),
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: isMale ? Colors.grey[900] : Colors.pink,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HEIGHT', style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900)),
                      Text(' cm', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 100,
                    max: 220,
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                ],//
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WEIGHT', style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                        Text(weight.toString(), style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: 'weight-',
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              mini: true,
                              child: Icon(Icons.remove),
                            ),
                            SizedBox(width: 10.0),
                            FloatingActionButton(
                              heroTag: 'weight+',
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              mini: true,
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('AGE', style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                        Text(age.toString(), style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: 'age-',
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              mini: true,
                              child: Icon(Icons.remove),
                            ),
                            SizedBox(width: 10.0),
                            FloatingActionButton(
                              heroTag: 'age+',
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              mini: true,
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.pink,
            width: double.infinity,
            height: 80.0,
            child: TextButton(
              child: Text(
                'CALCULATE',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              onPressed: () {
                showBMIResult(); // Call the method to show the BMI result
              },
            ),
          ),
        ],
      ),
    );
  }
}//
