import 'dart:convert';
import 'package:empty_widget/empty_widget.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/postagem.dart';
import 'package:projeto_perguntas/views/PostagemList.dart';

class LikesDislikesWidget extends StatefulWidget {
  final int likes;
  final int dislikes;
  final int id;
  LikesDislikesWidget({required this.likes, required this.dislikes, required this.id});
  @override
  State<LikesDislikesWidget> createState() => LikesDislikesState();
}

class LikesDislikesState extends State<LikesDislikesWidget>{
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
                                        widget.id,
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
                                    child: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          updateLikeDislike(
                                              'likes',
                                              widget.id,
                                              widget.likes);
                                          fetchLike(
                                              widget.id);
                                        });
                                      },
                                      icon: const Icon(Icons.thumb_up),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                        Color.fromARGB(200, 43, 142, 255),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 20,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.4,
                                      child: FutureBuilder(
                                          future: fetchLike(
                                              widget.id),
                                          builder: (context, snapshot) {
                                            return Text(
                                                "${snapshot.data} likes");
                                          }))
                                ],
                              ),
                            ],
                          ),
                        );
  }
}