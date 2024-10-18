// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = '0';
  String currentValue = '';
  double? num1;
  String? operator;

  void _clear() {
    setState(() {
      output = '0';
      currentValue = '';
      num1 = null;
      operator = null;
    });
  }

  void _handleOperator(String newOperator) {
    if (currentValue.isNotEmpty) {
      setState(() {
        num1 = double.parse(currentValue);
        operator = newOperator;
        currentValue = '';
      });
    }
  }

  void _addDigit(String digit) {
    setState(() {
      if (currentValue.length < 12) {
        if (currentValue == '0') {
          currentValue = digit;
        } else {
          currentValue += digit;
        }
        output = currentValue;
      }
    });
  }

  void _calculate() {
    double? result;

    if (num1 != null && operator != null && currentValue.isNotEmpty) {
      double num2 = double.parse(currentValue);

      switch (operator!) {
        case '+':
          result = num1! + num2;
          break;
        case '-':
          result = num1! - num2;
          break;
        case '*':
          result = num1! * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = num1! / num2;
          } else {
            setState(() {
              output = 'Error';
            });
            return;
          }
          break;
      }
    }

    if (result != null) {
      setState(() {
        num1 = result;
        output = result.toString();
        currentValue = result.toString();
        operator = null;
      });
    }
  }

  void _handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        _handleOperator(buttonText);
      } else if (buttonText == '=') {
        _calculate();
      } else {
        _addDigit(buttonText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      '7',
      '8',
      '9',
      '/',
      '4',
      '5',
      '6',
      '*',
      '1',
      '2',
      '3',
      '-',
      'C',
      '0',
      '=',
      '+',
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Calculator',
          style: TextStyle(fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      output,
                      style: TextStyle(fontSize: 32.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 3,
                    crossAxisCount: 4,
                    mainAxisSpacing: 3,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff0d2e52)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            setState(() {
                              _handleButtonClick(buttons[index]);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              buttons[index],
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
