import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:projeto_perguntas/model/respostas.dart';

class RadioWidget extends StatefulWidget {
  final List<dynamic> respostaTexto;

  RadioWidget(
      {super.key, required this.respostaTexto});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

enum Groceries { pickles, tomato, lettuce }

class _MyWidgetState extends State<RadioWidget> {
  //Comentado pois eu estava usando o widget Form antes
  //final _formKey = GlobalKey<FormState>();

  Groceries? _groceryItem = Groceries.pickles;
  
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: widget.respostaTexto.length,
      itemBuilder: (context, index){
        return RadioListTile
        (value: value,
        groupValue: groupValue, onChanged: onChanged)
    })
  }
  /*
  Widget build(BuildContext context){
      return Container(
        width: MediaQuery.sizeOf(context).width*0.5,
        height: 50.0, 
        child: 
        Form(
        key:_formKey,
        child: ListView.builder(
              itemCount: widget.respostaTexto.length,
              itemBuilder: (context, index) {
                dynamic currentOption = widget.respostaTexto[0];
                return ListTile(
                    title: Text(widget.respostaTexto[index]),
                    leading: Radio(
                        value: widget.respostaTexto[index],
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(() {
                            currentOption = value;
                          });
                        }));
              }
              )
            )
          );
    }*/
} 

