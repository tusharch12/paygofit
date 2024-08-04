import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(),
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