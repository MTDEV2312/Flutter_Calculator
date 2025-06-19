import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculadora Científica'),
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
  final _numero1Controller = TextEditingController();
  final _numero2Controller = TextEditingController();
  String _resultado = '';

  void _calcular(String operacion) {
    // Validación de entrada
    if (!_esNumero(_numero1Controller.text) ||
        !_esNumero(_numero2Controller.text)) {
      setState(() {
        _resultado = 'Error: Ingrese solo números válidos';
      });
      return;
    }

    double num1 = double.tryParse(_numero1Controller.text) ?? 0;
    double num2 = double.tryParse(_numero2Controller.text) ?? 0;
    double result = 0;

    if (num1 == 0 && num2 == 0 && operacion != 'factorial') {
      setState(() {
        _resultado = 'Error: Ingrese números válidos';
      });
      return;
    }

    setState(() {
      switch (operacion) {
        case 'suma':
          result = num1 + num2;
          break;
        case 'resta':
          result = num1 - num2;
          break;
        case 'multiplicacion':
          result = num1 * num2;
          break;
        case 'division':
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            _resultado = 'Error: División por cero';
            return;
          }
          break;
        case 'potencia':
          result = math.pow(num1, num2).toDouble();
          break;
        case 'raiz':
          result = math.sqrt(num1);
          break;
        case 'seno':
          result = math.sin(num1 * math.pi / 180);
          break;
        case 'coseno':
          result = math.cos(num1 * math.pi / 180);
          break;
        case 'tangente':
          result = math.tan(num1 * math.pi / 180);
          break;
        case 'log':
          result = math.log(num1) / math.log(num2);
          break;
        case 'factorial':
          result = _factorial(num1);
          break;
        case 'abs':
          result = num1.abs();
          break;
        case 'redondeo':
          result = num1.round().toDouble();
          break;
      }
      _resultado = result.toStringAsFixed(2);
    });
  }

  double _factorial(double n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(60, 60), // Hace el botón cuadrado
      fixedSize: const Size(60, 60), // Mantiene el tamaño fijo
    );
  }

  bool _esNumero(String texto) {
    if (texto.isEmpty) return true;
    return double.tryParse(texto) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _numero1Controller,
                decoration: const InputDecoration(
                  labelText: 'Número 1',
                  hintText: 'Ingrese el primer número',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (!_esNumero(value)) {
                    setState(() {
                      _resultado = 'Error: Solo se permiten números';
                    });
                    _numero1Controller
                        .clear(); // Limpia el campo si no es número
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _numero2Controller,
                decoration: const InputDecoration(
                  labelText: 'Número 2',
                  hintText: 'Ingrese el segundo número',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('suma'),
                    child: const Text('+', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('resta'),
                    child: const Text('-', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('multiplicacion'),
                    child: const Text('*', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('division'),
                    child: const Text('/', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('potencia'),
                    child: const Text('^', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('raiz'),
                    child: const Text('√', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('seno'),
                    child: const Text('sin', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('coseno'),
                    child: const Text('cos', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('tangente'),
                    child: const Text('tan', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('log'),
                    child: const Text('log', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('factorial'),
                    child: const Text('!', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('abs'),
                    child: const Text('|x|', style: TextStyle(fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _calcular('redondeo'),
                    child: const Text('Red', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: $_resultado',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
