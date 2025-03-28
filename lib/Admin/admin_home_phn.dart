import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran__academy/Admin/AddEvents.dart';
import 'package:quran__academy/Admin/AdminHomeWork.dart';
import 'package:quran__academy/Admin/AdminSendNotification.dart';
import 'package:quran__academy/Admin/AdminSponsershipMannage.dart';
import 'package:quran__academy/Admin/AdminStudentManage.dart';
import 'package:quran__academy/Admin/Admin_View_Bookings.dart';
import 'package:quran__academy/Admin/Admin_View_Complaints.dart';
import 'package:quran__academy/Admin/Admin_View_DonatedAmount.dart';
import 'package:quran__academy/Admin/ParentStudnetManage.dart';
import 'package:quran__academy/other/Home/homephone/Login_Phone.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

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


      body: SingleChildScrollView(
        child: Column(children: [
        
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
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminComplaints()));
                  },
                  child: Container(
                     decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    width: 150,
                    height: 150,
                   
                    child: Center(child: Text("View Complaints"),),
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
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminViewBookings()));
        
        
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("View Invitations"),),
                  ),
                ),
              ),
        
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSendNotification()));
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                     decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Send Announcements"),),
                  ),
                ),
              )
        
        
            ],
          ),
        
        
        
        //3rd row
        
        
              Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDonatedAmounts ()));
        
        
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Donated Amount"),),
                  ),
                ),
              ),
        
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeWork()));
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                     decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Home Work"),),
                  ),
                ),
              )
        
        
            ],
          ),
          //3rd row ends
        
        //4rth row start
        
                Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) =>ParentStudentManaging()));
        
        
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Parent Details"),),
                  ),
                ),
              ),
        
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminStudentManage ()));
                    
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                     decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Student Management "),),
                  ),
                ),
              )
        
        
            ],
          ),////4rth row start






           Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
        
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AdminSponsershipManagement()),
                    );
        
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.amber,  
                    borderRadius: BorderRadius.circular(30)),
                    width: 150,
                    height: 150,
                    
                    child: Center(child: Text("Sponsership Details"),),
                  ),
                ),
              ),
        
         
        
        
            ],
          ),
        
        
        
        
        
        
        
        ],),
      )







    );
  }
}