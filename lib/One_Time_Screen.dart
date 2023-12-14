import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/Firebase_Auth/Login_Screen.dart';
import 'package:laptop/Firebase_Auth/Register_Screen.dart';

class OneTime extends StatefulWidget {
  const OneTime({super.key});

  @override
  State<OneTime> createState() => _OneTimeState();
}

class _OneTimeState extends State<OneTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only( left: 20),
              width: 600,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/one_time.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
            const SizedBox(height: 20,),

            Column(
              children: [
                 Text("Discover Your " , style: GoogleFonts.pacifico(
                   fontSize: 50,
                   color: const Color.fromRGBO(6, 27, 28,1)
                 ),)
              ],
            ),
            Column(
              children: [
                Text("Dream Laptop Here " , style: GoogleFonts.aleo(
                    fontSize: 30,
                    color: const Color.fromRGBO(6, 27, 28,5)
                ),)
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text("Explore all laptop here based on your personal specification" , style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(6, 27, 28,1)
                  ),),
                )
              ],
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(6, 27, 28,1),
                    ),
                    width: 100,
                    height: 50,

                    child: Padding(
                      padding: const EdgeInsets.only(left: 25 , top: 10),
                      child: Text("Login" , style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20
                      ),),
                    ),
                  ),
                ),
                const SizedBox(width: 30,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                      },
                      child: SizedBox(
                        width: 130,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20 , top: 10),
                          child: Text("Register" , style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(6, 27, 28,1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),),
                        ),


                      ),
                    ),
                  ],
                )
              ],
            ),


          ],
        ),


      ),

    );
  }
}
