
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop/Checkout/Add_to_Cart.dart';
import 'package:laptop/Checkout/checkout_screen.dart';
import 'package:laptop/FeedBack_Screen.dart';
import 'package:laptop/Profile_Firebase_Firestore/Profile_Screen.dart';
import 'package:laptop/firebase_options.dart';
import 'package:laptop/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Firebase_Auth/Login_Screen.dart';
import 'home/favourite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AddToCart(),

    );
  }
}
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}
class _BottomNavigationState extends State<BottomNavigation> {

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

  int selectedIndex=0;
  void pageShifter(index){
    setState(() {
      selectedIndex=index;
    });
  }

  List<Widget> myScreens=[
    const HomePage(),
    const FavouriteList(),
     AddToCart(),
    const FeedbackScreen(),
    const profileScreen()
  ];



  // @override
  // void initState() {

  //   Timer(
  //       Duration(milliseconds: 5000), () =>
  //     FirebaseAuth.instance.currentUser!= null? Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => profileScreen(),
  //         )
  //     )
  //         : Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context)=> LoginScreen(),)
  //     )
  //   );
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:myScreens[selectedIndex],

        bottomNavigationBar: CurvedNavigationBar(
            index: selectedIndex,
            backgroundColor: const Color(0xffffffff),
            color: const Color(0xf0002525),
            onTap: pageShifter,
            items: [
              Icon(Icons.home_filled, color: selectedIndex!=0? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.favorite_border, color: selectedIndex!=1? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.shopping_cart_outlined, color: selectedIndex!=2? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.feedback,color: selectedIndex!=3? const Color(0xffffffff):
              const Color(0xf0a9a9a9),),
              Icon(Icons.person_2_outlined,color:  selectedIndex!=4? const Color(0xffffffff):
              const Color(0xf0a9a9a9),)
            ])


    );
  }
}


