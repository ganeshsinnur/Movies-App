import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class wishlistPage extends StatefulWidget {
  const wishlistPage({super.key});

  @override
  State<wishlistPage> createState() => _WishlistPage();
}

class _WishlistPage extends State<wishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width:MediaQuery.of(context).size.width*.5,
          height: MediaQuery.of(context).size.width*0.5,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Center(child: Text("Wishlist")),
        ),
      ),
    );
  }
}
