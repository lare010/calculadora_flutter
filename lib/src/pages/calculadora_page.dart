import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculadoraPage extends StatefulWidget {
  CalculadoraPage({Key key}) : super(key: key);

  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _calculo = '0';
  String _resultado = '0';
  String _expression = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 211, 210, 0.9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Container()),
          pantallac(),
          pantallar(),
          Divider(),
          Container(
            height: size.height * 0.53,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[300])]),
            child: btns(),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------

  Widget btns() {
    double espcioBtn = 20;
    Color operadors = Colors.grey[400];
    Color fondOperadors = Colors.white;
    Color operadorE = Colors.grey[800];
    Color numeros = Colors.grey[300];
    Color fondoNumeros = Colors.black87;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearBotones('C', operadors, fondOperadors),
            _crearBotones('+/-', operadors, fondOperadors),
            _crearBotones('%', operadors, fondOperadors),
            _crearBotones('/', operadors, fondOperadors),
          ],
        ),
        SizedBox(height: espcioBtn),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearBotones('7', numeros, fondoNumeros),
            _crearBotones('8', numeros, fondoNumeros),
            _crearBotones('9', numeros, fondoNumeros),
            _crearBotones('X', operadors, fondOperadors),
          ],
        ),
        SizedBox(height: espcioBtn),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearBotones('4', numeros, fondoNumeros),
            _crearBotones('5', numeros, fondoNumeros),
            _crearBotones('6', numeros, fondoNumeros),
            _crearBotones('-', operadors, fondOperadors),
          ],
        ),
        SizedBox(height: espcioBtn),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearBotones('1', numeros, fondoNumeros),
            _crearBotones('2', numeros, fondoNumeros),
            _crearBotones('3', numeros, fondoNumeros),
            _crearBotones('+', operadors, fondOperadors),
          ],
        ),
        SizedBox(height: espcioBtn),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _crearBotones('0', numeros, fondoNumeros),
            _crearBotones('', numeros, fondoNumeros),
            _crearBotones(',', numeros, fondoNumeros),
            _crearBotones('=', operadorE, fondOperadors),
          ],
        ),
        SizedBox(height: espcioBtn),
      ],
    );
  }

  pantallac() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          _calculo,
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.right,
        ));
  }

  pantallar() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          _resultado,
          style: TextStyle(fontSize: 34.0),
          textAlign: TextAlign.right,
        ));
  }

  _btnClick(String val) {
    setState(() {
      if (val == 'C') {
        _calculo = '0';
        _resultado = '0';
      } else if (val == '%') {
        _calculo += val;
        _resultado = (double.parse(_resultado) / 100).toString();
      } else if (val == '+/-') {
        _resultado = (double.parse(_resultado) * -1).toString();
      } else if (val == '=') {
        _expression = _calculo;
        _expression = _expression.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _resultado = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          _resultado = '0';
        }
      } else {
        val = val.replaceAll('X', 'x');
        val = val.replaceAll(',', '.');

        if (_calculo == '0') {
          _calculo = val;
        } else {
          _calculo += val;
          _btnClick('=');
        }
      }
    });
  }

  Widget _crearBotones(String texto, Color color, Color colorN) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)), color: color),
        child: FlatButton(
          onPressed: () => _btnClick(texto),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            texto,
            style: TextStyle(
              color: colorN,
              fontSize: 26.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
