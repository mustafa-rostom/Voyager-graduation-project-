import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/screens/profilescreen/images.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:rating_bar/rating_bar.dart';
import '../API/API.dart';
import 'dart:convert';
import '../screens/profilescreen/tabstripscontentohters.dart';

class Profile extends StatefulWidget {
  final int otherUserId;
  Profile(
      this.otherUserId
      );
  @override
  State<StatefulWidget> createState() {
    return _StateProfile(otherUserId);
  }
}

class _StateProfile extends State<Profile> {
  final int otherUserId;
  _StateProfile(
      this.otherUserId
      );
  String myName;
  String avatar;
  int rating;
  int userId;
  String email;
  String phone;
  getOthersProfile(BuildContext context) async {

//    _setHeaders()=>{
//      'Content-type' : 'application/json',
//      "Accept": 'application/json',
//    };

     String mainUrl ="auth/profile/"+otherUserId.toString();


    var res = await CallApi().getData(mainUrl);




    var body = json.decode(res);

    print(body);

    print(body["success"]);
    setState(() {
      myName=body["User Data"]["name"];
      email=body["User Data"]["email"];
      phone=body["User Data"]["phone_number"];
      avatar=body["User Data"]["avatar"];
      userId=body["User Data"]["id"];

    });



  }
  getMyRating(BuildContext context) async {


    print("\nwe are in get my rating\n");

    String mainUrl ="rates/"+otherUserId.toString();
    print(mainUrl);
    var res = await CallApi().getData(mainUrl);

    var body = json.decode(res);
    print(body);


    setState(() {
      rating=body['rating'];

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOthersProfile(context);
    getMyRating(context);
  }

  @override
  Widget build(BuildContext context) {
         print('here is wedgit of profile');

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
                  Images(avatar),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
//                        border: Border.all(width: 2)
                      ),
                      child: Column(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
//                            border: Border.all(width: 2)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * .01),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.66,
                                decoration:
                                BoxDecoration(
                                  //   border: Border.all(width: 2)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    myName==null?
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      color: Color(0xFFE9EFF1),
                                    )
                                    :Text(
                                      "$myName",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          letterSpacing: .5,
                                          color: Color(0xFF2B2B2B)),
                                        textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),

                                       Icon(
                                         Icons.check_circle,
                                          color: Color(0XFF3FCC59),
                                        ),


                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          //  padding: EdgeInsets.only(right:100),
                          decoration: BoxDecoration(
                            //  border: Border.all(width: 2)
                          ),
                          child: myName==null?
                          Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            height: MediaQuery.of(context).size.height*0.05,
                            color: Color(0xFFE9EFF1),
                          )
                              :Text(
                            phone==null?"phone number":"$phone",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                letterSpacing: 1,
                                color: Color(0xFF2B2B2B),

                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          //  padding: EdgeInsets.only(right:100),
                          decoration: BoxDecoration(
                            // border: Border.all(width: 2)
                          ),
                          child: myName==null?
                          Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            height: MediaQuery.of(context).size.height*0.05,
                            color: Color(0xFFE9EFF1),
                          )
                              :Text(
                            "$email",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF2B2B2B)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          width: 150,
                          height: 20,
                          child: RatingBar.readOnly(
                            initialRating: rating==null? 0:double.parse(rating.toString()),
                            maxRating: 5,
                            emptyColor: Color(0xFFB8B8B8),
                            filledColor: Color(0xFFFFC107),

                            size: 25,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star,
                          ),
                        ),


                      ]),
                    ),
                  ),
SizedBox(
  height: MediaQuery.of(context).size.height*0.05,
),
Container(
  height: 200.0,
  child: ShowOtherUserTrips(otherUserId)
  ,
)
                ])
            )
        )
    );
  }
}
