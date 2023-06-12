


import 'package:flutter/material.dart';

class IMCCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IMCCalculatorPage(),
    );
  }
}

class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  double _result = 0.0;
  String _status = '';
  String _imagePath = '';
  String _madeByText = 'Feito por';

  void _calculateIMC() {
    String weightText = _weightController.text;
    String heightText = _heightController.text;

    if (weightText.isNotEmpty && heightText.isNotEmpty) {
      double weight = double.parse(weightText);
      double height = double.parse(heightText) / 100; // Convert to meters

      if (height > 0) {
        double imc = weight / (height * height);
        setState(() {
          _result = imc;
          if (imc < 18.5) {
            _status = 'Abaixo do Peso';
            _imagePath = '../images/magra.png';
          } else if (imc >= 18.5 && imc < 25) {
            _status = 'Peso Normal';
            _imagePath = '../images/pesoIdeal.png';
          } else if (imc >= 25 && imc < 30) {
            _status = 'Sobrepeso';
            _imagePath = '../images/obeso.png';
          }
          _madeByText = 'Lucas Alencar';
        });
        return;
      }
    }

    // Limpar o resultado se houver algum erro nos dados de entrada
    setState(() {
      _result = 0.0;
      _status = '';
      _imagePath = '';
      _madeByText = 'Feito por';
    });
  }

  void _changeMadeByText() {
    setState(() {
      if (_madeByText == 'Feito por') {
        _madeByText = 'Lucas Alencar';
      } else {
        _madeByText = 'Feito por';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: _calculateIMC,
              child: Text(
                'Calcular',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            SizedBox(height: 16.0),
            Text(
              'IMC: ${_result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              _status,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            _imagePath.isNotEmpty
                ? Image.asset(
                    _imagePath,
                    height: 150.0,
                    width: 150.0,
                  )
                : Container(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: _changeMadeByText,
                  child: Text(
                    _madeByText,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}