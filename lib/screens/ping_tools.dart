
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PingTools extends StatefulWidget {
  const PingTools({Key? key}) : super(key: key);

  @override
  State<PingTools> createState() => _PingToolsState();
}

class _PingToolsState extends State<PingTools> {

  RxList data = [].obs;
  RxBool isLoading = false.obs;
  TextEditingController pingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
        title: Text('Geo Ping'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pingController,
              decoration: InputDecoration(
              hintText: 'amazon.com'
            ),),
          ),
          SizedBox(height: 20,),

          Center(
            child: Container(
              height: 45,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff273952)
                ),
                child: Text('Ping'),
                onPressed: () {
                  getPing();

                },
              ),
            ),
          ),

          isLoading.value == true ? Obx(() => CircularProgressIndicator(
            color: Colors.blue,
          ))
          :Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.value.length,
              itemBuilder: (context, index) {
              return Text(data.value[index].toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),);
            },),
          )
        ],
      ),
    );
  }

  getPing() async{
    isLoading.value = true;
    data.clear();
    final ping = Ping(pingController.text, count: 3);
    // Begin ping process and listen for output
    ping.stream.listen((event) {
      data.value.add(event);
      print(data.length);
      setState(() {});
    });
    print(data.length);
    print(data.length);
    print(data.toString());
    isLoading.value = false;
  }
}
