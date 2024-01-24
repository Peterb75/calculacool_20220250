import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String displayText = '';
  double? firstOperand;
  String? operator;
  double? previousResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CalculaCool'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          buildButtonRow(['7', '8', '9', '/']),
          buildButtonRow(['4', '5', '6', '*']),
          buildButtonRow(['1', '2', '3', '-']),
          buildButtonRow(['0', '.', '=']),
          buildButtonRow(['C', '⌫']),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttonValues) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonValues
          .map((buttonText) => buildButton(buttonText))
          .toList(),
    );
  }

  Widget buildButton(String buttonText) {
    double buttonSize = 64.0;

    if (buttonText == '0' || buttonText == '=') {
      return ElevatedButton(
        onPressed: () {
          onButtonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(buttonSize * 2.5, buttonSize),
        ),
      );
    } else if (buttonText == 'C' || buttonText == '⌫' || buttonText == '/') {
      return ElevatedButton(
        onPressed: () {
          onButtonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(buttonSize, buttonSize),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          onButtonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(buttonSize, buttonSize),
        ),
      );
    }
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        calculateResult();
      } else if (isNumeric(buttonText)) {
        displayText += buttonText;
      } else if (buttonText == '.') {
        if (!displayText.contains('.')) {
          displayText += buttonText;
        }
      } else if (buttonText == 'C') {
        clearDisplay();
      } else {
        // Handle operators
        if (firstOperand != null && operator != null) {
          calculateResult();
        }
        firstOperand = double.parse(displayText);
        operator = buttonText;
        displayText = '';
      }
    });
  }

  void calculateResult() {
    if (firstOperand != null && operator != null && displayText.isNotEmpty) {
      double secondOperand = double.parse(displayText);
      switch (operator) {
        case '+':
          previousResult = firstOperand! + secondOperand;
          displayText = previousResult.toString();
          break;
        case '-':
          previousResult = firstOperand! - secondOperand;
          displayText = previousResult.toString();
          break;
        case '*':
          previousResult = firstOperand! * secondOperand;
          displayText = previousResult.toString();
          break;
        case '/':
          if (secondOperand != 0) {
            previousResult = firstOperand! / secondOperand;
            displayText = previousResult.toString();
          } else {
            displayText = 'Error';
          }
          break;
      }
    }
  }

  void clearDisplay() {
    setState(() {
      displayText = '';
      firstOperand = null;
      operator = null;
      previousResult = null;
    });
  }

  void onDeleteButtonPressed() {
    setState(() {
      if (displayText.isNotEmpty) {
        displayText = displayText.substring(0, displayText.length - 1);
      }
    });
  }

  bool isNumeric(String buttonText) {
    return double.tryParse(buttonText) != null;
  }
}
