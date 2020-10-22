import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'dart:async';
import '../../API/API.dart';
import 'dart:convert';
import 'package:voyager/screens/profilescreen/background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class MyProfileImages extends StatefulWidget{
  final String myName;
 final String email;
 final String phone;
  MyProfileImages(this.myName,this.email,this.phone);
  @override
  State<StatefulWidget> createState() {
    return _StateImages(myName,email,phone);
  }

}
class _StateImages extends State<MyProfileImages>{
 final String myName;
 final String email;
 final String phone;
  _StateImages(this.myName,this.email,this.phone);

  File imagePicker;
  String avatar="assets/image/users/default.png";


  _openGallery(BuildContext context)async{
    var picture=await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedImage=await ImageCropper.cropImage(
      sourcePath: picture.path,
      // aspectRatio: CropAspectRatio(ratioX: 1,ratioY: 1),
      maxHeight:8,
      maxWidth: 4,
      cropStyle: CropStyle.circle,
      compressQuality: 10,
      androidUiSettings: AndroidUiSettings(cropGridStrokeWidth: 10),
    );
    this.setState((){
      imagePicker=picture ;
    });
    Navigator.of(context).pop();

  }

  _openCamera(BuildContext context)async{
    var picture=await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedImage=await ImageCropper.cropImage(
        sourcePath: picture.path,
        aspectRatio: CropAspectRatio(ratioX: 2,ratioY: 2),
        maxHeight: 250,
        maxWidth: 250,

        cropStyle: CropStyle.circle,
        compressQuality: 10


    );
    this.setState((){
      imagePicker=picture ;
    });
    Navigator.of(context).pop();
  }

  Dio dio=new Dio();
  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Color(0xFFF4F8FF),
        elevation: 4,
        shape: Border.all(width: 1,color: Colors.black),
        title: Text('Make a Choose'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: ()async{
                 await _openGallery(context);
                  uploadYourImage(imagePicker);

                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              GestureDetector(
                child: Text('Camera'),
                onTap: ()async{
                 await _openCamera(context);
                  uploadYourImage(imagePicker);

                },
              )
            ],
          ),
        ),
      );
    });
  }


  uploadYourImage(File profileImage)async{
    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');



      print("\nwe are in upload profile image\n");
    String authentication= 'Bearer ' + currentToken;

      _setHeaders()=>{
      'Content-type' : 'application/json',
//        "Accept": 'application/json',
        "Authorization": authentication
      };
      String mainUrl ="http://10.0.2.2:8000/api/auth/update";

     try{
      String fileName=profileImage.path.split('/').last;
      FormData formData=new FormData.fromMap({
        'avatar': await MultipartFile.fromFile(profileImage.path,filename: fileName,
        contentType:  MediaType('image','jpg')),
        'type' : 'image/png'
      }
      );
      Response response= await dio.post(mainUrl,data: formData,options: Options(headers: _setHeaders()));
     }catch(e){
       print('error');
print(e);
     }

}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(alignment: Alignment.topCenter, children: <Widget>[
        Background(),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: Container(
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
            ),
            child: CircleAvatar(
              radius: 70.0,
              backgroundImage: imagePicker == null ?
                AssetImage(avatar)
                  : FileImage(imagePicker),
              child: Container(
                height: MediaQuery.of(context).size.height*0.200,
                width: MediaQuery.of(context).size.width*0.425,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,),
                child: Stack(children: <Widget>[
                  Positioned(
                      bottom: 0,
                      right: 1,
                      child: Container(

                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(30)
                        ),
                        padding: EdgeInsets.only(top: 6),
                        child: Material(
                          color: Color(0xFFE9EFF1),

                          borderRadius: BorderRadius.circular(30.0),
                          elevation: 2.0,
                          child: IconButton(

                            iconSize: 25.0,
                            icon: Icon(
                              Icons.photo_camera,
                               color: Color(0xFF839195),
                            ),
                            onPressed: (){_showChoiceDialog(context);},
                            splashColor: Colors.transparent,
                            highlightColor: Colors
                                .transparent, // makes highlight invisible too
                          ),
                        ),
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