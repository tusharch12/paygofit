import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:location/location.dart';
import 'package:paygofit/page/list_page.dart';
import 'package:paygofit/services/location_service.dart';
import 'package:paygofit/utils/useraddress.dart';
import 'package:paygofit/widget/card.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 UserAddress location = UserAddress(street: '', city: 'finding..', state: '', country: '', postalCode: '',sublocality: '')  ;
  int _currentindex = 0;
  @override
  void initState() {
   getlocation();
    super.initState();
  }

  getlocation() async{

location=await LocationService.getAddressFromCurrentLocation();

setState(() {
});
  }

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getData() async {
    QuerySnapshot querySnapshot = await _firestore.collection('GYM').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    print(docs);
    List<Map<String, dynamic>> data = docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;  
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromRGBO(241, 231, 255, 1)   ,
        
        // elevation: 10,
       title: 
        SizedBox(
         child: Row(
          children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                Text(location.city,style: const TextStyle(color: Color.fromARGB(255,36, 36, 36),fontWeight:FontWeight.bold),),
                Text('${location.street}, ${location.sublocality},${location.city}, ${location.state}' ,style: const TextStyle(color: Color.fromARGB(255,85, 85, 85),fontSize: 13),)
               ],),  
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset('asset/image/coin 1.png'),
                    Text('Points',style: const TextStyle(color: Color.fromARGB(255,85, 85, 85),fontSize: 15),),
                  ],
                ),
                Text('3,725',style: const TextStyle(color: Color.fromARGB(255,36, 36, 36),fontWeight: FontWeight.w700))
              ],
            )
          ],
         ),
       ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Container(
              padding: const EdgeInsets.fromLTRB(17, 0, 20, 0),
              height: 0.28 *h,
              width: double.infinity,
              decoration: const BoxDecoration(
                
                color: Color.fromRGBO(241, 231, 255, 1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          
              ),
              child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Text('Hello, karthik!' ,style: TextStyle(
                  color: Color.fromARGB(255,43, 43, 43,),
                  fontSize: 40, fontWeight: FontWeight.bold
                ),),
                const Text('What would you like to do today?',style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255,126, 58, 242),
                ),),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                              height: 0.06 *h,
                              width: 0.75 * w,
                    
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 0.030 * w),
                                  Container(
                                      height: 0.02 * h,
                                      width: 0.04 * w,
                                      child: SvgPicture.asset(
                                        'asset/image/search.svg',
                                        height: 0.03 * h,
                                        width: 0.03 * w,
                                      )),
                                      
                                  SizedBox(width: 0.010 * w),
                                  Text('Find a nearby activity',style: TextStyle(
                                    color: Color.fromARGB(175, 102, 112, 133)
                                  ),)
                                
                                ],
                              ),
                            ),
                         Spacer(),
                            SvgPicture.asset('asset/image/filter.svg'),
                  ],
                )
        
              ],)
            ),
        
            Padding(padding: const EdgeInsets.fromLTRB(25.0,0,25.0,0),
              child: Wrap(
              children: [
                ZoomTapAnimation(
                  onTap: (){
                    print('hello');
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ListPage(location: location,)));
                },child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset('asset/image/Gym.svg'))),
        
                ZoomTapAnimation(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('asset/image/Swim.svg'),
                )),
                ZoomTapAnimation(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('asset/image/BAd.svg'),
                )),
                ZoomTapAnimation(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('asset/image/YOGA.svg'),
                )),
                ZoomTapAnimation(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('asset/image/Gym.svg'),
                )),
                  ZoomTapAnimation(child: Container(
                    height: 0.13 *h,
                    width: 0.27 * w,
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('View All',style: TextStyle( decoration: TextDecoration.underline,fontSize: 15 ,color: Color.fromARGB(255,126, 58, 242)),))))
              ],
              ),
            ),
             SizedBox(height: 10,),
          FutureBuilder<List<Map<String, dynamic>>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found'));
            } else {
              List<Map<String, dynamic>> data = snapshot.data!;
              print(data);
              return ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ImageCard(
                    imageurl: data[index]['imageurl'] ?? '',
                    name: data[index]['name']?? 'GYM' ,
                    address: data[index]['address']??'',
                    price: data[index]['price']??0,
                    
                  );
                },
              );
            }
          },
          )
          ]
        ),
      ) ,
       bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 126, 58, 246),
        unselectedItemColor: Colors.grey,
          
 // Set the color of the selected item
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentindex,
        items: [
        BottomNavigationBarItem(icon: SvgPicture.asset('asset/icons/Home_fill.svg',
        color:  _currentindex== 0 ? Color.fromARGB(255, 126, 58, 246) : Colors.grey,
        ),
        activeIcon: SvgPicture.asset('asset/icons/Home_fill.svg',), label: 'Home'),
        BottomNavigationBarItem(icon: SvgPicture.asset('asset/icons/Pipe_fill.svg',color:  _currentindex== 1 ? Color.fromARGB(255, 126, 58, 246) : Colors.grey,), label: 'Booking'),
         BottomNavigationBarItem(icon: SvgPicture.asset('asset/icons/Chart_alt_fill.svg',color:  _currentindex== 2 ? Color.fromARGB(255, 126, 58, 246) : Colors.grey,), label: 'Explore'
      ),
        BottomNavigationBarItem(icon: SvgPicture.asset('asset/icons/User_fill.svg',color:  _currentindex== 3 ? Color.fromARGB(255, 126, 58, 246) : Colors.grey,),label: 'profile'),

       ],
       onTap: (index){
        setState(() {
          _currentindex = index;
        });
       }
       ),
    );
  }
}