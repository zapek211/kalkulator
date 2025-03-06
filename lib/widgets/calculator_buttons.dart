import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  final Function(String) appendText;
  final VoidCallback clearDisplay;
  final VoidCallback deleteLast;
  final VoidCallback calculate;

  const CalculatorButtons({
    super.key,
    required this.appendText,
    required this.clearDisplay,
    required this.deleteLast,
    required this.calculate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButtonRow(['AC', 'C', 'DEL', '/']),
        _buildButtonRow(['7', '8', '9', '*']),
        _buildButtonRow(['4', '5', '6', '-']),
        _buildButtonRow(['1', '2', '3', '+']),
        _buildButtonRow(['0', '00', '.', '=']),
      ],
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons.map((text) {
        return Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (text == 'AC') {
                clearDisplay();
              } else if (text == 'C') {
                clearDisplay();
              } else if (text == 'DEL') {
                deleteLast();
              } else if (text == '=') {
                calculate();
              } else {
                appendText(text);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(double.infinity, 70),
            ),
            child: Text(text),
          ),
        );
      }).toList(),
    );
  }
}
