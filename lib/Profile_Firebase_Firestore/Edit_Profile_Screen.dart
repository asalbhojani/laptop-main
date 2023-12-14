import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laptop/Profile_Firebase_Firestore/Profile_Screen.dart';

class EditProfile extends StatefulWidget {
  String uid;
  String u_name;
  String u_lname;
  String u_email;
  String u_pass;
  String u_contact;


  EditProfile(
      {required this.uid,
        required this.u_name,
        required this.u_lname,
        required this.u_email,
        required this.u_pass,
        required this.u_contact});

  @override
  State<EditProfile> createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void createupdateUser()async{
    // try{
    //   await FirebaseAuth.instance.
    //
    // } on FirebaseAuthException catch(ex){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${ex.code.toString()}")));
    // }
  }

  void userupdate() async {
    await FirebaseFirestore.instance.collection("userData").doc(widget.uid).update({
      "User-Id": widget.uid,
      "User-Name": firstname.text.toString(),
      "User-LName": lastname.text.toString(),
      "User-Email": email.text.toString(),
      "User-Contact": contact.text.toString(),
      "User-Password": password.text.toString(),
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => profileScreen(),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState

    firstname.text = widget.u_name;
    lastname.text = widget.u_lname;
    email.text = widget.u_email;
    password.text = widget.u_pass;
    contact.text = widget.u_contact;
    super.initState();
  }
  File? userProfile;

  bool passHide = true;

  var _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    contact.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:IconButton(onPressed: (){Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profileScreen()),
        );},
            icon: const Icon(Icons.arrow_circle_left,color: Colors.black,)),
        title: Center(
          child: Text("Edit Profile",style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
        ),

      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: 600,
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/forgot-password.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xf0003333),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)) ),
                  width: double.infinity,
                  height: 800,
                  child:   Column(
                    children: [

                      GestureDetector(
                        onTap: ()async{
                          XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (selectedImage != null){
                            File convertedImage = File(selectedImage.path);
                            setState(() {
                              userProfile = convertedImage;
                            });
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Not Selected")));
                          }
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          backgroundImage: userProfile!=null?FileImage(userProfile!):null,
                        ),
                      ),

                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          Stack(
                              children:[
                                Container(
                                  width: 300,
                                  height: 480,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),


                                  child: Form(
                                    key: _formkey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color(0xf0003333)))
                                          ),
                                          child: TextFormField(
                                            controller: firstname,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Name is Required";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Name",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.person,color: Color(0xf0003333),),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color(0xf0003333)))
                                          ),
                                          child: TextFormField(
                                            controller: lastname,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Last Name is Required";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Last Name",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.person_2_outlined,color: Color(0xf0003333),),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color(0xf0003333)))
                                          ),
                                          child: TextFormField(
                                            controller: email,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Email is Required";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Email",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.email,color: Color(0xf0003333),),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              border:  Border(bottom: BorderSide(color: Color(0xf0003333)))
                                          ),
                                          child: TextFormField(
                                            controller: contact,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Contact is Required";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Contact Number",
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.contact_page_outlined,color: Color(0xf0003333),),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(

                                            controller: password,
                                            validator: (value){
                                              if(value == null || value.isEmpty || value == " "){
                                                return "Password is required";
                                              }
                                            },
                                            obscureText: passHide==true?true:false,
                                            obscuringCharacter: "*",
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Password",
                                              suffixIcon: IconButton(onPressed: (){
                                                setState(() {
                                                  passHide =! passHide;
                                                });
                                              }, icon: passHide==true? Icon(Icons.remove_red_eye):Icon(Icons.key)),
                                              hintStyle: TextStyle(color: Colors.grey[700]),
                                              prefixIcon: const Icon(Icons.password,color: Color(0xf0003333),),
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
                                          userupdate();
                                          // createUser();
                                          // userInsertwithImage();
                                          if(_formkey.currentState!.validate()){
                                            print(firstname.text.toString());
                                            print(lastname.text.toString());
                                            print(email.text.toString());
                                            print(contact.text.toString());
                                            print(password.text.toString());

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => profileScreen(),));
                                            child: const Text("Login");
                                          }
                                        }, child: Container(
                                      margin: EdgeInsets.only(left: 50 , top: 450),
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Color(0xf0003333),
                                                Colors.black
                                              ]
                                          )
                                      ),
                                      child: const Center(
                                        child: Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20), ),
                                      ),
                                    )
                                    )

                                  ],
                                )
                              ]
                          ),



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
