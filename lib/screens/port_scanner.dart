// import 'package:flutter/material.dart';
//
// class PortScanner extends StatelessWidget {
//   const PortScanner({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
//
//   scanPort()
//   {
//     String target = '192.168.1.1';
//     PortScanner.discover(target, startPort: 1, endPort: 1024,
//         progressCallback: (progress) {
//           print('Progress for port discovery : $progress');
//         }).listen((event) {
//       if (event.isOpen) {
//         print('Found open port : $event');
//       }
//     }, onDone: () {
//       print('Scan completed');
//     });
//     //2. Single
//     bool isOpen = PortScanner.isOpen(target,80);
//     //3. Custom
//     PortScanner.customDiscover(target, portList : const [22, 80, 139]);
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:io';

// class PortScanner extends StatefulWidget {
//   const PortScanner({super.key});

//   @override
//   State<PortScanner> createState() => _PortScannerState();
// }

// class _PortScannerState extends State<PortScanner> {
//   String targetAddress = '';
//   List<int> openPorts = [];
//   bool scanning = false;

//   Future<void> scanPorts() async {
//     setState(() {
//       openPorts.clear();
//       scanning = true;
//     });

//     final ip = InternetAddress(targetAddress);

//     for (var port = 1; port <= 65535; port++) {
//       final socket =
//           await Socket.connect(ip, port, timeout: Duration(milliseconds: 500));
//       openPorts.add(port);
//       await socket.close();
//     }

//     setState(() {
//       scanning = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Port Scanner'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   targetAddress = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Target IP Address',
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: scanning || targetAddress.isEmpty ? null : scanPorts,
//             child: Text(scanning ? 'Scanning...' : 'Scan Ports'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: openPorts.length,
//               itemBuilder: (context, index) {
//                 final port = openPorts[index];
//                 return ListTile(
//                   title: Text('Port $port'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'dart:io';

class PortScanner extends StatefulWidget {
  const PortScanner({super.key});

  @override
  State<PortScanner> createState() => _PortScannerState();
}

class _PortScannerState extends State<PortScanner> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _startPortController = TextEditingController();
  final TextEditingController _endPortController = TextEditingController();

  List<int> openPorts = [];

  void scanPorts() {
    setState(() {
      openPorts.clear();
    });

    final host = _hostController.text;
    final startPort = int.tryParse(_startPortController.text) ?? 1;
    final endPort = int.tryParse(_endPortController.text) ?? 65535;

    for (var port = startPort; port <= endPort; port++) {
      Socket.connect(host, port, timeout: Duration(milliseconds: 500))
          .then((socket) {
        setState(() {
          openPorts.add(port);
        });
        socket.destroy();
      }).catchError((error) {
        // Port is closed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
        title: Text('TCP Port Scanner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(

          children: [
            TextField(
              controller: _hostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Host'),
            ),
            TextField(
              controller: _startPortController,
              decoration: InputDecoration(labelText: 'Start Port'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _endPortController,
              decoration: InputDecoration(labelText: 'End Port'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff273952)
              ),
              onPressed: scanPorts,
              child: Text('Scan Ports'),
            ),
            SizedBox(height: 16.0),
            Text('Open Ports:'),
            Expanded(
              child: ListView.builder(
                itemCount: openPorts.length,
                itemBuilder: (context, index) {
                  final port = openPorts[index];
                  return ListTile(
                    title: Text('Port $port'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
