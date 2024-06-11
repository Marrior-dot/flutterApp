import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:projeto_perguntas/model/respostas.dart';
import 'package:projeto_perguntas/model/postagem.dart';

class RadioWidget extends StatefulWidget {
  //final List<dynamic> respostaTexto;
  final Postagem postagem;

  RadioWidget(
      {super.key, /*required this.respostaTexto*/ required this.postagem});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

enum SingingCharacter { lafayette, jefferson }

class _MyWidgetState extends State<RadioWidget> {
  //Comentado pois eu estava usando o widget Form antes
  //final _formKey = GlobalKey<FormState>();

  SingingCharacter? singingItem = SingingCharacter.jefferson; 

  @override
  Widget build(BuildContext context){

    List<dynamic> respostas = widget.postagem.respostas;
    int respostasLgth = respostas.length;
    bool tipoResposta = widget.postagem.escolha_unica;

    print(respostas);
    

    if(respostasLgth == 0){
      print("aq");
      return Text("");
    }

    if(tipoResposta == true){
      //print("aq");
    return 
      ListView.builder(
      shrinkWrap: true,
      itemCount: respostasLgth,
      itemBuilder: (context, index){
          return 
            ListTile(
            title: respostas[index],
            leading:Radio<SingingCharacter>(
                    value: SingingCharacter.lafayette,
                    groupValue: singingItem,
                    onChanged: (SingingCharacter? value){
                      setState(() {
                        singingItem = value;
                        });
                      } 
                    ),
            );
              }
            );       
    }
    else{
      return Text("");
    }
    }}