import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/maketrip.dart';
import '../screens/myprofile.dart';

import './seemorescreens/searchtrips.dart';
import '../screens/notificationview.dart';


class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  List<Widget> _pages=[
    Home(),
    SearchTrips(),
    MyNotification(),
    MyProfile()
  ];
  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('here is wedgit of tabs screen');
    return Scaffold(
      body: _pages[_selectedPageIndex] ,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        //autofocus: false,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF3FCC59),
        elevation: 8,
        splashColor: Colors.black45,
        mini: false,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MakeTrip(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(notchMargin: 10,
        child: BottomNavigationBar(
          elevation: 10,
          iconSize: 30.0,
          onTap: _selectPage,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black54,
          selectedItemColor: Color(0xFF3FCC59),
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              //backgroundColor:Colors.green,
                icon: Icon(Icons.home,),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('')
            )
          ],
        ),
      ),

    );
  }
}


