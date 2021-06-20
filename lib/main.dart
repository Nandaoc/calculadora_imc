import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  TextEditingController weightController = TextEditingController();
  TextEditingController heightContrller = TextEditingController();
  String _infoText = "Informe seus Dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField(){
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightContrller.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text); //transformando o texto em double
      double height = double.parse(heightContrller.text)/100; //transformando cm em m
      double imc = weight/(height * height);

      if(imc < 18.5){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }
      else if((imc >= 18.5) && (imc <= 24.9)){
        _infoText = "Peso normal (${imc.toStringAsPrecision(4)})";
      }
      else if((imc >= 25) && (imc <= 29.9)){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      }
      else if((imc >= 30) && (imc <= 34.9)){
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(4)})";
      }
      else if((imc >= 35.5) && (imc <= 39.9)){
        _infoText = "Obesidade grau 2 (${imc.toStringAsPrecision(4)})";
      }
      else if(imc > 40){
        _infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  void _validateWeight(){
    setState(() {
      double weight = double.parse(weightController.text);

      if((weight >= 500) || (weight < 0)){
        _infoText = "Insira um peso válido";
      }
    });
  }

  void _validateHeight(){
    setState(() {
      double height = double.parse(heightContrller.text)/100;

      if((height >= 300) || (height < 0)){
      _infoText = "Insira uma altura válida";
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
       title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: _resetField),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline,
                size:120,
                color: Colors.green,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                controller: weightController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira seu peso";
                  }else{
                    _validateWeight();
                  }
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                controller: heightContrller,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira sua altura";
                  }else{
                    _validateHeight()
                  }
                },
              ),
              ElevatedButton(
                onPressed:(){
                  if(_formKey.currentState!.validate()){
                    _calculate();
                  }
                },
                child: Text("Calcular",
                  style: TextStyle(color: Colors.white,
                      fontSize: 25.0
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green,
                    onPrimary: Colors.white,
                    onSurface: Colors.green
                ), //color: Colors.green,
              ),
              Text("$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}