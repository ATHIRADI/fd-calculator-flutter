import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FD Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  double? interest;
  double? total;

  void calculate() {
    if (_validateInputs()) {
      final interestRateCalc = (double.parse(_controller2.text) / 100 / 12) *
          int.parse(_controller3.text);

      final interestCalc = interestRateCalc * int.parse(_controller1.text);

      setState(
        () {
          interest = interestCalc;
          total = int.parse(_controller1.text) + interest!;
        },
      );
    }
  }

  bool _validateInputs() {
    if (_controller1.text.isEmpty ||
        _controller2.text.isEmpty ||
        _controller3.text.isEmpty) {
      _showError("All field are required");
      return false;
    }

    try {
      double.parse(_controller2.text);
      int.parse(_controller1.text);
      int.parse(_controller3.text);
    } catch (e) {
      _showError("Please enter valid numbers");
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Text(
              'Fixed Deposite',
              style: GoogleFonts.roboto(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Calculator',
              style: GoogleFonts.roboto(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                inputForm(
                  title: "Deposit Amount :",
                  controller: _controller1,
                  hintText: "e.g : 20000",
                ),
                const SizedBox(
                  height: 20,
                ),
                inputForm(
                  title: "Annual Intrest Rate (%) :",
                  controller: _controller2,
                  hintText: "e.g : 3",
                ),
                const SizedBox(
                  height: 20,
                ),
                inputForm(
                  title: "Peroid (in month) :",
                  controller: _controller3,
                  hintText: "e.g : 3",
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.amberAccent),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    calculate();
                  },
                  child: Center(
                    child: Text(
                      "Calculate",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                interest != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Interest: ${interest?.toStringAsFixed(2)}",
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Total:  ${total?.toStringAsFixed(2)}",
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget inputForm({
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText,
            ),
          ),
        )
      ],
    );
  }
}
