import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[300],
    accentColor: Colors.greenAccent,

    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 40.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
    ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var inp = '0';
  var from = "INR";
  var to = "USD";
  var result = "0";
  void convert() {
    // MAKE a api call to the KUTT IT lib and get the short url
    if(inp==""){
      setState(() {
        result = '0';
      });
      return;
    }
    var url = "https://api.exchangeratesapi.io/latest?base=$from&symbols=&to";
    // Future<T> - future - I will compute this, but i dont know
    // how long this is going to take,
    // in the FUTURE

    // Future<Response>
    //once it returns then, we take resp and then do
    // whatever we want to do with it.
    // Lambda functions
    http.get(
      Uri.encodeFull(url), headers: {"Accept": "application/json"}
    ).then((r) {
      Map body = json.decode(r.body);
      var res = body["rates"][to];
      var i = double.parse(inp);
      i=i*res;
      setState(() {
        result = i.toString();
      });
    });
  }
  
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
          child:  Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          ListTile(
            title:   
            
                TextFormField(
                controller: _controller,
    
                keyboardType: TextInputType.numberWithOptions(decimal: true),
    
                cursorColor: Theme.of(context).accentColor,
        
                decoration: InputDecoration(
    
                  labelText: 'Enter amount',
    
                  labelStyle: Theme.of(context).textTheme.bodyText2,
    
                  enabledBorder: UnderlineInputBorder(
    
                    borderSide: BorderSide(color: Theme.of(context).accentColor),
    
                  ),
    
                ),
    
                onChanged: (String newValue) {
    
                  setState(() {
    
                    inp = newValue;
    
                  });
    
                  convert();
    
                },
    
              ),
    
              trailing: DropdownButton<String>(
    
                value: from,
    
                icon: Icon(Icons.arrow_downward),
    
                iconSize: 24,
    
                elevation: 16,
    
                style: TextStyle(
    
                  color:  Colors.white
                ),
    
                underline: Container(
    
                  height: 2,
    
                  color: Theme.of(context).accentColor,
    
                ),
    
                onChanged: (String newValue) {
    
                  setState(() {
    
                    from = newValue;
    
                  });
    
                  convert();
    
                },
    
                items: <String>["CAD","HKD","ISK","PHP","DKK","HUF","CZK","AUD","RON","SEK","IDR","INR","BRL","RUB","HRK","JPY","THB","CHF","SGD","PLN","BGN","TRY","CNY","NOK","NZD","ZAR","USD","MXN","ILS","GBP","KRW","MYR","EUR"]
    
                  .map<DropdownMenuItem<String>>((String value) {
    
                    return DropdownMenuItem<String>(
    
                      value: value,
    
                      child: Text(value),
    
                    );
    
                  })
    
                  .toList(),
    
              )),
    
              
              FloatingActionButton(
    
                onPressed: (){
                  var temp =inp;
                  var remp =from;
                  setState(() {
                     _controller.text  = result;
                    inp=result;
                    result=temp;
                    from=to;
                    to=remp;
                  });
                  },
    
    
                child: Icon(IconData(0xe8d5, fontFamily: 'MaterialIcons')),
                backgroundColor: Theme.of(context).primaryColor,
    
              ),
              ListTile(
    
              title: Text(result, style:( Theme.of(context).textTheme.bodyText2 )),
    
              trailing: DropdownButton<String>(
    
                value: to,
    
                icon: Icon(Icons.arrow_downward),
    
                iconSize: 24,
    
                elevation: 16,
    
                style: TextStyle(
    
                  color: Colors.white
    
                ),
    
                underline: Container(
    
                  height: 2,
    
                  color: Theme.of(context).accentColor,
    
                ),
    
                onChanged: (String newValue) {
    
                  setState(() {
    
                    to = newValue;
    
                  });
    
                  convert();
    
    
    
                },
    
                items: <String>["CAD","HKD","ISK","PHP","DKK","HUF","CZK","AUD","RON","SEK","IDR","INR","BRL","RUB","HRK","JPY","THB","CHF","SGD","PLN","BGN","TRY","CNY","NOK","NZD","ZAR","USD","MXN","ILS","GBP","KRW","MYR","EUR"]
    
                  .map<DropdownMenuItem<String>>((String value) {
    
                    return DropdownMenuItem<String>(
    
                      value: value,
    
                      child: Text(value),
    
                    );
    
                  })
    
                  .toList(),
    
              ),
              ),
               
    
              ],
  
        ),
      ),
         )) // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
