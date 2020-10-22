import 'package:flutter/material.dart';
import '.././profilescreen/taboffercontent.dart';
import '.././profilescreen/tabstripscontent.dart';

class ProfileTabsView extends StatefulWidget{
  final BuildContext ctx;
  ProfileTabsView(this.ctx);
  @override
  State<StatefulWidget> createState() {

    return _StateProfileTabsView(ctx);
  }

}
class _StateProfileTabsView extends State<ProfileTabsView> with TickerProviderStateMixin{
  final BuildContext ctx;
  _StateProfileTabsView(this.ctx);
  TabController _tabController;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.99,
      height: MediaQuery.of(context).size.height*0.47,
      color: Colors.white,
      child:
      Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height*0.07,
            // margin: EdgeInsets.only(left: 60),
            child: TabBar(
              tabs: [
                Container(
                  width: 70.0,
                  child: new Text(
                    'Trips',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: 70.0,
                  child: new Text(
                    'Offers',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor:Color(0xFF3FCC59),
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.all(10),
              isScrollable: true,
              controller: _tabController,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.35,
            child: TabBarView(
                controller: _tabController,
                children: <Widget>[
//Text("my trips"),
                    ShowMyTrips(ctx),  //first tab view

                  ShowMyOffer(ctx)
                ]),
          )
        ],
      ),
    );
  }


}
