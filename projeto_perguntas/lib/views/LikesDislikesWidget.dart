import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/postagem.dart';

class LikesDislikesWidget extends StatefulWidget {
  int likes;
  final int dislikes;
  final int postagemId;
  final String userName;
  bool? sendButton;
  LikesDislikesWidget({required this.likes, required this.dislikes, required this.postagemId, required this.userName, required this.sendButton});

  @override
  LikesDislikesState createState() => LikesDislikesState();
}

class LikesDislikesState extends State<LikesDislikesWidget>{

  int likeOpacity = 200;
  int dislikeOpacity = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  
                                  onPressed: () async {
                                    await updateLikeDislike(
                                        'dislikes',
                                        widget.postagemId,
                                        widget.dislikes);
                                        setState((){
                                          dislikeOpacity = 100;
                                        });
                                  },
                                  icon: Icon(Icons.thumb_down),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                    Color.fromARGB(dislikeOpacity, 105, 105, 105),
                                  )),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.1,
                                    child:
                                          IconButton(
                                            onPressed: widget.sendButton == true?() async{
                                              await updateLikeDislike(
                                                      'likes',
                                                      widget.postagemId,
                                                      widget.likes);
                                              await  persistencaLike(widget.userName, widget.postagemId);
                                              setState((){
                                                  widget.sendButton = null;
                                                  widget.likes += 1;
                                                  likeOpacity = 100;
                                              });
                                            }: null,
                                              icon: const Icon(Icons.thumb_up),
                                              style: ButtonStyle(
                                                  
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                Color.fromARGB(likeOpacity, 43, 142, 255),
                                              )),
                                            )
                                  ),
                                  SizedBox(
                                      height: 20,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.4,
                                      child: 
                                            Text(
                                                "${widget.likes} likes"
                                                )
                                          )
                                ],
                              ),
                            ],
                          ),
                        );
  }
}