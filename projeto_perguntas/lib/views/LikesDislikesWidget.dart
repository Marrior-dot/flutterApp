import 'package:flutter/material.dart';
import 'package:projeto_perguntas/api/postagem.dart';

class LikesDislikesWidget extends StatefulWidget {
  int likes;
  final int dislikes;
  final int postagemId;
  final String userName;
  LikesDislikesWidget(
      {super.key,
      required this.likes,
      required this.dislikes,
      required this.postagemId,
      required this.userName,
      });

  @override
  LikesDislikesState createState() => LikesDislikesState();
}

class LikesDislikesState extends State<LikesDislikesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder(future: checkLike(widget.userName, widget.postagemId), 
    builder: (context, snapshot){
    List<bool?> sendButton =  snapshot.data ?? [true,true] ;
    int likeOpacity = sendButton[1] == true ? 200 : 100;
    int dislikeOpacity = sendButton[0] == true ? 200 : 100;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: IconButton(
              onPressed: sendButton[0] == true ? () async {
                await updateLikeDislike(
                    'dislikes', widget.postagemId, widget.dislikes);
                await persistencaLikeDislike(
                    widget.userName, widget.postagemId, false, null);
                setState(() {
                  sendButton[0] == null;
                  dislikeOpacity = 100;
                });
              }: null,
              icon: Icon(Icons.thumb_down),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                Color.fromARGB(dislikeOpacity, 105, 105, 105),
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    onPressed: sendButton[1] == true
                        ? () async {
                            await updateLikeDislike(
                                'likes', widget.postagemId, widget.likes);
                            await persistencaLikeDislike(
                                widget.userName, widget.postagemId, true,null);
                            setState(() {
                              sendButton[1] = null;
                              widget.likes += 1;
                              likeOpacity = 100;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.thumb_up),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                      Color.fromARGB(likeOpacity, 43, 142, 255),
                    )),
                  )),
              SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text("${widget.likes} likes"))
            ],
          ),
        ],
      ),
    );
    }
    );
  }}