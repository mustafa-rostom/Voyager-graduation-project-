

import 'package:flutter/material.dart';
import 'package:voyager/screens/seemoretrips.dart';
import 'homescreen/hello.dart';
import 'homescreen/search.dart';
import 'homescreen/recenttrips.dart';
import 'homescreen/topvoyager.dart';
import '../API/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';
import 'package:transparent_image/transparent_image.dart';



//import 'package:voyager/trips.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String myName;
  String avatar;
  String email;
  Widget myDrawer(String avatar){
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('$myName'),
      accountEmail: Text('$email'),
      currentAccountPicture: CircleAvatar(
       // radius: 50.0,
        child:
//        Stack(
//          children: <Widget>[
//            Center(child: CircularProgressIndicator()),
//            Center(
//              child: FadeInImage.memoryNetwork(
//                placeholder: kTransparentImage,
//                image: 'avatar',
//              ),
//            ),
//          ],
//        ),
//        Image.network(avatar),
        avatar!=null? CircleImage(radios: 35, imageProvider: NetworkImage(avatar))
            :Container(
          //    height: MediaQuery.of(context).size.height * 0.6,
            color: Color(0xFFE5F3EB),
            child:  CircularProgressIndicator(
              value: 5.0,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),

            )
        ),
        backgroundColor: Colors.white,
      ),
    );

    final drawItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('to page 1'),
          //onTap: ,
        ),
        ListTile(
          title: Text('to page 2'),
        ),
        ListTile(
          title: Text('logout'),
          leading: Icon(Icons.arrow_back_ios),
          onTap: (){logout(context);},
        )

      ],
    );
    return drawItems;
  }
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
      email=body["success"]["email"];
      avatar=body["success"]["avatar"];
      tokenLocalStorage.setInt("Id", body["success"]["id"]);
    });



  }


  logout(BuildContext context) async {
    SharedPreferences tokenLocalStorage = await SharedPreferences.getInstance();
    String currentToken = tokenLocalStorage.getString('token');
    print("\nwe are in get user info\n");
    print(currentToken);
    String authentication = 'Bearer ' + currentToken;
    print(authentication);
    _setHeaders() =>
        {
//      'Content-type' : 'application/json',
          "Accept": 'application/json',
          "Authorization": authentication
        };
    var data = {
    };
    const String mainUrl = "auth/logout";


    var res = await CallApi().postData(data, mainUrl, _setHeaders());


    var body = json.decode(res);

    print(body);

    print(body["success"]);
   tokenLocalStorage.clear();
   currentToken=null;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>Login()));
  }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo(context);
  }
  @override
  Widget build(BuildContext context) {
    print('here is wedgit of home');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          iconTheme: new IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[

                      CircleAvatar(child:  avatar==null?
                      CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),

                      ):
                      CircleImage(radios: 20, imageProvider: NetworkImage(avatar)
                      ),
                        backgroundColor: Colors.white,

                      )



            ],
        ),
        drawer: Drawer(
          child: myDrawer(avatar),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),

           myName==null?
           Container(
             child: CircularProgressIndicator(
               strokeWidth: 2,
               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

             ),
           )
               : Hello(myName),

            SizedBox(
              height: 5,
            ),

            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Ready for a new trip?',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // search area /////////
            Search(),

            SizedBox(
              height: 20,
            ),
            /////////////////////////////////////////Recently added/////////////////////////////////////////
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                    'Recently added',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent, // makes highlight invisible too
                      onTap: (){
//                    TextStyle(decoration: TextDecoration.underline);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context)=>SeeMoreTrips(),
                          ),
                        );                      },
                      child: Text("See More..",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3FCC59) ,


                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                )
              ],
            ),

            RecentTrips(),

            SizedBox(
              height: 2.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Top voyagers',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TopVoyager(),
          ],
        ),


        // navigation bottom bar/////////////////


      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  CircleImage({this.imageProvider, this.radios = 20});

  final NetworkImage imageProvider;
  final double radios;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: radios,
          backgroundImage: imageProvider,
        )
      ],
    );
  }
}
