import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';

class MyWidget extends StatefulWidget {
  final List<dynamic> respostaTexto;
  final bool tipoResposta;

  MyWidget(
      {super.key, required this.respostaTexto, required this.tipoResposta});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }
  /*ListView checkBoxOrRadio(List<dynamic> respostaTexto, bool tipoResposta) {
    if (respostaTexto.length == 0) {
      return ListView();
    }
    if (tipoResposta == true) {
      dynamic currentOption = respostaTexto[0];
      return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(respostaTexto[index]),
                leading: Radio(
                    value: respostaTexto[index],
                    groupValue: currentOption,
                    onChanged: (value) {
                      setState(() {
                        currentOption = value;
                      });
                    }));
          });
    } else {
      return ListView.builder(
          itemCount: respostaTexto.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(respostaTexto[index]),
                leading: Checkbox(
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        if (value == false) {
                          value = true;
                        } else {
                          value = false;
                        }
                      });
                    }));
          });
    }
  }*/

  @override
  /*Widget build(BuildContext context) {
    if (widget.respostaTexto.length == 0) {
      //return ListView();
      return Container();
    }

    if (widget.tipoResposta) {
      dynamic currentOption = widget.respostaTexto[0];
      return Container(
          child: ListView.builder(
              itemCount: widget.respostaTexto.length,
              itemBuilder: (context, index) {
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
              }));
    } else {
      return Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: 10.0,
          child: ListView.builder(
              itemCount: widget.respostaTexto.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(widget.respostaTexto[index]),
                    leading: Checkbox(
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            if (value == false) {
                              value = true;
                            } else {
                              value = false;
                            }
                          });
                        }));
              }));
    }
  }*/
  Widget build(BuildContext context){
    if(widget.respostaTexto.length == 0){
      return Container();
    }

    if(widget.tipoResposta == true){
      //dynamic currentOption = widget.respostaTexto[0];
      //return Form(
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
    } else {
      //return Form(
      return Container(
        width: MediaQuery.sizeOf(context).width*0.5,
        height: 50.0, 
        child:  
        Form(
        key: _formKey,
        child: ListView.builder(
              itemCount: widget.respostaTexto.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(widget.respostaTexto[index]),
                    leading: Checkbox(
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            if (value == false) {
                              value = true;
                            } else {
                              value = false;
                            }
                          });
                        }));
              }
              )
              )
              );
    }
  }
}
