import 'package:flutter/material.dart';
import 'dart:io';

class SubnetScannerPage extends StatefulWidget {
  const SubnetScannerPage({super.key});

  @override
  State<SubnetScannerPage> createState() => _SubnetScannerPageState();
}

class _SubnetScannerPageState extends State<SubnetScannerPage> {
   TextEditingController _hostController = TextEditingController();
   TextEditingController _startPortController = TextEditingController();
   TextEditingController _endPortController = TextEditingController();
  List<String> reachableDevices = [];
  bool scanning = false;

  void startScan(String host, int start, int end ) async {
    print('HOST::${host}');
    print('END::${end}');
    print('START::${start}');

    reachableDevices = [];
    setState(() {
      scanning = true;
    });

    String subnet = '8.8.8';
    int startRange = 0;
    int endRange = 15;

    List<String> devices = await scanSubnet(host, start, end);

    if (this.mounted) {
      setState(() {
        reachableDevices = devices;
        scanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
        title: const Text('Subnet Scanner'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _hostController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Host'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _startPortController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Host'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _endPortController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Host'),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff273952)
            ),
            onPressed:(){
              scanning ? null : startScan(_hostController.text, int.parse(_startPortController.text), int.parse(_endPortController.text));
            },
            child: const Text('Scan Subnet'),
          ),],),
          if (scanning)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: reachableDevices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(reachableDevices[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

Future<List<String>> scanSubnet(String subnet, int start, int end) async {
  List<String> reachableDevices = [];

  for (int i = start; i <= end; i++) {
    String ipAddress = '$subnet.$i';
    try {
      final result = await InternetAddress(ipAddress).reverse();
      reachableDevices.add(result.toString());
      print('LIST123:::::::$reachableDevices');
    } catch (e) {
      print('ERROR:::::$e');
      // Ignore exceptions for unreachable devices
    }
  }

  return reachableDevices;
}
