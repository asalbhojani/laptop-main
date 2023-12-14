import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/Home.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(

                    image: DecorationImage(image: AssetImage("assets/images/orderplaces.jpg"))
                ),
              ),
            ),

            Text("Order Successfully",style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w700,

            ),),
            Text("Placed!",style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),),

            const SizedBox(height: 20,),

            Center(
              child: Text("Your order have been placed successfully.",style: GoogleFonts.poppins(
                  fontSize: 15
              ),),
            ),

            Text("You can now track your order",style: GoogleFonts.poppins(
                fontSize: 15
            ),),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));

              },
              child: Container(

                margin: const EdgeInsets.only( top:50),
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
                  child: Text("Order Again", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20), ),
                ),
              ),
            ),



          ],
        ),
      ),

    );
      }
}
