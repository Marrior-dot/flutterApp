import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/respostas.dart';
import 'dart:convert' show utf8;

// Widget que exibe uma lista de opções como botões de rádio ou caixas de seleção.
class OptionsListWidget<T> extends StatefulWidget {
  // Lista de opções de respostas a serem exibidas.
  final List<String> options;

  // Define se o widget deve usar botões de rádio (true) ou caixas de seleção (false).
  final bool isRadio;

  // Valor inicial selecionado, utilizado para a lógica dos widgets de botões rádio.
  final String? initialValue;

  // ID da postagem.
  final int postagemId;

  // Nome do usuário.
  final String userName;

  // Construtor do widget.
  OptionsListWidget(
      {super.key,
      required this.options,
      required this.isRadio,
      this.initialValue,
      required this.postagemId,
      required this.userName});

  @override
  _OptionsListWidgetState<T> createState() => _OptionsListWidgetState<T>();
}

// Estado do widget OptionsListWidget.
class _OptionsListWidgetState<T> extends State<OptionsListWidget<T>> {
  // Valor selecionado para o botão de rádio.
  String? _selectedValue;

  // Lista de valores booleanos para as caixas de seleção.
  List<bool?> checkBoxInitialValue = [];

  // Opção selecionada no botão de rádio.
  String? radioOption;

  // Opções selecionadas nas caixas de seleção.
  List<String?>? checkBoxOption;

  // Controla a habilitação do botão de envio.
  // null para botão não habilitado, true para habilitado.
  bool? sendButton;

  // Estilo de texto para o botão de enviar resposta.
  TextStyle sendResposta = const TextStyle(
    fontSize: 12,
  );

  // Estilo de texto para as opções de resposta.
  TextStyle resposta = const TextStyle(
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    // Inicializa o valor selecionado com o valor inicial passado para o widget.
    _selectedValue = widget.initialValue.toString();

    // Inicializa a lista de valores booleanos para as caixas de seleção com valores "false".
    for (int index = 0; index < widget.options.length; index++) {
      checkBoxInitialValue.add(false);
    }

    // Inicializa a lista de opções selecionadas nas caixas de seleção.
    checkBoxOption = [];

    // Inicializa o botão de envio como habilitado.
    sendButton = true;
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se o widget deve usar botões de rádio.
    if (widget.isRadio) {
      // Retorna um SizedBox com uma Column contendo os botões de rádio.
      return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(children: [
            // ListView que exibe os botões de rádio.
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  // Decodifica a opção atual.
                  final optionDecoded =
                      utf8.decode(widget.options[index].toString().codeUnits);

                  // Retorna um ListTile com um botão de rádio.
                  return ListTile(
                      title: Text(optionDecoded, style: resposta),
                      leading: Radio(
                        value: optionDecoded,
                        groupValue: _selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            // Atualiza o valor selecionado.
                            _selectedValue = value;
                            // Atualiza a opção a ser enviada para o servidor
                            radioOption = optionDecoded;
                          });
                        },
                      ));
                }),
            // FutureBuilder que verifica se o usuário já respondeu à postagem.
            FutureBuilder(
                future: checkRespostas(widget.userName, widget.postagemId),
                builder: ((context, snapshot) {
                  sendButton = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 12),
                    child: ElevatedButton(
                      onPressed: sendButton == true
                          ? () async {
                              await updateResposta(
                                  radioOption, widget.postagemId);
                                await persistencaRespostas(
                                    widget.userName, widget.postagemId);
                              setState(() {
                                sendButton = null;
                              });
                            }
                          : null,
                      child: Text(
                        style: sendResposta,
                        "Enviar resposta",
                      ),
                    ),
                  );
                }))
          ]));
    } else {
      // Retorna um SizedBox com uma Column contendo as caixas de seleção.
      return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(children: [
            // ListView que exibe as caixas de seleção.
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  // Decodifica a opção atual.
                  final optionDecoded =
                      utf8.decode(widget.options[index].toString().codeUnits);
                  return ListTile(
                      title: Text(optionDecoded, style: resposta),
                      leading: Checkbox(
                        value: checkBoxInitialValue[index],
                        onChanged: (bool? value) {
                          setState(() {
                            // Atualiza o valor da caixa de seleção.
                            // Todos os adicionados como verdadeiros são enviados para o servidor dessa forma.
                            checkBoxInitialValue[index] = value!;
                            // Se valor falso, remove da lista de opções selecionadas.
                            if (value == false) {
                              checkBoxOption!.remove(optionDecoded);
                              // Se valor verdadeiro, adiciona à lista de opções selecionadas.
                            } else {
                              checkBoxOption!.add(optionDecoded);
                            }
                          });
                        },
                      ));
                }),
            // FutureBuilder que verifica se o usuário já respondeu à postagem.
            FutureBuilder(
                future: checkRespostas(widget.userName, widget.postagemId),
                builder: ((context, snapshot) {
                  sendButton = snapshot.data;
                  return ElevatedButton(
                      onPressed: sendButton == true
                          ? () async {
                              for (var i = 0;
                                  i < checkBoxOption!.length;
                                  i++) {
                                await updateResposta(
                                    checkBoxOption![i], widget.postagemId);
                              }

                                await persistencaRespostas(
                                    widget.userName, widget.postagemId);

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
