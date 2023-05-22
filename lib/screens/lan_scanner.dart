// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:lan_scanner/lan_scanner.dart';
//
//
//
// class LanScannerPage extends StatefulWidget {
//   const LanScannerPage({Key? key}) : super(key: key);
//
//   @override
//   State<LanScannerPage> createState() => _LanScannerPageState();
// }
//
// class _LanScannerPageState extends State<LanScannerPage> {
//   final List<HostModel> _hosts = <HostModel>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('lan_scanner '),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   final scanner = LanScanner();
//                   final stream = scanner.icmpScan(
//                     '192.168.0',
//                     progressCallback: (progress) {
//                       if (kDebugMode) {
//                         print('progress: $progress');
//                       }
//                     },
//                   );
//
//                   stream.listen((HostModel host) {
//                     setState(() {
//                       _hosts.add(host);
//                     });
//                   });
//                 },
//                 child: const Text('Scan'),
//               ),
//               ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   final host = _hosts[index];
//
//                   return Card(
//                     child: ListTile(
//                       title: Text(host.ip),
//                     ),
//                   );
//                 },
//                 itemCount: _hosts.length,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }