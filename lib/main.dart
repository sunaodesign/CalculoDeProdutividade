import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {

  TextEditingController producaoControler = TextEditingController();
  TextEditingController ctControler = TextEditingController();
  TextEditingController horasControler = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados!";

  void _resetFields() {
    producaoControler.text = "";
    ctControler.text = "";
    horasControler.text = "";

    setState(() {
      _infoText = "Informe os dados!";
    });
  }

  void _calculate() {
    setState(() {
      double producao = double.parse(producaoControler.text);
      double ct = double.parse(ctControler.text);
      double horas = double.parse(horasControler.text);

      double produtividade = producao * ct / horas / 3600 * 100;
      double porHora = producao / horas;

      if (produtividade < 75) {
        _infoText = "Abaixo da Meta(${produtividade.toStringAsPrecision(2)}%)\n\n"
          "Quant. P/Hora(${porHora.toStringAsPrecision(3)}Peças)";
      } else if (produtividade >= 75 && produtividade < 80) {
        _infoText = "Produtividade Ideal (${produtividade.toStringAsPrecision(2)}%)\n\n"
          "Quant. P/Hora(${porHora.toStringAsPrecision(3)}Peças)";
      } else if (produtividade >= 80 && produtividade < 100) {
        _infoText = "Ótima Produção (${produtividade.toStringAsPrecision(2)}%)\n\n"
          "Quant. P/Hora(${porHora.toStringAsPrecision(3)}Peças)";
      } else if (produtividade >= 100)
        _infoText = "Excelente!!!(${produtividade.toStringAsPrecision(3)}%)\n\n"
          "Quant. P/Hora(${porHora.toStringAsPrecision(3)}Peças)";
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtividade"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.trending_up, size: 120.0, color: Colors.blue),
                Text("Meta 75%",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Produção",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                  controller: producaoControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira a Produção!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "C.T(Tempo da peça)",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                  controller: ctControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o tempo em segundos!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Horas Trabalhadas",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                  controller: horasControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira a quantidade de horas!";
                    }
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue,
                      )),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
