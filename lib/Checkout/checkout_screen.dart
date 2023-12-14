import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'Order_place_screen.dart';

class CheckOutScreen extends StatefulWidget {
  String productId;
  String productName;
  CheckOutScreen({required this.productId,required this.productName});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}
class _CheckOutScreenState extends State<CheckOutScreen> {

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
        print(uEmail);
      });
    });
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  double total =0;
  var tax ;
  var shipping ;
  var grandTotal;



  void checkOut() async{
    String userID = const Uuid().v1();
    Map<String, dynamic>  checkout ={
      "User-ID":userID,
      "Product-ID":widget.productId.toString(),
      "Product-ID":widget.productName.toString(),
      "User-name": name.text.toString(),
      "User-email": email.text.toString(),
      "User-address": address.text.toString(),
      "Total-amount":grandTotal,
    };
    await FirebaseFirestore.instance.collection("Check-Out").doc(userID).set(checkout);
    FirebaseFirestore.instance.collection("Add-to-Cart").where("User-Email",isEqualTo:uEmail).get().then((querySnapshot) => querySnapshot.docs.forEach((doc) => doc.reference.delete()));
    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPlacedScreen(), ));

  }
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    address.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: const Color(0xf0003333),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)
                      ),

                      child: const IconButton(
                          icon: Icon(Icons.arrow_back,color: Colors.white,size: 35.0),onPressed: null),
                    ),

                    const SizedBox(width: 110,),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child:Text("MY CART",style:
                          GoogleFonts.abyssinicaSil(
                              color: Colors.white,
                              fontSize: 30,
                              backgroundColor: const Color(0xf0003333),
                              fontWeight: FontWeight.w600
                          ),),
                        )
                      ],
                    ),


                  ],
                ),


              ],
            ),


            const SizedBox(height: 10,),

           Column(
             children: [
               Stack(
                 children: [
                   Container(
                     margin: const EdgeInsets.only(left: 30, right: 10),
                     width:350,
                     height:500,
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black45),
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,

                       boxShadow: const [
                         BoxShadow(
                           color: Color(0xf0003333),
                           blurRadius: 4,
                           offset: Offset(4, 8), // Shadow position
                         ),
                       ],
                     ),
                   ),
                   Column(
                     children: [
                       Container(
                         margin: const EdgeInsets.only(left: 130, top: 10,),
                         child: Text("ORDER ITEM(s)",style: GoogleFonts.poppins(
                           fontSize: 25,
                           fontWeight: FontWeight.w700,
                         ),),
                       )
                     ],
                   ),


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
                             margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                             child: GridView.count(
                               crossAxisCount: 1,
                               physics: const ScrollPhysics(),
                               scrollDirection: Axis.vertical,
                               shrinkWrap: true,
                               mainAxisSpacing: 20,
                               crossAxisSpacing: 20,
                               childAspectRatio: 400/150,
                               children: List.generate(dataLength, (index) {

                                 String name = snapshot.data!.docs[index]['Product-Name'];
                                 String brand = snapshot.data!.docs[index]['Product-Brand'];
                                 String img = snapshot.data!.docs[index]['Product-Image'];
                                 String price = snapshot.data!.docs[index]['Product-Price'];


                                 // var convert = num.tryParse(price)?.toDouble();
                                 // var total = price+price;
                                 double calculateTotal(List<dynamic> prices) {
                                   double total = 0.0;
                                   for (var price in prices) {
                                     total += double.parse(price['Product-Price'].toString());
                                   }

                                   return total;
                                 }
                                 List<dynamic> prices = snapshot.data!.docs;
                                   double totalPrice = calculateTotal(prices);

                                     total = totalPrice;
                                     tax = totalPrice*0.18;
                                     shipping = 30;
                                     grandTotal = total+tax+shipping;




                                 return   GestureDetector(

                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.only(left: 35,top: 10),
                                         width: 90,
                                         height: 90,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(50),
                                             color: Colors.purple,
                                             image: DecorationImage(
                                                 fit: BoxFit.cover,
                                                 image: NetworkImage(img))
                                         ),
                                       ),
                                       const SizedBox(width: 10,),

                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             margin: const EdgeInsets.only(left: 35,top: 30),
                                             width: 80,
                                             height: 50,
                                             child: Text("\$$price ",style: GoogleFonts.poppins(
                                               fontSize: 15,
                                               fontWeight: FontWeight.bold,
                                               color: const Color(0xf0003333),
                                             ),),
                                           )


                                         ],
                                       ),
                                     ],
                                   ),
                                 );
                               }

                               ),

                             ),
                           );
                         }if (snapshot.hasError) {
                           return const Icon(Icons.error_outline);
                         }
                         return Container();
                       }),



                   const SizedBox(height: 10,),

                 ],
               ),
             ],
           ),
            const SizedBox(height: 30,),

            Container(
              width: double.infinity,
              color: Colors.lightBlue,
              height: 10,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    total;
                    tax;
                  });
                },
              ),
            ),

            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 10),
                  width:350,
                  height: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,

                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xf0003333),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],

                  ),

                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 110, top: 10),
                      child: Text("PAYMENT DETAIL",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),),
                    )
                  ],
                ),
                const SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40,top: 70),
                      width: 100,
                      height: 110,
                      child: Text("Total",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xf0003333),

                      ),),
                    ),
                    const SizedBox(width: 30,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40,top: 70),
                          width: 150,
                          height: 110,
                          child: Text("\$$total",style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xf0003333),

                          ),),
                        ),


                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40,top: 130),
                      width: 100,
                      height: 110,
                      child: Text("Taxes",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xf0003333),

                      ),),
                    ),
                    const SizedBox(width: 30,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40,top: 130),
                          width: 150,
                          height: 110,
                          child: Text("\$$tax",style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xf0003333),

                          ),),
                        ),


                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40,top: 190),
                      width: 120,
                      height: 110,
                      child: Text("Shipping",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xf0003333),

                      ),),
                    ),
                    const SizedBox(width: 30,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40,top: 190),
                          width: 100,
                          height: 110,
                          child: Text("\$$shipping",style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xf0003333),
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40,top: 250),
                      width: 100,
                      height: 110,
                      child: Text("Grand Total",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xf0003333),

                      ),),
                    ),
                    const SizedBox(width: 30,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40,top: 250),
                          width: 150,
                          height: 110,
                          child: Text("\$$grandTotal",style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xf0003333),

                          ),),
                        ),


                      ],
                    ),
                  ],
                ),


              ],
            ),


            const SizedBox(height: 30,),

            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 10),
                  width:350,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,

                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xf0003333),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],

                  ),


                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 80, top: 10),
                      child: Text("CUSTOMER DETAIL",style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),),
                    )
                  ],
                ),
                const SizedBox(height: 10,),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, ),
                      child: Form(
                        key: formKey,

                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only( left: 50) ,
                              margin: const EdgeInsets.only(top: 30),
                              width: 350,
                              decoration: const BoxDecoration(
                                  border:  Border(bottom: BorderSide(color: Color(0xf0003333), width: 10))
                              ),
                              child: TextFormField(
                                controller: name,
                                validator: (value){
                                  if(value == null || value.isEmpty || value == " "){
                                    return "name is Required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter name",
                                  hintStyle: TextStyle(color: Colors.grey[700]),

                                  prefixIcon: const Icon(Icons.person,color: Color(0xf0003333),),
                                ),
                              ),
                            ),



                            Container(
                              padding: const EdgeInsets.only( left: 50) ,
                              margin: const EdgeInsets.only(top: 30),
                              width: 350,
                              decoration: const BoxDecoration(
                                  border:  Border(bottom: BorderSide(color: Color(0xf0003333), width: 10))
                              ),

                              child: TextFormField(
                                controller: email,
                                validator: (value){
                                  if(value == null || value.isEmpty || value == " "){
                                    return "email is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "email",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  prefixIcon: const Icon(Icons.email,color: Color(0xf0003333),),
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only( left: 50) ,
                              margin: const EdgeInsets.only(top: 30),
                              width: 350,
                              decoration: const BoxDecoration(
                                  border:  Border(bottom: BorderSide(color: Color(0xf0003333), width: 10))
                              ),
                              child: TextFormField(
                                controller: address,

                                validator: (value){
                                  if(value == null || value.isEmpty || value == " "){
                                    return "address is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "address",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  prefixIcon: const Icon(Icons.location_on,color: Color(0xf0003333),),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20,),


                            const Row(
                              children: [
                                // GestureDetector(
                                //   onTap: (){
                                //     // checkoutdatainsert();
                                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderplacedScreen(),));
                                //
                                //   },
                                //   child: Container(
                                //
                                //     margin: EdgeInsets.only(left: 100 , top:0),
                                //     width: 200,
                                //     height: 50,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(30),
                                //         gradient: const LinearGradient(
                                //             colors: [
                                //               Colors.black,
                                //               Color.fromRGBO(6, 27, 28,1),
                                //               Colors.black
                                //             ]
                                //         )
                                //     ),
                                //     child: const Center(
                                //       child: Text("Proceed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20), ),
                                //     ),
                                //   ),
                                // ),



                              ],
                            ),
                            const SizedBox(height: 30,),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    checkOut();

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 120 , top: 10),
                                    width: double.infinity,
                                    height: 70,
                                    color:const Color(0xf0003333),
                                    child: Text("Place Order" , style: GoogleFonts.alumniSans(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),),
                                  ),
                                )
                              ],
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                ),




                  ],
                )








              ],
            ),





      )
        );


  }
}
