 import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_traceroute/flutter_traceroute.dart';
import 'package:flutter_traceroute/flutter_traceroute_platform_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_network_connection/flutter_network_connection.dart';
import 'package:path_provider/path_provider.dart';

class TraceScreen extends StatefulWidget {
  static const defaultDNS = '8.8.8.8';

  const TraceScreen({super.key});

  @override
  State<TraceScreen> createState() => _TraceScreenState();
}

class _TraceScreenState extends State<TraceScreen> {
  List<TracerouteStep> traceResults = [];

  late final FlutterTraceroute traceroute;
  late final TextEditingController hostController;
  late final TextEditingController ttlController;

  @override
  void initState() {
    super.initState();

    traceroute = FlutterTraceroute();
    hostController = TextEditingController()..text = TraceScreen.defaultDNS;
    ttlController = TextEditingController();
  }

  void onTrace() {
    setState(() {
      traceResults = <TracerouteStep>[];
    });

    final host = hostController.text;
    final ttl = int.tryParse(ttlController.text) ?? TracerouteArgs.ttlDefault;

    final args = TracerouteArgs(host: host, ttl: ttl);

    traceroute.trace(args).listen((event) {
      setState(() {
        traceResults = List<TracerouteStep>.from(traceResults)..add(event);
      });
    });
  }

  void onStop() {
    traceroute.stopTrace();

    setState(() {
      traceResults = <TracerouteStep>[];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
          title: const Text('Traceroute')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Input IP address'),
            const SizedBox(height: 16),
            TextField(
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:  Color(0xff273952)
                  )
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                      color: Color(0xff273952))
                ),
                hintText: 'IP address',
                labelText: 'IP',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff273952)
                )
              ),
              controller: hostController,
            ),
            if (Platform.isIOS) const SizedBox(height: 16),
            if (Platform.isIOS)
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Time to live - iOS Only',
                  labelText: 'TTL - iOS Only',
                ),
                keyboardType: TextInputType.number,
                controller: ttlController,
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: onTrace,
                  child: const Text('Trace',style: TextStyle(
                    color: Color(0xff273952)
                  ),),
                ),
                OutlinedButton(
                  onPressed: onStop,
                  child: const Text('Stop',style: TextStyle(
                    color: Color(0xff273952))),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final result in traceResults)
                  Text(
                    result.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: result is TracerouteStepFinished ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


 
//
// class TrceRouteChina extends StatefulWidget {
//   @override
//   _TrceRouteChinaState createState() => _TrceRouteChinaState();
// }
//
// class _TrceRouteChinaState extends State<TrceRouteChina> {
//   // 测速点
//   final _url = 'http://google.com';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 MaterialButton(
//                   onPressed: () async {
//                     Directory tempDir = await getTemporaryDirectory();
//                     String tempPath = tempDir.path;
//                     Dio().download(_url, tempPath);
//                     await FlutterNetworkConnection.startSampling();
//                     final result = await FlutterNetworkConnection.getCurrentBandwidthQuality();
//                     print('当前网络质量：' + result);
//                   },
//                   child: Text('获取当前网络质量'),
//                 ),
//                 MaterialButton(
//                   onPressed: () async {
//                     final result = await FlutterNetworkConnection.getDownloadKBitsPerSecond();
//                     print(result);
//                   },
//                   child: Text('bits'),
//                 ),
//                 TextButton(onPressed: ()async{
//                 final result= await FlutterNetworkConnection.instance.startWithType('http://google.com',type: "Ping",sourceData: (value) {
//                   print('tress ${value}');
//                 },);
//
//                   // print('tress $result');
//
//                 }, child: Text('Connect'))
//               ],
//             ),
//           )),
//     );
//   }
// }