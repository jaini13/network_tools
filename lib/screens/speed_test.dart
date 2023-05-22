import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
 

class SpeedTest extends StatefulWidget {
  const SpeedTest({Key? key}) : super(key: key);

  @override
  State<SpeedTest> createState() => _SpeedTestState();
}

class _SpeedTestState extends State<SpeedTest> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  bool _testInProgress = false;
  double _downloadRate = 0;
  double _uploadRate = 0;
  String _downloadProgress = '0';
  String _uploadProgress = '0';
  int _downloadCompletionTime = 0;
  int _uploadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String? _ip;
  String? _asn;
  String? _isp;
  String? newData;

  String _unitText = 'Mbps';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff273952),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
          title: const Text('SpeedTest '),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    const Text(
                      'Download Speed',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Progress: $_downloadProgress%'),
                    Text('Download Rate: $_downloadRate $_unitText'),
                    if (_downloadCompletionTime > 0)
                      Text(
                          'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                  ],
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Upload Speed',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Progress: $_uploadProgress%'),
                    Text('Upload Rate: $_uploadRate $_unitText'),
                    if (_uploadCompletionTime > 0)
                      Text(
                          'Time taken: ${(_uploadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                  ],
                ),

                const SizedBox(
                  height: 32.0,
                ),
                if (!_testInProgress) ...{
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff273952)
                    ),
                    child: const Text('Start Testing'),
                    onPressed: () async {
                      reset();
                      await internetSpeedTest.startTesting(onStarted: () {
                        setState(() => _testInProgress = true);
                      }, onCompleted: (TestResult download, TestResult upload) {
                        if (kDebugMode) {
                          print(
                              'the transfer rate ${download.transferRate}, ${upload.transferRate}');
                        }
                        setState(() {
                          _downloadRate = download.transferRate;
                          _unitText =
                              download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _downloadProgress = '100';
                          _downloadCompletionTime = download.durationInMillis;
                        });
                        setState(() {
                          _uploadRate = upload.transferRate;
                          _unitText =
                              upload.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _uploadProgress = '100';
                          _uploadCompletionTime = upload.durationInMillis;
                          _testInProgress = false;
                        });
                      }, onProgress: (double percent, TestResult data) {
                        if (kDebugMode) {
                          print(
                              'the transfer rate $data.transferRate, the percent $percent');
                        }
                        setState(() {
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          if (data.type == TestType.download) {
                            _downloadRate = data.transferRate;
                            _downloadProgress = percent.toStringAsFixed(2);
                          } else {
                            _uploadRate = data.transferRate;
                            _uploadProgress = percent.toStringAsFixed(2);
                          }
                        });
                      }, onError: (String errorMessage, String speedTestError) {
                        if (kDebugMode) {
                          print(
                              'the errorMessage $errorMessage, the speedTestError $speedTestError');
                        }
                        reset();
                      }, onDefaultServerSelectionInProgress: () {
                        setState(() {
                          _isServerSelectionInProgress = true;
                        });
                      }, onDefaultServerSelectionDone: (Client? client) {
                        setState(() {
                          _isServerSelectionInProgress = false;
                          _ip = client?.ip;
                          _asn = client?.asn;
                          _isp = client?.isp;
                           newData = client?.location!.city;

                        });
                      }, onDownloadComplete: (TestResult data) {
                        setState(() {
                          _downloadRate = data.transferRate;
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _downloadCompletionTime = data.durationInMillis;
                        });
                      }, onUploadComplete: (TestResult data) {
                        setState(() {
                          _uploadRate = data.transferRate;
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _uploadCompletionTime = data.durationInMillis;
                        });
                      }, onCancel: () {
                        reset();
                      });
                    },
                  )
                } else ...{
                  const CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () => internetSpeedTest.cancelTest(),
                      icon: const Icon(Icons.cancel_rounded),
                      label: const Text('Cancel'),
                    ),
                  ),

                  SfRadialGauge(
                      enableLoadingAnimation: true,
                      animationDuration: 4500,
                      title: GaugeTitle(
                          text: ' ',
                          textStyle: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 10,
                          pointers:<GaugePointer> [
                            NeedlePointer(
                              // onValueChanged: (value) {
                              //
                              //   setState(() {
                              //     RangePointer(value: _downloadRate, width: 30, enableAnimation: true, color: Colors.red);
                              //
                              //   });
                              // },
                              knobStyle: KnobStyle(
                                  color: Colors.red
                              ),
                              value: _downloadRate,
                              needleColor: Colors.black,
                              enableAnimation: true,)
                          ],
                          axisLabelStyle: GaugeTextStyle(
                            color: Colors.grey,
                          ),

                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 3,
                                color:  Colors.green,
                                startWidth: 10,
                                endWidth: 10),
                            GaugeRange(
                                startValue: 3,
                                endValue: 6,
                                color:  Colors.orange,
                                startWidth: 10,
                                endWidth: 10),
                            GaugeRange(
                                startValue: 6,
                                endValue: 10,
                                color:  Colors.red,
                                startWidth: 10,
                                endWidth: 10)
                          ],
                          annotations: <GaugeAnnotation>
                          [
                            GaugeAnnotation(widget: Text(
                              _downloadRate.toString()+'Mbps',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                              positionFactor: 0.5,
                              angle: 90,)

                          ],
                        )
                      ]),


                },
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;
        _uploadRate = 0;
        _downloadProgress = '0';
        _uploadProgress = '0';
        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
        _uploadCompletionTime = 0;

        _ip = null;
        _asn = null;
        _isp = null;
      }
    });
  }
}