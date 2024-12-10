import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  double firstNumber = 0;
  double secondNumber = 0;
  String operation = "";
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Kirtan Calculator App',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        String symbol = lstSymbols[index];
                      if (symbol == "C") {
                        _textController.text = "";
                        firstNumber = 0;
                        secondNumber = 0;
                        operation = "";
                      } else if (symbol == "<-") {
                        if (_textController.text.isNotEmpty) {
                          _textController.text = _textController.text
                              .substring(0, _textController.text.length - 1);
                        }
                      } else if (symbol == "+" ||
                          symbol == "-" ||
                          symbol == "*" ||
                          symbol == "/" ||
                          symbol == "%") {
                        if (_textController.text.isNotEmpty) {
                          firstNumber = double.parse(_textController.text);
                          operation = symbol;
                          _textController.text = "";
                        }
                      } else if (symbol == "=") {
                        if (_textController.text.isNotEmpty &&
                            operation.isNotEmpty) {
                          secondNumber = double.parse(_textController.text);
                          double result = 0;
                          switch (operation) {
                            case "+":
                              result = firstNumber + secondNumber;
                              break;
                            case "-":
                              result = firstNumber - secondNumber;
                              break;
                            case "*":
                              result = firstNumber * secondNumber;
                              break;
                            case "/":
                              result = secondNumber != 0
                                  ? firstNumber / secondNumber
                                  : double.nan;
                              break;
                            case "%":
                              result = firstNumber % secondNumber;
                              break;
                          }
                          _textController.text = result.toString();
                          operation = "";
                        }
                      } else {
                        _textController.text += symbol;
                      }
                    },
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}