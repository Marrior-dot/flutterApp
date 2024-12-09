import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'dart:convert' show utf8;

class OptionsListWidget<T> extends StatefulWidget {
  final List<T> options;
  final bool isRadio;
  final T? initialValue;
  int respostaIndex;
  final int postagemId;
  final String userName;

  OptionsListWidget(
      {super.key,
      required this.options,
      required this.isRadio,
      this.initialValue,
      required this.respostaIndex,
      required this.postagemId,
      required this.userName});

  @override
  _OptionsListWidgetState<T> createState() => _OptionsListWidgetState<T>();
}

class _OptionsListWidgetState<T> extends State<OptionsListWidget<T>> {
  String? _selectedValue;
  List<bool?> checkBoxInitialValue = [];
  String? radioOption;
  List<String?>? checkBoxOption;
  bool? sendButton;

  TextStyle sendResposta = const TextStyle(
    fontSize: 12,
  );
  TextStyle resposta = const TextStyle(
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue.toString();
    for (int index = 0; index < widget.options.length; index++) {
      checkBoxInitialValue.add(false);
    }
    checkBoxOption = [];
    sendButton = true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRadio) {
      return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          //height: MediaQuery.of(context).size.height * 0.2,
          child: Column(children:[
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final optionDecoded =
                      utf8.decode(widget.options[index].toString().codeUnits);
                  return ListTile(
                      title: Text(optionDecoded, style: resposta),
                      leading: Radio(
                        value: optionDecoded,
                        groupValue: _selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value;
                            radioOption = optionDecoded;
                          });
                        },
                      ));
                }),
            FutureBuilder(
                future: checkRespostas(widget.userName, widget.postagemId),
                builder: ((context, snapshot) {
                  sendButton = snapshot.data;
                  return 
                  Padding(padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child:
                  ElevatedButton(
                      onPressed: sendButton == true
                          ? () async {
                              bool permitirPersistencia = false;
                              await updateResposta(radioOption, widget.postagemId);
                                if (permitirPersistencia == false) {    
                                  await  persistencaRespostas(
                                          widget.userName, widget.postagemId);
                                }
                              setState(() {
                                sendButton = null;
                              });
                            }
                          : null,
                      child: 
                          Text(
                        style: sendResposta,
                        "Enviar resposta",
                      ),
                      )
                );
                }))
          ]));
    } else {
      return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final optionDecoded =
                      utf8.decode(widget.options[index].toString().codeUnits);
                  return ListTile(
                      title: Text(optionDecoded, style: resposta),
                      leading: Checkbox(
                        value: checkBoxInitialValue[index],
                        onChanged: (bool? value) {
                          setState(() {
                            checkBoxInitialValue[index] = value!;
                            if (value == false) {
                              checkBoxOption!.remove(optionDecoded);
                            } else {
                              checkBoxOption!.add(optionDecoded);
                            }
                          });
                        },
                      ));
                }),
            FutureBuilder(
                future: checkRespostas(widget.userName, widget.postagemId),
                builder: ((context, snapshot) {
                  sendButton = snapshot.data;
                  return ElevatedButton(
                      onPressed: sendButton == true
                          ? () async{
                              bool permitirPersistencia = false;

                              for (var i = 0; i < checkBoxOption!.length; i++) {
                               await updateResposta(
                                    checkBoxOption![i], widget.postagemId);
                              }

                              if (permitirPersistencia == false) {
                               await persistencaRespostas(
                                    widget.userName, widget.postagemId);
                                permitirPersistencia = true;
                              }
                              
                              setState(() {
                                sendButton = null;
                              });
                            }
                          : null,
                      child: Text(
                        style: sendResposta,
                        "Enviar resposta",
                      ));
                }))
          ]));
    }
  }
}
