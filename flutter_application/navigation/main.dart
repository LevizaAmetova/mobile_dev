import 'package:flutter/material.dart';
import 'package:flutter_app/screen2.dart';

void main() {
  runApp( MyHomePage());
}



class MyHomePage extends StatefulWidget {
  const MyHomePage();


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(home:Scaffold(
        backgroundColor: Colors.yellow,
     
      body: Center(
        child:FloatingActionButton(
        onPressed: () { print("hello");  
        
          Navigator.of(context).push(

            MaterialPageRoute<void>(
      builder: (BuildContext context) => const Screen2(),
    ),
          );
         },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
        
      ),
     ));
  }
}