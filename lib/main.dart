import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourBMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'YourBMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var gradientcolor = [Colors.yellow.shade500, Colors.blue.shade500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        actions: [
          IconButton(
            // Info button at the top-right
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('BMI Information'),
                    content: const Text(
                      'BMI is Body Mass Index.\n\n'
                      'BMI is the same for both men and women aged 18 and above.\n\n'
                      'BMI Categories:\n'
                      '- Underweight: BMI < 18.5\n'
                      '- Healthy: BMI 18.5 - 24.9\n'
                      '- Overweight: BMI > 24.9\n\n'
                      'Note: BMI calculation is generally for adults (18 years and older).',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientcolor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 41),
                TextField(
                  controller: wtController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Enter your weight(in kgs)',
                      style: TextStyle(fontSize: 23),
                    ),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 31),
                TextField(
                  controller: ftController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Enter your height(in feet)',
                      style: TextStyle(fontSize: 23),
                    ),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 31),
                TextField(
                  controller: inController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Enter your height(in inches)',
                      style: TextStyle(fontSize: 23),
                    ),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 41),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inch = inController.text.toString();

                    if (wt != "" && ft != "" && inch != "") {
                      var iWt = int.parse(wt);
                      var iFt = int.parse(ft);
                      var iInch = int.parse(inch);

                      var tInch = (iFt * 12) + iInch;

                      var tCm = tInch * 2.54;

                      var tM = tCm / 100;

                      var bmi = iWt / (tM * tM);

                      var msg = "";

                      if (bmi > 24.9) {
                        msg = "You're Overweight!!!";
                        gradientcolor = [
                          Colors.red.shade200,
                          Colors.red.shade500
                        ];
                      } else if (bmi < 18.5) {
                        msg = "You're Underweight!!!";
                        gradientcolor = [
                          Colors.orange.shade100,
                          Colors.orange.shade500
                        ];
                      } else {
                        msg = "You're Healthy!!!";
                        gradientcolor = [
                          Colors.green.shade100,
                          Colors.green.shade500
                        ];
                      }

                      setState(() {
                        result = "$msg \nYour BMI is ${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = 'Please fill all the required blanks!!!';
                      });
                    }
                  },
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 31),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  result,
                  style: const TextStyle(fontSize: 31),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
