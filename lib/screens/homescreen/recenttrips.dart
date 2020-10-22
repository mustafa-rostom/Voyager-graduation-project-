import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../API/API.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '.././tripdetails.dart';

class RecentTrips extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateRecentTrips();
  }


}
class _StateRecentTrips extends State<RecentTrips>{

   List<dynamic> _lastTenTrips;
  @override
  void initState() {
    super.initState();
    getRecentTrips(context);
  }
  getRecentTrips(BuildContext context) async {


    print("\nwe are in get recent trips\n");


    const String mainUrl ="trips";


    var res = await CallApi().getData(mainUrl);




    var body = json.decode(res);

    print(body);

    setState(() {
      _lastTenTrips=body["data"];

    });



  }

  @override
  Widget build(BuildContext context) {
    print("we are in recent trips state func");


    return  _lastTenTrips==null ?
    Container(
    width: MediaQuery.of(context).size.width*0.905,
    height: MediaQuery.of(context).size.height*0.210,
    margin: EdgeInsets.only(left: 25.0),
    child: Row(children: <Widget>[
    Container(
    width: MediaQuery.of(context).size.width*0.439,
    height: MediaQuery.of(context).size.height*0.209,
    child:  Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),

      ),
    ),
    ),
    Container(
    width: MediaQuery.of(context).size.width*0.439,
    height: MediaQuery.of(context).size.height*0.209,
    child:  Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),

      ),
    ),
    ),
    ],),
    )
   : Container(
      width: MediaQuery.of(context).size.width*0.905,
      height: MediaQuery.of(context).size.height*0.210,
      margin: EdgeInsets.only(left: 25.0),
      child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,

         child: Row(
        children: _lastTenTrips.map((tr) {
          return  Container(
            width: MediaQuery.of(context).size.width*0.439,
            height: MediaQuery.of(context).size.height*0.209,
            decoration: BoxDecoration(
              // color: Color(0xFFE5E5E5),
            ),
            child: Material(
            child: GestureDetector(
              onTap: (){
                print("welcome");
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TripDetailsView(tr['id'],tr['user']['name'],tr['user_rating'],tr['user']['id'],tr['user']['avatar'])));
              },
              child: Card(
                elevation: 0,
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width*0.438,
                      height: MediaQuery.of(context).size.height*0.107,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              //       colorFilter: ColorFilter.mode(Color(0xFF000000).withOpacity(0.4), BlendMode.darken),
                              image: AssetImage("assets/image/tripphoto.png",)
                          )
                      ),

                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width*0.438,
                      height: MediaQuery.of(context).size.height*0.080,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${tr["from"] } ->  ${tr["to"]}',
                            style: TextStyle(
                                fontSize: 13.0, fontFamily: 'Poppins',fontWeight: FontWeight.w400),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                DateFormat.yMMMEd().format(DateTime.parse(tr["departure_date"])),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF3FCC59),
                                    fontFamily: 'Poppins'),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                DateFormat.jm().format(DateTime.parse(tr["departure_date"])),
                                style: TextStyle(
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF3FCC59),
                                    fontFamily: 'Poppins'),
                              )

                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          );
        }).toList()

        ),
      ),
    );
  }

}