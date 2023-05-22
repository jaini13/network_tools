import 'package:flutter/material.dart';
import 'package:dns_client/dns_client.dart';
import 'package:network_info_plus/network_info_plus.dart';



class Dns extends StatefulWidget {
  const Dns({Key? key}) : super(key: key);

  @override
  State<Dns> createState() => _DnsState();
}

class _DnsState extends State<Dns> {

  List data = [];
  TextEditingController dnsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
        title: Text('DNS Lookup'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dnsController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xff273952)
                  )
                ),
                border: OutlineInputBorder(),
                hintText: 'amazon.com'
              ),
            ),
          ),
          Center(child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff273952)
            ),
            onPressed: () {
              getlookupData();
              getNetwrokInfo();
            },
            child: Text('Dns Lookup'),
          ),),
          Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
                itemBuilder: (context, index) {
                  return Text(data[index].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),);
                },),
          )
        ],
      ),
    );
  }



  getNetwrokInfo() async
  {
    final info = NetworkInfo();
    final wifiName = await info.getWifiName(); // "FooNetwork"
    final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
    final wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    final wifiGateway = await info.getWifiGatewayIP(); // 1// 92.168.1.1
    print(info.getWifiName());
  }

  getlookupData() async {
    data = [];
    final dns = DnsOverHttps.google();
    final response = await dns.lookup(dnsController.text);
    response.forEach((address) {
      print(address.toString());
      data.add(address.toString());
    });
    setState(() {

    });



  }
}

