import 'package:flutter/material.dart';
import 'package:whois/whois.dart';

class WhoIs extends StatefulWidget {
  const WhoIs({Key? key}) : super(key: key);

  @override
  State<WhoIs> createState() => _WhoIsState();
}

class _WhoIsState extends State<WhoIs> {

  List data = [];
  TextEditingController txt = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff273952),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
        title: const Text('WhoIs '),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextField(

                controller: txt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'amazon.com'
                ),
              ),
            ),
            //buildContainer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff273952)
              ),
              child: Text('WhoIs'),
              onPressed: () {
                getWhoIsData();
                setState(() {

                });
              },
            ),
            isLoading == true? CircularProgressIndicator():
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                 return Text(data[index].toString());
              },),
            )

          ],
        ),
      ),
    );
  }

  getWhoIsData() async
  {
    setState(() {
      isLoading = true;
    });
    data = [];
    final whoisResponse = await Whois.lookup(txt.text);
    data.add(whoisResponse);
    print(whoisResponse);
    setState(() {
      isLoading = false;
    });
  }

  // Widget buildContainer()
  // {
  //   return Container(
  //     height: 100,
  //     width: 200,
  //     child: Row(
  //       children: [
  //         TextField(),
  //         ElevatedButton(onPressed: () {
  //
  //         }, child: Text('WhoIs'))
  //       ],
  //     ),
  //   );
  // }
}
