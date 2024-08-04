import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paygofit/utils/useraddress.dart';
import 'package:paygofit/widget/card.dart';

class ListPage extends StatefulWidget {
  UserAddress location;
   ListPage({ required this.location ,super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _selectedIndex = 0;

  int _currentindex =0;

  Map<String ,int> game = {'Gym': 1, 'Swim': 2, 'Badminton': 3, 'Yoga': 4, 'Cricket': 5, 'Basketball': 6};

  List gameList = ['Gym','Swim', 'Badminton', 'Yoga', 'Cricket','Basketball']; 

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
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
      backgroundColor:Colors.white  ,
        
        // elevation: 10,
       title: 
        SizedBox(
         child: Row(
          children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                Text(widget.location.city,style: const TextStyle(color: Colors.black,fontWeight:FontWeight.w500),),
                Text('${widget.location.street}, ${widget.location.sublocality},${widget.location.city}, ${widget.location.state}' ,style: const TextStyle(color: Colors.black,fontSize: 13),)
               ],),  
   
          ],
         ),
       ),
      ),
        body: Column(
          children: [
       horizontalList(),
        SizedBox(height: 10,),
        Expanded(
          child: 
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
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ImageCard(
                  imageurl: data[index]['imageurl'] ?? '',
                  name: data[index]['name']??'null' ,
                  address: data[index]['address']??'',
                  price: data[index]['price']??0,
                  
                );
              },
            );
          }
        },
        ))
          ]
        ),
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
      ),
    );
  }


  Widget horizontalList(){
    

    return SizedBox(
      height:50, // Set the height for the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: gameList.length, // Replace with the number of items you want to display
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              // height: 34,
              // width: 100, // Set the width for each item
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
         color: _selectedIndex == index ? Colors.blue : Colors.white,
         border: Border.all(color:Colors.grey  ),
              ),
     
              child: Center(
                child: Text(
                  gameList[index],
                  style: TextStyle(color: _selectedIndex == index ? Colors.white : Colors.black, fontSize: 17),
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  
}


