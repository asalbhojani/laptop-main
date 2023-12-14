import 'package:flutter/material.dart';
import 'package:laptop/home/Insert.dart';


class Inserted extends StatefulWidget {
  const Inserted({super.key});

  @override
  State<Inserted> createState() => _InsertedState();
}

class _InsertedState extends State<Inserted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Center(
                child: Text("Data Inserted Screen"),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Insert(),));
                },
                child: Container(
                  width: 100,
                    height: 50,
                    color: Colors.orange,
                    child: Text("Insert Product")
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
