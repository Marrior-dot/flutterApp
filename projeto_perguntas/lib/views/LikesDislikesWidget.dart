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
                                  onPressed: () {
                                    updateLikeDislike(
                                        'dislikes',
                                        widget.postagemId,
                                        widget.dislikes);
                                  },
                                  icon: Icon(Icons.thumb_down),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                    Color.fromARGB(200, 105, 105, 105),
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
                                            onPressed: widget.sendButton == true?(){
                                              setState((){
                                                updateLikeDislike(
                                                      'likes',
                                                      widget.postagemId,
                                                      widget.likes);
                                                  persistencaLike(widget.userName, widget.postagemId);
                                                  widget.sendButton = null;
                                                  widget.likes += 1;
                                                  //likeText = likeText + 1;
                                              });
                                            }: null,
                                              icon: const Icon(Icons.thumb_up),
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                Color.fromARGB(200, 43, 142, 255),
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