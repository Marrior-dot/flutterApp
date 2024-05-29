import 'package:flutter/material.dart';


class MyWidget extends StatefulWidget {
  final List<String> respostaTexto = ['Option 1', 'Option 2', 'Option 3'];
  final bool tipoResposta = true; // Change to false for checkboxes

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // Add a variable to track selected value(s) for checkboxes (if needed)

  ListView checkBoxOrRadio(List<dynamic> respostaTexto, bool tipoResposta){
    if(respostaTexto.length == 0){
      return ListView();
    }
      if (tipoResposta == true){
        dynamic currentOption = respostaTexto[0];
        return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(respostaTexto[index]),
                leading: Radio(
                      value: respostaTexto[index],
                    groupValue: currentOption,
                    onChanged: (value) {
                        setState(() {               
                          currentOption = value;
                      });
                    })
            );
        }
        );
      }

      else{
        return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(respostaTexto[index]),
                leading: Checkbox(
                      value: false,
                    onChanged: (value) {
                        setState(() {
                          if(value == false){
                            value = true;
                          }
                          else{
                            value = false;
                          }
                      });
                    })
            );
      });
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Example'),
      ),
      body: checkBoxOrRadio(widget.respostaTexto, widget.tipoResposta),
    );
  }
}