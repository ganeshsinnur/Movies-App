import 'package:alibaba/pages/home_page.dart';
import 'package:alibaba/pages/search_page.dart';
import 'package:alibaba/pages/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class bottomNavbar extends StatelessWidget{
  const bottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black87,
          height: 70,
          child: const TabBar(tabs: [
            Tab(icon: Icon(Icons.home),
            text: "home",),
            Tab(icon: Icon(Icons.search),
              text: "Search",),
            Tab(icon: Icon(Icons.bookmark_outline),
              text: "Wishlist",)
          ],
          //indicatorColor: Colors.transparent,
            indicatorColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            dividerColor: Colors.transparent,

          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            SearchScreen(),
            WishlistPage()
          ],
        ),
        
      ),

    );
  }
}
