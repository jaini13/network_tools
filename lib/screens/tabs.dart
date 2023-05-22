
import 'package:flutter/material.dart';
import 'package:network_tools/screens/dashboard.dart';
import 'home.dart';


class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Networking Tools",
          style: TextStyle(
            color: Color(0xffE6E6E6),
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),),
          backgroundColor: Color(0xff2C2E43),
          centerTitle: true,
          bottom: const TabBar(
            //labelColor:,
            indicatorColor: Color(0xffE6E6E6) ,
            //unselectedLabelColor: Color(0xff3C415C),
            tabs: [
              Tab(child: Text("Home",
              style: TextStyle(
                color: Color(0xffE6E6E6),
                fontSize: 17
              ),),),
              Tab(child: Text("Tools",
                style: TextStyle(
                    color: Color(0xffE6E6E6),
                    fontSize: 17
                ),)
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
           DashBoard (), Home()
          ],
        ),
      ),
    );
  }
}
