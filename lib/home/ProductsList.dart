import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptop/home/Description_Screen.dart';
import 'package:laptop/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class ProductsList extends StatefulWidget {


  String brandName;
  ProductsList({super.key, required this.brandName});
  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  bool isProductInWishlist = false;
  var searchName = "";

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
                            width: 100,
                            height: 5,
                            padding: const EdgeInsets.all(7.0),
                            margin: const EdgeInsets.only(left: 150,top: 35),
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



                          // SizedBox(height: 20,),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20,left: 75,right: 20),
                                width: 105,
                                height: 50,
                                child: ElevatedButton(onPressed: (){
                                  setState(() {

                                  });
                                },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xffffffff)),
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
                                        Text("Filter", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color:  const Color(0xf0000000),
                                        ),),
                                        const SizedBox(width: 5,),
                                        const Icon(Icons.expand_more, color:  Color(0xf0000000)),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                width: 100,
                                height: 50,
                                child: ElevatedButton(onPressed: (){
                                  setState(() {

                                  });
                                },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xffffffff)),
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

                                        Text("Sort", style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:  const Color(0xf0000000),
                                        ),),
                                        const SizedBox(width: 5,),
                                        const Icon(Icons.expand_more, color:  Color(0xf0000000)),

                                      ],
                                    ),
                                  ),
                                ),
                              ),


                            ],),




                          StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("Product-Data").where('Product-Brand',isEqualTo: widget.brandName)
                                  .snapshots(),
                              builder: (BuildContext context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  var dataLength = snapshot.data!.docs.length;
                                  return dataLength==0?const Text("Nothing to Show"):
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 280/470,
                                      children: List.generate(dataLength, (index) {
                                        String id = snapshot.data!.docs[index]['Product-Id'];
                                        String name = snapshot.data!.docs[index]['Product-Name'];
                                        String brand = snapshot.data!.docs[index]['Product-Brand'];
                                        String img = snapshot.data!.docs[index]['Product-Image'];
                                        num price = snapshot.data!.docs[index]['Product-Price'];
                                        String battery = snapshot.data!.docs[index]['Product-Battery'];
                                        String display = snapshot.data!.docs[index]['Product-Display'];
                                        String memory = snapshot.data!.docs[index]['Product-Memory'];
                                        String processor = snapshot.data!.docs[index]['Product-Processor'];
                                        String storage = snapshot.data!.docs[index]['Product-Storage'];
                                        String os = snapshot.data!.docs[index]['Product-operatingSystem'];
                                        String power = snapshot.data!.docs[index]['Product-powerSupply'];
                                        return  Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                    DescriptionScreen(
                                                      id: id,
                                                      image: img,
                                                      price: price,
                                                      name: name,
                                                      brand: brand,
                                                      battery: battery ,
                                                      display: display,
                                                      memory: memory,
                                                      processor: processor,
                                                      storage: storage,
                                                      operatingSystem: os,
                                                      power: power,),));
                                              },
                                              child: Container(
                                                width: 350,
                                                height: 300,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: const Color(0xffffffff),

                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color(
                                                            0xf4a1a1a1),
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        offset: Offset(1, 1),
                                                      )
                                                    ]
                                                ),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Stack(
                                                        children: <Widget>[

                                                          Container(
                                                            width: 200,
                                                            height: 170,
                                                            margin: const EdgeInsets.only(top: 20),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: const Color(0xffffffff),
                                                              image: DecorationImage(
                                                                  colorFilter: ColorFilter.mode(const Color(
                                                                      0xffffffff).withOpacity(0.2), BlendMode.darken),
                                                                  fit: BoxFit.cover,
                                                                  image: NetworkImage(img)),

                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){

                                                              setState(() {
                                                                isProductInWishlist = !isProductInWishlist;
                                                              });
                                                              String prodId = const Uuid().v1();
                                                              if (isProductInWishlist) {

                                                                Map<String, dynamic> productDetail = {
                                                                  "FavProd-Id": prodId,
                                                                  "User-Email":uEmail,
                                                                  "ProductList-Id": id.toString(),
                                                                  "FavProd-Name": name.toString(),
                                                                  "FavProd-Brand": brand.toString(),
                                                                  "FavProd-Image": img.toString(),
                                                                  "FavProd-Price": price.toString(),
                                                                  "FavProd-Battery": battery.toString(),
                                                                  "FavProd-Display": display.toString(),
                                                                  "FavProd-Memory": memory.toString(),
                                                                  "FavProd-Processor": processor.toString(),
                                                                  "FavProd-Storage": storage.toString(),
                                                                  "FavProd-Os": os.toString(),
                                                                  "FavProd-Power":power.toString(),
                                                                };
                                                                FirebaseFirestore.instance.collection("Favourites").doc(prodId).set(productDetail);
                                                              }
                                                              else {
                                                                 FirebaseFirestore.instance.collection("Favourites").doc(prodId).delete();
                                                              }


                                                              // void removeProductFromWishlist(String productId) async {
                                                              //   await FirebaseFirestore.instance.collection("Favourites").doc(productId).delete();
                                                              // }
                                                            },
                                                            child: Container(
                                                                width: 40,
                                                                height: 33,
                                                                margin: const EdgeInsets.only(left: 135,right: 5,top: 5),
                                                                decoration: const BoxDecoration(

                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xffffffff),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:  Color(
                                                                            0xf3c4c4c4),
                                                                        spreadRadius: 1,
                                                                        blurRadius: 5,
                                                                        offset: Offset(2, 2),
                                                                      )
                                                                    ]
                                                                  // border: Border.all(color: Color(0xffa19e9e))
                                                                ),
                                                                child:isProductInWishlist ? const Icon(CupertinoIcons.heart_fill,color: Color(0xf0003333)):
                                                                const Icon(CupertinoIcons.heart,color: Color(0xf0003333))
                                                            ),
                                                          ),

                                                        ],),
                                                      // SizedBox(height: 30,),
                                                      Container(
                                                        margin: const EdgeInsets.only(top: 6,left: 10,right: 10),
                                                        child: Text(name,style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color:Theme.of(context).iconTheme.color,
                                                        ),),
                                                      ),

                                                      Row(
                                                        children: [
                                                          const SizedBox(width: 10,),
                                                          const Icon(Icons.star_outline_rounded,color: Color(
                                                              0xf0343434)),
                                                          const SizedBox(width: 5,),
                                                          Text("5.00", style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            color:  const Color(0xf0343434),
                                                          ),),
                                                          const SizedBox(width: 14,),
                                                          Text("\$$price",style: GoogleFonts.poppins(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: const Color(0xf0003333),
                                                          ),),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),

                                    ),
                                  );
                                }if (snapshot.hasError) {
                                  return const Icon(Icons.error_outline);
                                }
                                return Container();
                              }),






                        ],
                      ),
                    ),

                  ]),

            ],
          ),

        ));
  }
}
