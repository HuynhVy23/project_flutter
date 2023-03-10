import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget background(Widget lb, context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffe59191),
                    Color(0x99e59191),
                    Color(0x66e59191),
                  ]),
            ),
            child: lb,
          ),
        ]),
      ));
}

Widget background1(TabBarView lb, context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffe59191),
                    Color(0x99e59191),
                    Color(0x66e59191),
                  ]),
            ),
            child: lb,
          ),
        ]),
      ));
}
class CartCounter extends StatefulWidget{
  const CartCounter({Key? key}) : super(key: key);

  @override 
  _CartCounterState createState() => _CartCounterState();
}
class _CartCounterState extends State<CartCounter>
{
  int numOfItems=1;
   @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed:() {
          setState(() {
            numOfItems--;
          });},
            child: Icon(Icons.remove),
          ),
        ),
        Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            numOfItems.toString().padLeft(2,"0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed:() {
          setState(() {
            numOfItems++;
          });},
            child: Icon(Icons.add),
          ),
        )
        
      ],
    ) ;
  }
  SizedBox buildOutlineButton({required IconData icon, required Function() press}){
    return SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed: press,
            child: Icon(icon),
          ),
        );
  }
}

