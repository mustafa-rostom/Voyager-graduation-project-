import 'package:flutter/material.dart';
import '../../API/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '.././tripdetails.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AllTrips extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _StateAllTrips();
  }


}
class _StateAllTrips extends State<AllTrips>{


  bool list=false;
  List<dynamic> _lastTenTrips;
  String nextPageURL;


  getAllTrips(BuildContext context) async {


    print("\nwe are in get all trips\n");


    const String mainUrl ="trips";


    var res = await CallApi().getData(mainUrl);




    var body = json.decode(res);

    print(body);
    var userId;
    SharedPreferences userIdPreference=await SharedPreferences.getInstance();
    userId=userIdPreference.getInt("Id");
    List<dynamic> tempSearchResults=body["data"];

    for(var i=0;i<tempSearchResults.length;i++)
    {
      if(tempSearchResults[i]["user_id"]==userId)
      {
        tempSearchResults.removeAt(i);
      }
    }
    setState(() {
      _lastTenTrips=tempSearchResults;
      nextPageURL=body["next_page_url"];
    });

    list=true;
    print(_lastTenTrips);

//    setState(() {
//
//    });



  }
  loadMoreTrips(BuildContext context) async {


    print("\nwe are in Load more trips\n");


     String mainUrl =nextPageURL.substring(25);
print("next page =$mainUrl");

    var res = await CallApi().getData(mainUrl);




    var body = json.decode(res);

    print(body);
    var userId;
    SharedPreferences userIdPreference=await SharedPreferences.getInstance();
    userId=userIdPreference.getInt("Id");
    List<dynamic> tempSearchResults=body["data"];

    for(var i=0;i<tempSearchResults.length;i++)
    {
      if(tempSearchResults[i]["user_id"]==userId)
      {
        tempSearchResults.removeAt(i);
      }
    }
    setState(() {
      _lastTenTrips.addAll(tempSearchResults);
      nextPageURL=body["next_page_url"];


    });

    

//    setState(() {
//
//    });



  }
  @override
  void initState() {
    if(_lastTenTrips==null)
 { getAllTrips(context);}
  super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print("we are in see all trips func");

    return Column(
      children: <Widget>[
        Container(
  //    height: MediaQuery.of(context).size.height * 0.6,
          color: Color(0xFFE5F3EB),
          child:_lastTenTrips==null?

          Column(
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),

              ),
              Text("Loadingg...")
            ],
          )

              :SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children:
              _lastTenTrips.map((tr){
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0 , horizontal: 5.0),
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
//                        trailing: IconButton(
//                          icon: Icon(Icons.delete),
//                          color: Theme.of(context).errorColor,
//                          onPressed: (){},
//                        ),
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
                            SmoothStarRating(

                                starCount: 5,
                                rating: double.parse(tr["user_rating"].toString()),
                                size: 20.0,
                                //fullRatedIconData: Icons.blur_off,
                                //halfRatedIconData: Icons.blur_on,
                                color: Color(0xFF3FCC59),
                                borderColor:Color(0xFF3FCC59),
                                spacing:0.0
                            )
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TripDetailsView(tr['id'],tr['user']['name'],tr['user_rating'],tr['user']['id'],tr['user']['avatar'])));

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
       nextPageURL!=null ? Container(
          width: MediaQuery.of(context).size.width*0.99,
          height: MediaQuery.of(context).size.height*0.05,
          child: Material(
            child: FlatButton(
              child: Text("Load More"),
              onPressed: (){
                loadMoreTrips(context);
              },
            ),
          ),
        )
           : Container()
      ],
    );
  }

}