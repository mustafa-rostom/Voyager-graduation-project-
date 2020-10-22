import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyager/screens/maketrip.dart';
import '../../API/API.dart';
import 'dart:convert';
import '.././tripscreen/updatetripview.dart';

class ShowOtherUserTrips extends StatefulWidget{
  final int otherUserId;
  ShowOtherUserTrips(this.otherUserId);
  @override
  State<StatefulWidget> createState() {
    return _StateShowOtherUserTrips(otherUserId) ;
  }

}
class _StateShowOtherUserTrips extends State<ShowOtherUserTrips>{
  final int otherUserId;
  _StateShowOtherUserTrips(this.otherUserId);
  List<dynamic> allTrips;
  var noResultMessage;
  var messageDeleted;
  var messageConnection;



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


    print("\nwe are in get all trips\n");


    const String mainUrl ="trips";


    var res = await CallApi().getData(mainUrl);




    var body = json.decode(res);

  //  print(body);

    List<dynamic> tempSearchResults=body["data"];
    List<dynamic> newList=[];
    for(var i=0;i<tempSearchResults.length;i++)
    {
      if(tempSearchResults[i]["user_id"]==otherUserId)
      {
        newList.add(tempSearchResults[i]);
      }
    }
    setState(() {
      allTrips=newList;
    });

    print(allTrips);






  }

  @override
  Widget build(BuildContext context) {
    return showMyProfileTrips();
  }

}