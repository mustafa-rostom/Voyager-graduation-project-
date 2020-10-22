import 'package:flutter/material.dart';
import 'package:voyager/screens/tripdetails.dart';
import 'package:voyager/screens/tripdetailscreens/tripofferresponseforothers.dart';
import '.././API/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home.dart';

class MyNotification extends StatefulWidget {

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<MyNotification> {
   String myName;
   String avatar;
   int rating;
   int userId;

  List<dynamic> _notifications;
   getUserInfo(BuildContext context) async {

     SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
     String currentToken=tokenLocalStorage.getString('token');

     print("\nwe are in get user info\n");
     print(currentToken);
     String authentication= 'Bearer ' + currentToken;
     print(authentication);
     _setHeaders()=>{
//      'Content-type' : 'application/json',
       "Accept": 'application/json',
       "Authorization": authentication
     };
     var data = {



     };
     const String mainUrl ="auth/getUser";


     var res = await CallApi().postData(data,mainUrl,_setHeaders());




     var body = json.decode(res);

     print(body);

     print(body["success"]);
     setState(() {
       myName=body["success"]["name"];
       avatar=body["success"]["avatar"];
       rating=body["success"]["rate"];
       userId=body["success"]["id"];
     });



   }
  getUserNotification(BuildContext context) async {

    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');

    print("\nwe are in get user notification\n");
    print(currentToken);
    String authentication= 'Bearer ' + currentToken;
    print(authentication);
    _setHeaders()=>{
//      'Content-type' : 'application/json',
      "Accept": 'application/json',
      "Authorization": authentication
    };

    String mainUrl ="notifications";


    var res = await CallApi().getDataWithAuth(mainUrl,_setHeaders());




    var body = json.decode(res);

    print(body);

    print(body["success"]);


    setState(() {
      _notifications=body['notifications'];
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserNotification(context);
    getUserInfo(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notifications',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
        elevation: 0,
        actions: <Widget>[
           Padding(
             padding: const EdgeInsets.only(right:8.0),
             child: Icon(Icons.notifications,size: 30.0,color: Colors.grey,),
           ),
        ],
      ),
      body:
      _notifications==null||_notifications.isEmpty==true?
          Container(
            color: Colors.grey,
          ):
      SingleChildScrollView(
        child: Column(
          children: _notifications.map((not){
              return Container(
              height: MediaQuery.of(context)
              .size
              .height * 0.14,
          width: MediaQuery
              .of(context)
              .size
              .width * 1,
          color: Colors.white,
         
          child: Material(
            child:
            GestureDetector(
              onTap: (){
                if(not['type']=="App\\Notifications\\NewOffer")
               { Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context)=>TripDetailsView(
                      not['data']['trip'],myName,rating,userId,avatar


                    ),
                  ),
                );}else if(not['type']=="App\\Notifications\\OfferAccepted"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context)=>TripOfferResponse(
                          not['data']['trip'],not['data']['avatar'],not['data']['message'],1,
                      ),
                    ),
                  );
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context)=>TripOfferResponse(
                          not['data']['trip'],not['data']['avatar'],not['data']['message'],0
                      ),
                    ),
                  );
                }
              },
              child: Card(
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02,),
                    Container(
                      width: 60,
                      height: 60,
                      child:  CircleAvatar(child:  not['data']['avatar']==null?
                      CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),

                      ):
                      CircleImage(radios: 25, imageProvider: NetworkImage(not['data']['avatar'])
                      ),
                        backgroundColor: Colors.white,

                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,

                      ),),
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.02,),
                    Text('${not['data']['name']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    // user name
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width * .02,),
                    Expanded(child: Text(
                      '${not['data']['message']} ', style: TextStyle(fontSize: 14),))
                  ],
                ),
              ),
            ),
          ),
        );
        }).toList(),
        ),
      ),
    );
  }
}