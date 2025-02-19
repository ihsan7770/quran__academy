import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/AddEvents.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/other/Widget%20class/theme.dart';

class AdminHomePhn extends StatefulWidget {
  const AdminHomePhn({super.key});

  @override
  State<AdminHomePhn> createState() => _AdminHomePhnState();
}

class _AdminHomePhnState extends State<AdminHomePhn> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: AppColors.lightGreen,

     appBar: AppBar(
        backgroundColor:AppColors.lightGreen,
        leading: IconButton(
        icon: Icon(Icons.arrow_back,size: 30,),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPhone()));
           },
          )
      ),


      body: Column(children: [

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {

                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AddEvents()),
                  );

                  
                },
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.amber,  
                  borderRadius: BorderRadius.circular(30)),
                  width: 150,
                  height: 150,
                  
                  child: Center(child: Text("Add Events"),),
                ),
              ),
            ),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Container(
                   decoration: BoxDecoration(
                  color: Colors.amber,  
                  borderRadius: BorderRadius.circular(30)),
                  width: 150,
                  height: 150,
                 
                  child: Center(child: Text("any thing else"),),
                ),
              ),
            )


          ],
        ),

//2nd row start
         Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                  color: Colors.amber,  
                  borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Text("Add Events"),),
                ),
              ),
            ),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Container(
                  width: 150,
                  height: 150,
                   decoration: BoxDecoration(
                  color: Colors.amber,  
                  borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Text("any thing else"),),
                ),
              ),
            )


          ],
        )


      ],)







    );
  }
}