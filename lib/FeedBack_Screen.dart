import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import 'Profile_Firebase_Firestore/Profile_Screen.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController feedback = TextEditingController();


  void feedbackinsert() async{
    String userID = const Uuid().v1();
    Map<String, dynamic>  userFeedback ={

      "User-ID":userID,
      "User-Name": name.text.toString(),
      "User-Email": email.text.toString(),
      "User-Feedback": feedback.text.toString(),


    };
    await FirebaseFirestore.instance.collection("userFeedback").doc(userID).set(userFeedback);
  }

  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    feedback.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 600,
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/feedback.jpeg'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(6, 27, 28,1),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)) ),
                  width: double.infinity,
                  height: 800,
                  child:   Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30 , top: 20),
                        width: double.infinity,
                        child: Text("Feedback" , style: GoogleFonts.abyssinicaSil(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),),
                      ),
                      const SizedBox(height: 5,),

                      Container(
                        margin: const EdgeInsets.only(left: 30 ),
                        width: double.infinity,
                        child: Text("Welcome back, Please share your valuable feedback with us" , style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),),
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          Stack(
                              children:[
                                Container(
                                  width: 300,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),


                                  child: Form(
                                    key: formKey,

                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color.fromRGBO(6, 27, 28,1)))
                                          ),
                                          child: TextFormField(
                                            controller: name,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Name is Required";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Name",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.person,color: Color.fromRGBO(6, 27, 28,1),),
                                            ),
                                          ),
                                        ),



                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color.fromRGBO(6, 27, 28,1)))
                                          ),
                                          child: TextFormField(
                                            controller: email,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Email is Required";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Email",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.email,color: Color.fromRGBO(6, 27, 28,1),),
                                            ),
                                          ),
                                        ),



                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color.fromRGBO(6, 27, 28,1)))
                                          ),
                                          child: TextFormField(
                                            controller: feedback,

                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Feedback is required";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Feedback",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.feedback,color: Color.fromRGBO(6, 27, 28,1),),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ),

                                Column(
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        feedbackinsert();
                                        if(formKey.currentState!.validate()){

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const profileScreen(),));
                                          const Text("Feedback");
                                        }
                                      },

                                      child: Container(

                                        margin: const EdgeInsets.only(left: 50 , top: 225),
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Color.fromRGBO(6, 27, 28,1),
                                                  Colors.black
                                                ]
                                            )
                                        ),
                                        child: const Center(
                                          child: Text("FeedBack", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20), ),
                                        ),

                                      ),
                                    )


                                  ],
                                )
                              ]
                          ),
                          const SizedBox(height: 30,),

                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
