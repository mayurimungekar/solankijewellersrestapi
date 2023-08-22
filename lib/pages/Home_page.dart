import 'package:flutter/material.dart';
import 'package:solanki/utils/cart_icon.dart';

import 'dashboard_page.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> _widgetList =[
    Dashboard_page(),
    Dashboard_page(),
    Dashboard_page(),
    Dashboard_page(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar:
      BottomNavigationBar(
        items: [
          BottomNavigationBarItem(

            icon: Icon(CartIcons.home,),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
                CartIcons.cart
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.favorites),
            label: 'favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.account),
              label: 'My account'
          ),
        ],
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.brown,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index){
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.brown,
      automaticallyImplyLeading: false,
      title: const Text(
        "Solanki Jewellers",
        style: TextStyle(color: Colors.white),
      ),
      actions: const [
        Icon(Icons.notifications_none, color: Colors.white,),
        SizedBox(width: 10,),
        Icon(Icons.shopping_cart, color: Colors.white,),
      ],
    );
  }
}
