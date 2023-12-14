
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/Checkout/checkout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

  Future getUser()async{
    SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
    return userLoginDetails.getString('uEmail');
  }
  static String uEmail = '';
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

  String id="";
  String name="";




  @override
  Widget build(BuildContext context) {
    return  Scaffold(


        body:SingleChildScrollView(

          child: Column(
            children: [

              Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 170,
                      color: const Color(0xf0003333),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            padding: const EdgeInsets.all(7.0),
                            margin: const EdgeInsets.only(left: 30,top: 40),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavigation()));
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_rounded, // Arrow icon
                                size: 18, // Icon size
                                color: Colors.white, // Icon color (match the container background)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 175,right: 5,),
                            child: Text("Cart",style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:const Color(0xffffffff),
                            ),),
                          ),
                          Container(
                            width: 100,
                            height: 5,
                            padding: const EdgeInsets.all(7.0),
                            margin: const EdgeInsets.only(left: 150,top: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(40)
                            ),
                          ),

                        ],),
                    ),


                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 120,bottom: 20),
                      decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [



                          StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("Add-to-Cart").where('User-Email',isEqualTo: uEmail).snapshots(),
                              builder: (BuildContext context, snapshot) {

                                if(snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  var dataLength = snapshot.data!.docs.length;
                                  return dataLength==0?const Text("Nothing to Show"):
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: GridView.count(
                                      crossAxisCount: 1,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 300/150,
                                      children: List.generate(dataLength, (index) {
                                        String id = snapshot.data!.docs[index]['Cart-Id'];
                                        String name = snapshot.data!.docs[index]['Product-Name'];
                                        String brand = snapshot.data!.docs[index]['Product-Brand'];
                                        String img = snapshot.data!.docs[index]['Product-Image'];
                                        String price = snapshot.data!.docs[index]['Product-Price'];


                                        id=id;
                                        name=name;
                                        return  Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:[
                                              Container(
                                                // margin: EdgeInsets.only(right: 10),
                                                width: 320,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: const Color(0xffffffff),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color(0xf39a9a9a),
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 1),
                                                      )
                                                    ]
                                                ),
                                                child: Stack(
                                                  children: <Widget>[

                                                    Container(
                                                      width: 160,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft:Radius.circular(15) ),
                                                        color: Theme.of(context).primaryColor,
                                                        image: DecorationImage(
                                                            colorFilter: ColorFilter.mode(const Color(0xf44d4d4d).withOpacity(0.2), BlendMode.darken),
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(img)
                                                        ),
                                                      ),
                                                    ),

                                                    Container(
                                                        width: 35,
                                                        height: 30,
                                                        margin: const EdgeInsets.only(left: 280,right: 10,top: 5),
                                                        padding:const EdgeInsets.only(top:3),
                                                        decoration: const BoxDecoration(

                                                            shape: BoxShape.circle,
                                                            color: Color(0xffffffff),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(0xf39a9a9a),
                                                                spreadRadius: 3,
                                                                blurRadius: 8,
                                                                offset: Offset(1, 0),
                                                              )
                                                            ]
                                                          // border: Border.all(color: Color(0xffa19e9e))
                                                        ),
                                                        child: const Icon(CupertinoIcons.heart,color: Color(0xf0003333))

                                                    ),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:[
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 175,right: 5,top: 15),
                                                            child: Text(name,style: GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color:Theme.of(context).iconTheme.color,
                                                            ),),
                                                          ),

                                                          Container(
                                                            margin: const EdgeInsets.only(left: 90,right: 10,),
                                                            child: Text('\$$price',style: GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: const Color(0xf0003333),
                                                            ),),
                                                          ),

                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets.only(left: 165,right: 10,),
                                                                // child: Icon(Icons.star_outline_rounded,color: Color(
                                                                //     0xf0343434)),
                                                              ),
                                                              // SizedBox(width: 5,),

                                                              const SizedBox(width: 30,),

                                                              GestureDetector(
                                                                  onTap:(){
                                                                    FirebaseFirestore.instance.collection("Add-to-Cart").doc(id).delete();
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text("Item Deleted From Your Cart"),
                                                                        ));
                                                                    setState(() {

                                                                    });
                                                                       },
                                                                  child: const Icon(Icons.delete)),

                                                            ],),

                                                        ]),
                                                  ],),
                                              ),
                                            ]);
                                      }

                                      ),

                                    ),
                                  );
                                }if (snapshot.hasError) {
                                  return const Icon(Icons.error_outline);
                                }
                                return Container();
                              }),


                          Container(
                            margin: const EdgeInsets.only(bottom: 30,left: 120),
                            width: 150,
                            height: 50,
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOutScreen(productId: id, productName: name, ),));
                                // updateData("Luxury Table", 48,"assets/img/table.png");
                              });
                            },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xf0003333)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(11),
                                          side: const BorderSide(color: Color(0xf0003333))
                                      ))
                              ),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4,vertical:11 ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.shopping_cart_checkout_sharp, color:  Color(0xffffffff)),
                                    const SizedBox(width: 5,),
                                    Text("Checkout", style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color:  const Color(0xffffffff),
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),

                  ]),

            ],
          ),

        ));
  }
}
