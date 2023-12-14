import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/Checkout/Add_to_Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

import '../main.dart';

class DescriptionScreen extends StatefulWidget {
  String id;
  String image;
  String name;
  String brand;
  num price;
  String battery;
  String display;
  String memory;
  String processor;
  String storage;
  String operatingSystem;
 String power;


  DescriptionScreen({super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    required this.battery,
    required this.display,
    required this.memory,
    required this.processor,
    required  this.storage,
    required  this.operatingSystem,
    required  this.power});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  Future getUser()async{
    SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
    return userLoginDetails.getString('uEmail');
  }
  String uEmail = '';
  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  int IncDec=1;

  void productInsert()async{

    String descId = const Uuid().v1();

    Map<String, dynamic> productDetail = {
      "Cart-Id": descId,
      "User-Email": uEmail,
      "Quantity":IncDec,
      "Product-Id": widget.id.toString(),
      "Product-Name": widget.name.toString(),
      "Product-Brand": widget.brand.toString(),
      "Product-Image": widget.image.toString(),
      "Product-Price": widget.price.toString(),

    };
    FirebaseFirestore.instance.collection("Add-to-Cart").doc(descId).set(productDetail);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Added to Your Cart"),
        ));
  }

  TextEditingController review = TextEditingController();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                  )
              ),
            ),
            Stack(
                children: [ Container(
                  width: double.infinity,
                  height: 500,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50)),
                      color: Color(0xf0003333)
                  ),
                ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        height: 70,
                        margin: const EdgeInsets.only(left: 30, top: 30),
                        child: Text(widget.name, style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                      ),
                      const SizedBox(width: 120,),

                      CircleAvatar(
                        backgroundColor: const Color(0xf0003333),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite, color: Colors.white, size: 40,),
                            Container(

                              decoration: const BoxDecoration(
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.only(left: 30, top: 80),
                        width: 300,
                        height: 70,

                        child: Text(widget.price.toString(), style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text("Ratings and Reviews"),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [

                                    Container(
                                        margin: const EdgeInsets.only(top: 10,
                                            bottom: 20,
                                            left: 10,
                                            right: 10),
                                        child: TextFormField(
                                            controller: review,
                                            decoration: InputDecoration(
                                              label: const Text("Enter your Review"),
                                              // filled: true,
                                              // fillColor: Color(0xffff6d40),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Color(0xf0003333)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Color(0xf0003333)),
                                              ),
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.0, right: 10),
                                                child: Icon(
                                                  Icons.rate_review_outlined,
                                                  color: Color(0xf0003333),),),
                                              // prefixIcon: Icon(Icons.person,color: Color(0xf001074f),),
                                            )
                                        )
                                    ),

                                    Center(
                                      child: RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        unratedColor: Colors.grey,
                                        itemCount: 5,
                                        itemSize: 30.0,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        updateOnDrag: true,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                        onRatingUpdate: (ratingvalue) {
                                          setState(() {
                                            rating = ratingvalue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        rating = 0;
                                      });
                                      Navigator.of(dialogContext).pop();
                                    }, child: const Text("Not Now")
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      String productId = const Uuid().v1();

                                      Map<String, dynamic> productDetails = {
                                        "Review-Id": productId,
                                        "Product-Name":widget.name.toString(),
                                        "User-Email":uEmail,
                                        "Review-message": review.text.toString(),
                                        "Star-Rating": rating,
                                      };
                                      await FirebaseFirestore.instance
                                          .collection("Product-Reviews").doc(
                                          productId).set(productDetails);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(dialogContext).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xf0003333),
                                    ),
                                    child: const Text("OK")),
                              ],
                            );
                          });
                    },

                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 30,
                          margin: const EdgeInsets.only(top: 200),
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: rating,
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            updateOnDrag: true,
                            itemBuilder: (context, index) =>
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (ratingvalue) {},
                          ),
                        ),

                        const SizedBox(width: 100,),

                        CircleAvatar(
                          backgroundColor: const Color(0xf0003333),
                          child: Row(
                            children: [
                              const Icon(Icons.reviews, color: Colors.white,
                                size: 30,),
                              Container(
                                decoration: const BoxDecoration(
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),


                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 65,right: 10,top: 350),
                        // child: Icon(Icons.star_outline_rounded,color: Color(
                        //     0xf0343434)),
                      ),
                      // SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          if(IncDec>1){
                            setState(() {
                              IncDec=IncDec-1;
                            });
                          }
                        },
                        child:Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.only(left: 4),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("-",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text("$IncDec",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            IncDec=IncDec+1;
                          });
                        },
                        child:Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.only(left: 6),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("+",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),),
                        ),
                      ),
                      const SizedBox(width: 30,),


                    ],),

                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 220, left: 20),
                        child: const Text("Specification: ", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25
                        ),),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 280, left: 20),
                        child: Text(widget.operatingSystem, style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 300, left: 20),
                        child: Text(
                          "02: Memory:${widget.memory}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 320, left: 20),
                        child: Text(
                          "03: Storage:${widget.storage}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 340, left: 20),
                        child: Text("04: processor:${widget.processor}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 360, left: 20),
                        child: Text("05: Display:${widget.display}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 380, left: 20),
                        child: Text(
                          "06: Power:${widget.power}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 400, left: 20),
                        child: Text(
                          "07: battery:${widget.battery}", style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        ),),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          productInsert();

                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 440, left: 70),
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          padding: const EdgeInsets.only(left: 40, top: 8),
                          child: Text("Add To Card", style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(6, 27, 28, 1),
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                      )
                    ],
                  )
                ]
            ),
          ],
        ),

      ),

    );
  }
}