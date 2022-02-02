import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Callback Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Callback Demo'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Numbers(callback: (value) {
              setState(() => sum = value);
            }),
            Text('The sum is $sum.'),
          ],
        ),
      ),
    );
  }
}

typedef NumbersCallback = void Function(int value);

class Numbers extends StatefulWidget {
  final NumbersCallback callback;

  Numbers({required this.callback, Key? key}) : super(key: key);

  @override
  State<Numbers> createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  initState() {
    super.initState();
    // When the text in either TextField is changed,
    // compute a new sum and send to the parent widget
    // using the callback function.
    controller1.addListener(compute);
    controller2.addListener(compute);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTextField(controller: controller1),
        Icon(Icons.add),
        _buildTextField(controller: controller2),
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller}) {
    return SizedBox(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
      width: 70,
    );
  }

  void compute() {
    var number1 = controllerToInt(controller1);
    var number2 = controllerToInt(controller2);
    widget.callback(number1 + number2);
  }

  int controllerToInt(TextEditingController controller) {
    try {
      // int.parse throws if the text cannot be converted to an int.
      return int.parse(controller.value.text);
    } catch (e) {
      return 0;
    }
  }
}
