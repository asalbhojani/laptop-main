
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/Firebase_Auth/Register_Screen.dart';
import 'package:laptop/Firebase_Auth/update_pass.dart';
import 'package:laptop/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigation(),));
      SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
      userLoginDetails.setBool("userLoggedIn", true);
      userLoginDetails.setString('uEmail', email.text.toString());
      SharedPreferences userEmail = await SharedPreferences.getInstance();
      userEmail.setString("User-Email", email.text.toString());
    } on FirebaseAuthException catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }
  bool passHide = true;

  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    email.dispose();
    password.dispose();

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
                      image: AssetImage('assets/images/login.png'),
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
                  height: 600,
                  child:   Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30 , top: 20),
                        width: double.infinity,
                          child: Text("Login" , style: GoogleFonts.abyssinicaSil(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          ),),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 30 ),
                        width: double.infinity,
                        child: Text("Welcome back, Please Login To Your Account" , style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
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
                              height: 200,
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
                                            border:  Border(bottom: BorderSide(color: Color(0xf0003333)))
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
                                            prefixIcon: const Icon(Icons.email,color: Color(0xf0003333)),
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
                                            return null;
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
                                            }, icon: passHide==true? const Icon(Icons.remove_red_eye):const Icon(Icons.key)),
                                            hintStyle: TextStyle(color: Colors.grey[700]),
                                            prefixIcon: const Icon(Icons.password,color: Color(0xf0003333),),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdatePassword()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 150),
                                          width: 300,
                                          height: 50,
                                          child: Text("Forgot Password" , style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500
                                          ),),

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


                                        if(formKey.currentState!.validate()){

                                          showDialog(context: context, builder: (context){
                                            return AlertDialog(
                                              title: const Text("User Login"),
                                              content: const Text("Login Succeful"),
                                              actions: [
                                                ElevatedButton(onPressed: (){
                                                  userLogin();

                                                }, child: const Text("Login")),
                                                OutlinedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: const Text("Cancel"))
                                              ],
                                            );
                                          });
                                        }
                                      }, child: Container(
                                    margin: const EdgeInsets.only(left: 50 , top: 170),
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
                                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 30), ),
                                    ),
                                  )
                                  )

                                ],
                              )
    ]
                          ),
                          const SizedBox(height: 30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text("Don't Have an Account ? ",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white ,fontWeight: FontWeight.w300),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen(),));
                                },
                                child:Text("SignUp",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),),
                              ),
                            ],
                          )



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
