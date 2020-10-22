import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/screens/maketrip.dart';
import '../../API/API.dart';
import 'dart:convert';
import '.././tripscreen/updatetripview.dart';

class ShowMyTrips extends StatefulWidget{
  final BuildContext ctx;
  ShowMyTrips(this.ctx);
  @override
  State<StatefulWidget> createState() {
    return _StateShowMyTrips(ctx) ;
  }

}
class _StateShowMyTrips extends State<ShowMyTrips>{
  final BuildContext ctx;
  _StateShowMyTrips(this.ctx);
  List<dynamic> allTrips;
  var noResultMessage;
  var messageDeleted;
  var messageConnection;
  Future<void> _showChoiceDialog(BuildContext context,
      int tripId,
      String from,
      String to,
      String carModel,
      int tripPrice,
      int numOfSeats,
      String tripDate,
      String description,
       ){
    return showDialog(context: context, builder: (BuildContext context){

      return AlertDialog(
        backgroundColor: Color(0xFFF4F8FF),
        elevation: 4,
        shape: Border.all(width: 1,color: Colors.black),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                  child: Text('Update'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder:
                        (BuildContext context)=>UpdateTrips(
                        tripId,
                        from,
                        to,
                        carModel,
                        tripPrice,
                        numOfSeats,
                        tripDate,
                        description
                    )));

                 }
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              GestureDetector(
                child: Text('Delete'),
                onTap: ()async{
                  Navigator.pop(context);
                  await  deleteTrip(context,tripId);
                  //    print(messageDeleted);
                  if(messageDeleted!=null){
                    Scaffold.of(ctx).showSnackBar(
                        SnackBar(
                          content: Text("$messageDeleted"),
                        ));
                    messageDeleted=null;
                  }else if(messageConnection!=null){
                    Scaffold.of(ctx).showSnackBar(
                        SnackBar(
                          content: Text("$messageConnection"),
                        ));
                    messageConnection=null;
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }


  deleteTrip(BuildContext context,int tripId) async {
    print("\nwe are in delete user trip");

    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');

    print(currentToken);
    String authentication= 'Bearer ' + currentToken;
    print(authentication);
    _setHeaders()=>{
//      'Content-type' : 'application/json',
      "Accept": 'application/json',
      "Authorization": authentication
    };

    String mainUrl ="trips/"+tripId.toString();


    try{var res = await CallApi().deleteData(mainUrl,_setHeaders());




    var body = json.decode(res);

    print(body);

    print(body["success"]);
    if(body["success"]==true)
    {
      messageDeleted=body['message'];

      getUserTrips(context);

    }
    }catch(error){
      print(error);
      messageConnection="connection failed";
    }
  }

  Widget showMyProfileTrips() {
    if(allTrips==null&&noResultMessage==null)
    {
      return  Container(
          color: Color(0xFFE5F3EB),
          child:  Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),

            ),
          )
      );
    }else if(allTrips!=null&&allTrips.isNotEmpty) {
      return Expanded(
        child: Container(
          color: Color(0xFFE5F3EB),
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children:
              allTrips.map((tr){
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0 , horizontal: 2.0),
                  elevation: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    color: Color(0xFFD0ECD8),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:40,
                          backgroundColor: Color(0xFF053218),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                                child: Text('${tr["price_per_passenger"]} LE',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF3FCC59),
                                      fontFamily: 'Poppins'),)),
                          ),),
//                          trailing: IconButton(
//                            icon: Icon(Icons.delete),
//                            color: Theme.of(context).errorColor,
//                            onPressed: (){},
//                          ),
                        title: Text('${tr["from"] }  ->  ${tr["to"]}',
                          style: TextStyle(
                              fontSize: 15.0, fontFamily: 'Poppins',fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                    DateFormat.yMMMEd().format(DateTime.parse(tr["departure_date"]))),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  DateFormat.jm().format(DateTime.parse(tr["departure_date"])),
                                ),
                              ],
                            ),

                          ],
                        ),
                        onLongPress: (){
                          _showChoiceDialog(context,
                              tr['id'],
                            tr['from'],
                            tr['to'],
                            tr['car_model'],
                            tr['price_per_passenger'],
                              tr['number_of_empty_seats'],
                              tr['departure_date'],
                               tr['description'],
                          );
                        },
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TripDetailsView(tr['trip']['id'],tr['user']['name'],tr['user']['rate'],tr['user']['id'])));

                        },

                      ),
                    ),
                  ),
                );
                //Card(child:


              }).toList()
              ,

            ),
          ),

        ),
      );
    }else if(allTrips.isEmpty){
      return  Container(
        //    height: MediaQuery.of(context).size.height * 0.6,
        color: Color(0xFFE5F3EB),
        child: Center(child: Text(noResultMessage!=null ?"$noResultMessage":"No trips made")),
      );
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserTrips(context);

  }


  getUserTrips(BuildContext context) async {

    print("\nwe are in get user trips\n");

    SharedPreferences tokenLocalStorage=await SharedPreferences.getInstance();
    String currentToken=tokenLocalStorage.getString('token');

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

    print(body['success']['trips']);

    setState(() {
      allTrips=body['success']['trips'];
    });



  }

  @override
  Widget build(BuildContext context) {
    return showMyProfileTrips();
  }

}