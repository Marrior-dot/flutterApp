import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/services/updateResposta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class OptionsListWidget<T> extends StatefulWidget {
  final List<T> options;
  final bool isRadio;
  final T? initialValue;

  const OptionsListWidget({
    super.key,
    required this.options,
    required this.isRadio,
    this.initialValue,
  });

  @override
  _OptionsListWidgetState<T> createState() => _OptionsListWidgetState<T>();
}

class _OptionsListWidgetState<T> extends State<OptionsListWidget<T>> {
  String? _selectedValue;
  List<bool?> checkBoxInitialValue = [];
  String? radioOption;
  List<String?>? checkBoxOption;
  bool? sendButton;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue.toString();
    for (int index = 0; index < widget.options.length; index++) {
      checkBoxInitialValue.add(false);
    }
    checkBoxOption = [];
    _loadButtonState();
  }

  Future<void> _loadButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //sendButton = prefs.getBool('sendButton') ?? true;
      sendButton = prefs.getBool('sendButton') == false ? null : true;
    });
  }

  Future<void> _saveButtonState(/*bool sendButton*/) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sendButton = false;
    });
    await prefs.setBool('sendButton', false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) {
      return Text("");
    }

    if (widget.isRadio) {
      return Column(children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final optionDecoded =
                  utf8.decode(widget.options[index].toString().codeUnits);
              return ListTile(
                  title: Text(optionDecoded),
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
        ElevatedButton(
            onPressed: sendButton == true ? (){
              updateResposta(radioOption);
              _saveButtonState();
              setState((){
                sendButton = null;
              });
            } : null
            ,
            child: Text("Enviar resposta"))
      ]);
    } else {
      return Column(children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final optionDecoded =
                  utf8.decode(widget.options[index].toString().codeUnits);
              return ListTile(
                  title: Text(optionDecoded),
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
        ElevatedButton(
            onPressed: sendButton == true ? () {
              for (var i = 0; i < checkBoxOption!.length; i++) {
                updateResposta(checkBoxOption![i]);
              }
              setState(() {
                sendButton = null;
              });
            }: null,
            child: Text("Enviar resposta"))
      ]);
    }
  }
}