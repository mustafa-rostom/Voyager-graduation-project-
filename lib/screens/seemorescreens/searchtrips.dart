import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../API/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '.././tripdetails.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchTrips extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateSearchTrips();
  }
}
class StateSearchTrips extends State<SearchTrips>{


 bool _isLoading=false;

 static const provinceItems=<String>[
   'Alexandria',
   'Aswan',
   "Asyut",
   'Beheira',
   'Beni Suef',
   'Cairo',
   'Dakahlia',
   'Damietta',
   'Faiyum',
   'Gharbia',
   'Giza',
   'Ismailia',
   'Kafr El Sheikh',
   'Luxor',
   'Matruh',
   'Minya',
   'Monufia',
   'New Valley',
   'North Sinai',
   'Port Said',
   'Qalyubia',
   'Qena',
   'Red Sea',
   'Sharqia',
   'Sohag',
   'South Sinai',
   'Suez',
 ];
 var startUp='Cairo';
 var destination='Cairo';
//final searchTripController=TextEditingController();
  List<dynamic> searchResults;
  var noResultMessage;

  Widget showSearchResult() {
    if(searchResults==null&&noResultMessage==null&&_isLoading==true)
     {
       return  Container(
        //    height: MediaQuery.of(context).size.height * 0.6,
        color: Color(0xFFE5F3EB),
        child:  CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),

    )
      );
     }else if(searchResults!=null) {
      return Expanded(
        child: Container(
          color: Color(0xFFE5F3EB),
            child: SingleChildScrollView(
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,

                children:
                searchResults.map((tr){
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
      );
    }else if(noResultMessage!=null){
      return  Expanded(
        child: Container(
            //    height: MediaQuery.of(context).size.height * 0.6,
            color: Color(0xFFE5F3EB),
            child: Center(child: Text("No trips found")),
        ),
      );
    }else if (_isLoading==false){
      return Container(
        child:Center(child: Text("search for the trip you want"))
      );
    }

}
  getSearchedTrips() async {
    print("\nwe are in searched trips\n");
     setState(() {
       _isLoading=true;
       searchResults=null;
       noResultMessage=null;
     });



    const String mainUrl ="trips/search";
    _setHeaders()=>{
      'Content-type' : 'application/json',
    };
    var data = {
      'from': startUp,
      'to': destination,
    };

    var res = await CallApi().postData(data, mainUrl, _setHeaders());

    var body = json.decode(res);

    print(body);

    var accepted=body["success"];
    if(accepted!=null){
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
        searchResults=tempSearchResults;

      });
    }else{
      setState(() {
        noResultMessage=body["message"];
      });
    }




    print(searchResults);

//    setState(() {
//
//    });



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, ),
              margin: EdgeInsets.only(top:30.0),
              height: 40.0,
           //   color: Color(0xFFE9EFF1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                // border: Border.all(width: 5),
                 color: Color(0xFFE9EFF1)
              ),
              child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

              Container(
                width: 40.0,
                height: 29.0,
                child: Text(
                  "From",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Color(0xFF3FCC59),
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),

              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 35.0,
                width: MediaQuery.of(context).size.width* 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xFFE9EFF1),

                ),
                child:Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: DropdownButton<String>(
                    underline: null,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF839195),
                        fontSize: 10
                    ),
                    isExpanded: true,
                    items: provinceItems.map((String dropDownStringItems){
                      return DropdownMenuItem<String>(
                        value: dropDownStringItems,
                        child: Text(dropDownStringItems),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected){
                        setState(() {
                          this.startUp=newValueSelected;
                        });
                    },
                    value: startUp,
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                width:  MediaQuery.of(context).size.width* 0.04,
              ),
/////////////////////////////////////////////////////////////////////////
              Container(
                width: 20.0,
                height: 29.0,
                child: Text(
                  "To",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Color(0xFF3FCC59),
                      fontWeight: FontWeight.w600
                  ),
                ),

              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 35.0,
                width: MediaQuery.of(context).size.width* 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    //  border: Border.all(width: 5),
                    color: Color(0xFFE9EFF1)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: DropdownButton<String>(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF839195),
                        fontSize: 10
                    ),
                    isExpanded: true,
                    items: provinceItems.map((String dropDownStringItems){
                      return DropdownMenuItem<String>(
                        value: dropDownStringItems,
                        child: Text(dropDownStringItems),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected){
                        setState(() {
                          this.destination=newValueSelected;
                        });
                    },
                    value: destination,
                  ),
                ),
              ) ,
                Center(
                  child: Material(
                    child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFAAADAD),

                ),
                      child: IconButton(
                        iconSize: 27.0,
                        icon: Icon(Icons.search,color: Colors.black87),
                        //   color: Color(0xFF3FCC59),

                        onPressed: getSearchedTrips,
//                splashColor: Colors.transparent,
//                highlightColor: Colors
//                    .transparent, // makes highlight invisible too
                      ),
                    ),
                  ),
                ),])
            ),

            showSearchResult(),

          ],
        )
    ) ;
  }

}