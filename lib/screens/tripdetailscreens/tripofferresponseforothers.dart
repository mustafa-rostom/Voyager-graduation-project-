import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../API/API.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/home.dart';
import '../profile..dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TripOfferResponse extends StatefulWidget {
final int rateAvailable;
  final int tripId;
  final String avatar;
  final String message;
  TripOfferResponse(
      this.tripId,
      this.avatar,
      this.message,
      this.rateAvailable
      );

  @override
  _TripOfferResponseState createState() => _TripOfferResponseState(tripId,avatar,message,rateAvailable);
}

class _TripOfferResponseState extends State<TripOfferResponse> {

  final int tripId;
  final String avatar;
  final String message;
  final int rateAvailable;

  _TripOfferResponseState(
      this.tripId   ,
      this.avatar,
      this.message,
  this.rateAvailable

      );
  int userId;
  String tripMakerName;
  String from;
  String to;
  String car;
  int price;
  int seatsNum;
  String tripDate;
  String desc;
  void showRating(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.green,
            ), // set your own image/icon widget
            title: "Rate your partner",
            description: "support your driver and give him a good feedback.",
            submitButton: "SUBMIT",
            positiveComment: "We are so happy to hear 😍", // optional
            negativeComment: "We're sad to hear 😭", // optional
            accentColor: Colors.green, // optional
            onSubmitPressed: (int rating) {
              createRating(context,rating);
            },

          );
        });
  }

  createRating(BuildContext context,int rating) async {
    print('we are in create rating');

    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    String authentication = 'Bearer ' + currentToken;
print(userId);
    _setHeaders()=>{
      'Content-type' : 'application/json',
      'Accept' : 'application/x-www-form-urlencoded',
      "Authorization": authentication


    };
    var data = {
      'rating': rating,
      'rated_user_id': userId,
    };
    const String mainUrl ="rates";

      var res = await CallApi().postData(data,mainUrl,_setHeaders());

      var body = json.decode(res);

      print(body);

      print(body['data']);
      print("\n");
      print(body["success"]);

  }
  getOneTrip(BuildContext context) async {

    print("\nwe are in get one trip\n");
    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    userId=tokenLocalStorage.getInt("Id");
    print(tripId);


    String mainUrl ="trips/"+tripId.toString();
    print(mainUrl);
    var res = await CallApi().getData(mainUrl);

    var body = json.decode(res);
    print(body);


    setState(() {
      userId=body['data']['user_id'];
      tripMakerName=body['data']['username'];
      from=body['data']["from"];
      to=body['data']['to'];
      car=body['data']['car_model'];
      price=body['data']['price_per_passenger'];
      seatsNum=body['data']['number_of_empty_seats'];
      tripDate=body['data']['departure_date'];

    });
    if(rateAvailable==1){
      showRating(context);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      getOneTrip(context);



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Trip Detail',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Builder(
        builder:(context)=> tripMakerName==null?Container(
          color: Colors.white,
        )
           : SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Cover image////////////////////////////////////////////////////////////
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width * 1,
                //color: Colors.black,
                child: Image(image: AssetImage('assets/image/covertrip.png'),fit: BoxFit.cover,),
              ),
              //s SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              // car details////////////////////////////////////////////////////////////
              Container(
                height: MediaQuery.of(context).size.height * 0.135,
                width: MediaQuery.of(context).size.width * 0.92,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child:Text('Car Details',style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Text("Car Model:",style: TextStyle(fontSize: 14,color:Color(0xFF3FCC59) ),),
                        Text(car!=null?" $car":""),  // variable////////////////////////////////////////
                        SizedBox(width: MediaQuery.of(context).size.width*.1,),
                        Text('Seats :',style: TextStyle(fontSize: 14,color:Color(0xFF3FCC59) ),),
                        Text(seatsNum!=null?'$seatsNum':"") //Variable////////////////////////////////////////////////////////

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.005,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Text("Car Plate :",style: TextStyle(fontSize: 14,color:Color(0xFF3FCC59)),),
                        Text('547 ط ص ق')
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              // driver details////////////////////////////////////////////////////////////
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * .92,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Driver Details', style: TextStyle(fontSize: 18),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                    // Driver pic
                    Row(
                      children: <Widget>[
                        Container(
                          height:50.0,
                          width: 50.0,
                          child: CircleAvatar(child:  avatar==null?
                          CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),

                          ):
                          CircleImage(radios: 25, imageProvider: NetworkImage("http://10.0.2.2:8000/"+avatar)
                          ),
                            backgroundColor: Colors.white,

                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                          ),),
                        SizedBox(width:MediaQuery.of(context).size.width*0.05,),
                        Column(
                          children: <Widget>[
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context)=>Profile(userId),
                                    ),
                                  );                                }
                                ,child: Text('$tripMakerName',style:TextStyle(fontSize:16 ),)),
                            SizedBox(height: MediaQuery.of(context).size.height*0.009,),

                          ],
                        )
                      ],
                    ),
                  ],

                ),
              ),
              // trip details////////////////////////////////////////////////////////////
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.92,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Trip Details',style: TextStyle(fontSize: 18,),),
                    SizedBox(height: MediaQuery.of(context).size.height*.03,),
                    //Icon(Icons.d),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Text('From :',style: TextStyle(fontSize: 14,color:Color(0xFF3FCC59) ),),
                        Text(from!=null?'$from':'',style: TextStyle(fontSize: 14),),  // Variable////////////////
                        SizedBox(width: MediaQuery.of(context).size.width*.20,),
                        Text('To :',style: TextStyle(fontSize: 14,color:Color(0xFF3FCC59) ),),
                        Text(to!=null?'$to':'',style: TextStyle(fontSize: 14),), //Variable//////////////////
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Text('Price :',style: TextStyle(fontSize: 14,color: Color(0xFF3FCC59) ),),
                        Text(price!=null?'$price L.E':"") ,  //Variable////////////////////////
                        SizedBox(width: MediaQuery.of(context).size.width*.20,),
                        Text('Date :',style: TextStyle(fontSize: 14,color: Color(0xFF3FCC59) ),),
                        Text(tripDate!=null? DateFormat.yMMMEd().format(DateTime.parse(tripDate)):""),
                        //Variable///////////////////////
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Text('Time:',style: TextStyle(fontSize: 12,color: Color(0xFF3FCC59) ),),
                        Text( tripDate!=null? DateFormat.jm().format(DateTime.parse(tripDate)):"",style: TextStyle(fontSize: 12),)   //Variable////////////////////////

                      ],
                    ),

                  ],
                ),
              ),
            Text("$message")

            ],
          ),
        ),
      ),
    );
  }
}
