import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imageUrl});
  final String? imageUrl;
  
  @override
  Widget build(BuildContext context) {
    String image = './assets${imageUrl}';
    if (image != './assetsnull') {
      return Center(
        child:
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.25,
            child: 
            Image(image: AssetImage(image))  
          )
          ); 
    }
    return SizedBox.shrink();
  }
}
