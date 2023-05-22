import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reorderables/reorderables.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String deviceIP = '';
  String networkIPAddress = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingIP();
    getinternetIP();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
       body: Container(
         height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.black,
            //     Colors.black54
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //
            // )
          ),
          child: ReorderableColumn(
            scrollController: ScrollController(),
            onReorder: (oldIndex, newIndex) {

            },
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                key: UniqueKey(),
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/mobile.png',height: 60,),
                            Text(deviceIP.toString(),style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/signal.png',height: 60,),
                            Text(networkIPAddress,style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/globe.png',height: 55,),
                            Text('Unavailable',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                key: UniqueKey(),
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/mobile.png',height: 60,),
                            Text(deviceIP.toString(),style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/signal.png',height: 60,),
                            Text(networkIPAddress,style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/globe.png',height: 55,),
                            Text('Unavailable',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),)
                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }

  gettingIP() async {
    await Permission.location.request();
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
    deviceIP = hostAddress.toString();
    setState(() {});
  }

  Future<String> fetchNetworkIPAddress() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await Dio().get('https://api.ipify.org?format=json');
        if (response.statusCode == 200) {
          return response.data['ip'];
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return '';

  }

  getinternetIP() async
  {
    String ipAddress = await fetchNetworkIPAddress();
    setState(() {
      networkIPAddress = ipAddress;
    });
  }

}
