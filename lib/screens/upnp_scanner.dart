import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upnp_client/upnp_client.dart';

class UpNp_Scanner extends StatefulWidget {
  const UpNp_Scanner({Key? key}) : super(key: key);

  @override
  State<UpNp_Scanner> createState() => _UpNp_ScannerState();
}

class _UpNp_ScannerState extends State<UpNp_Scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: ElevatedButton(onPressed: () {
              scanUpnp();
              setState(() {

              });
            },child: Text('Scan UPNP'),),
          )
        ],
      ),
    );
  }


  scanUpnp() async {
    var deviceDiscover = DeviceDiscoverer();
    await deviceDiscover.start(addressType: InternetAddressType.IPv4);
    var devices = await deviceDiscover.getDevices();
    devices.forEach(print);
    print(devices);
    setState(() {

    });
  }
}
