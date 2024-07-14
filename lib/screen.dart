import 'package:flutter/material.dart';

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _expression = "";
  String _result = "0";
  String? _operation;
  double _num1 = 0.0;
  double _num2 = 0.0;
  bool _shouldReset = false;

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      _expression = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operation = null;
      _shouldReset = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      if (_operation != null) {
        _num2 = double.parse(_output);
        if (_operation == "+") {
          _num1 = _num1 + _num2;
        } else if (_operation == "-") {
          _num1 = _num1 - _num2;
        } else if (_operation == "x") {
          _num1 = _num1 * _num2;
        } else if (_operation == "/") {
          _num1 = _num1 / _num2;
        }
      } else {
        _num1 = double.parse(_output);
      }
      _operation = buttonText;
      _output = "0";
      _expression += " $buttonText ";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output += buttonText;
        _expression += buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_output);
      if (_operation == "+") {
        _result = (_num1 + _num2).toString();
      } else if (_operation == "-") {
        _result = (_num1 - _num2).toString();
      } else if (_operation == "x") {
        _result = (_num1 * _num2).toString();
      } else if (_operation == "/") {
        _result = (_num1 / _num2).toString();
      }

      _output = _result;
      _expression += " = $_result";
      _operation = null;
      _num1 = 0.0;
      _num2 = 0.0;
      _shouldReset = true;
    } else {
      if (_shouldReset) {
        _output = buttonText;
        _expression = buttonText;
        _shouldReset = false;
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _expression += buttonText;
      }
    }

    setState(() {
      _output = double.parse(_output).toStringAsFixed(
          _output.contains('.') ? _output.split('.')[1].length : 0);
    });
  }

  Widget buildButton(String buttonText,
      {Color textColor = Colors.black, Color bgColor = Colors.grey}) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.all(24.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 3,
          title: const Text(
            'Simple Calculator',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    _output,
                    style: const TextStyle(
                        fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 7),
                    buildButton("7", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("8", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("9", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("/",
                        textColor: Colors.white, bgColor: Colors.deepPurple),
                    const SizedBox(width: 7),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const SizedBox(width: 7),
                    buildButton("4", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("5", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("6", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("x",
                        textColor: Colors.white, bgColor: Colors.deepPurple),
                    const SizedBox(width: 7),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const SizedBox(width: 7),
                    buildButton("1", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("2", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("3", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("-",
                        textColor: Colors.white, bgColor: Colors.deepPurple),
                    const SizedBox(width: 7),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const SizedBox(width: 7),
                    buildButton(".", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("0", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("00", textColor: Colors.black),
                    const SizedBox(width: 7),
                    buildButton("+",
                        textColor: Colors.white, bgColor: Colors.deepPurple),
                    const SizedBox(width: 7),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const SizedBox(width: 7),
                    buildButton("CLEAR",
                        textColor: Colors.black, bgColor: Colors.grey),
                    const SizedBox(width: 7),
                    buildButton("=",
                        textColor: Colors.white, bgColor: Colors.deepPurple),
                    const SizedBox(width: 7),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
