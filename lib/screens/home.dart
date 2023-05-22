import 'package:flutter/material.dart';
import 'package:network_tools/screens/dns_lookup.dart';
import 'package:network_tools/screens/ip_calculator/items.dart';
import 'package:network_tools/screens/ping_tools.dart';
import 'package:network_tools/screens/port_scanner.dart';
import 'package:network_tools/screens/speed_test.dart';
import 'package:network_tools/screens/subnet_scanner_page.dart';
import 'package:network_tools/screens/trace_route_screen.dart';
import 'package:network_tools/screens/upnp_scanner.dart';
import 'package:network_tools/screens/whois_feature.dart';
import 'package:network_tools/screens/wifi_scanner.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xff595260),
              //     Color(0xff2C2E43)
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //
              // )
          ),

        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height*0.8,
                  child: GridView.extent(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    maxCrossAxisExtent: 150.0,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return SomePage();
                          },));
                        },
                          child: Align(child: buildContainer('images/divide.png', 'IP Calculator'))),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return PortScanner();
                          },));
                        },
                          child: Align(child: buildContainer('images/port_scanner.png', 'Port Scanner'))),
                      Align(child: buildContainer('images/lan.png', 'LAN')),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return WifiScan();
                          },));
                        },
                          child: Align(child: buildContainer('images/wifi.png', 'WiFi scanner'))),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return SpeedTest();
                          },));
                        },
                          child: Align(child: buildContainer('images/speed_test.png', 'Speed Test'))),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return PingTools();
                          },));

                        },
                          child: Align(child: buildContainer('images/ping.png', 'Geo Ping'))),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return TraceScreen();
                          },));

                        },
                          child: Align(child: buildContainer('images/route.png', 'Trace Route'))),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return WhoIs();
                          },));
                        },
                          child: Align(child: buildContainer('images/whois.png', 'WhoIs'))),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return UpNp_Scanner();
                            },));
                          },
                          child: Align(child: buildContainer('images/upnpscanner.png', 'UPNP Scanner'))),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Dns();
                            },));
                          },
                          child: Align(child: buildContainer('images/dns.png', 'DNS LookUp'))),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return SubnetScannerPage();
                            },));
                          },
                          child: Align(child: buildContainer('images/subnet.png', 'SubnetScanner'))),
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //         return BonsoirExampleMainWidget();
                      //       },));
                      //     },
                      //     child: Align(child: buildContainer('images/subnet.png', 'Bounjour Browser'))),


                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );

  }
  
  Widget buildContainer(String img,String text)
  {
    return Card(
      elevation: 3,
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(7)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(img,height: 35,color:Color(0xff273952) ,),
            Text(text,style: TextStyle(
              color: Color(0xff273952),
              fontSize: 13,
              fontWeight: FontWeight.w700
            ),)
          ],
        ),
      ),
    );
  }
}
