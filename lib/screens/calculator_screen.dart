import 'package:flutter/material.dart';
import '../widgets/calculator_buttons.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';

  void _appendText(String text) {
    setState(() {
      if (_display.isNotEmpty &&
          "+-*/".contains(text) &&
          "+-*/".contains(_display[_display.length - 1])) {
        return;
      }
      _display += text;
    });
  }

  void _deleteLast() {
    setState(() {
      if (_display.isNotEmpty) {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  void _clearDisplay() {
    setState(() {
      _display = '';
    });
  }

  void _calculate() {
    try {
      final result = _evaluateExpression(_display);
      setState(() {
        _display = result.toString();
      });
    } catch (e) {
      setState(() {
        _display = 'Błąd';
      });
    }
  }

  double _evaluateExpression(String expression) {
    try {
      expression = _evaluateMultiplicationAndDivision(expression);
      return _evaluateAdditionAndSubtraction(expression);
    } catch (e) {
      throw 'Błąd przy obliczaniu wyrażenia';
    }
  }

  String _evaluateMultiplicationAndDivision(String expression) {
    RegExp exp = RegExp(r'(\d+(\.\d+)?)([*/])(\d+(\.\d+)?)'); // wyszukuje liczby całkowite
    while (exp.hasMatch(expression)) {
      expression = expression.replaceAllMapped(exp, (match) {
        double left = double.parse(match.group(1)!);
        double right = double.parse(match.group(4)!);
        String operator = match.group(3)!;

        double result = operator == '*' ? left * right : left / right;
        return result.toString();
      });
    }
    return expression;
  }

  double _evaluateAdditionAndSubtraction(String expression) {
    List<String> terms = expression.split(RegExp(r'(?=[+\-])'));
    double result = 0;

    for (String term in terms) {
      if (term.isNotEmpty) {
        if (term[0] == '+') {
          result += double.parse(term.substring(1));
        } else if (term[0] == '-') {
          result -= double.parse(term.substring(1));
        } else {
          result += double.parse(term);
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              _display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          CalculatorButtons(
            appendText: _appendText,
            clearDisplay: _clearDisplay,
            deleteLast: _deleteLast,
            calculate: _calculate,
          ),
        ],
      ),
    );
  }
}
