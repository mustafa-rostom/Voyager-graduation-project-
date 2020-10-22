import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/screens/profilescreen/background.dart';

class Images extends StatefulWidget{
  final String avatar;
  Images(
      this.avatar
      );
  @override
  State<StatefulWidget> createState() {
    return _StateImages(avatar);
  }

}
class _StateImages extends State<Images>{
  final String avatar;
  _StateImages(
      this.avatar
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Stack(alignment: Alignment.topCenter, children: <Widget>[

        Background(),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: Container(
//            height: MediaQuery.of(context).size.height*0.245,
//            width: MediaQuery.of(context).size.width*0.465,
            decoration: BoxDecoration(
                border: Border.all(width:5.0,color: Colors.white),
                shape: BoxShape.circle,
                boxShadow:  [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
                    offset: Offset(
                      10.0, // horizontal, move right 10
                      10.0, // vertical, move down 10
                    ),
                  )
                ],
//                shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 70.0,
              backgroundImage: avatar == null ?
              AssetImage('assets/image/users/default.png')
                  : Image.network(" http://10.0.2.2:8000/"+avatar),
              child: Container(
                height: MediaQuery.of(context).size.height*0.245,
                width: MediaQuery.of(context).size.width*0.465,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 30,
                      right: 5,
                      child: Container(
                        width: 20.0,
                        height: 20.0,


                      )
                  )
                ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

}