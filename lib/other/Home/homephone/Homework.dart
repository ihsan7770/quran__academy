import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quran__academy/Widget%20class/theme.dart';
import 'package:quran__academy/other/Home/homephone/Student_profile_phn.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({super.key});

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  final PageController _pageController = PageController();

  final List<String> prayerNames = [
    "Quran Reading Morning",
    "Tahajud Prayer",
    "Subhi Prayer",
    "Luha Prayer",
    "Sunnah Prayer Before Dhuhur",
    "Dhuhur Prayer",
    "Sunnah Prayer After Dhuhur",
    "Sunnah Prayer Before Asr",
    "Asr Prayer",
    "Sunnah Prayer After Asr",
    "Sunnah Prayer Before Maghrib",
    "Maghrib Prayer",
    "Sunnah Prayer After Maghrib",
    "Sunnah Prayer Before Isha",
    "Hudad Reading",
    "Isha Prayer",
    "Sunnah Prayer After Isha",
    "Quran Reading Night"
  ];

  List<bool> isCheckedList = List.generate(18, (index) => false);
  String? userName;
  String? studentName;
  String? studentStandard;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCheckedStates();
  }

  /// Fetch user and student details
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      QuerySnapshot studentQuery = await FirebaseFirestore.instance
          .collection('students')
          .where('uid', isEqualTo: user.uid)
          .limit(1)
          .get();

      if (mounted) {
        setState(() {
          userName = userDoc.exists ? userDoc['Name'] : "Unknown User";
          if (studentQuery.docs.isNotEmpty) {
            studentName = studentQuery.docs.first['Name'];
            studentStandard = studentQuery.docs.first['standard'];
          } else {
            studentName = "Unknown Student";
            studentStandard = "N/A";
          }
        });
      }
    }
  }

  /// Load checked states from Firestore
  Future<void> _loadCheckedStates() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('homework').doc(user.uid).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> tasks = data['tasks'] ?? {};

        setState(() {
          for (int i = 0; i < prayerNames.length; i++) {
            isCheckedList[i] = tasks[prayerNames[i]] == "Done";
          }
        });
      }
    }
  }

  /// Save checked states to Firestore
  Future<void> _saveCheckedStates() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, String> statusMap = {};
      for (int i = 0; i < prayerNames.length; i++) {
        statusMap[prayerNames[i]] = isCheckedList[i] ? "Done" : "Not Done";
      }

      await FirebaseFirestore.instance.collection('homework').doc(user.uid).set({
        "userName": userName,
        "studentName": studentName,
        "studentStandard": studentStandard,
        "tasks": statusMap,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }
  }

  /// Show confirmation before submission
  void _confirmSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Submission"),
        content: const Text("Are you sure you want to submit the homework?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handleSubmit();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  /// Handle submission and save to Firestore
  Future<void> _handleSubmit() async {
    await _saveCheckedStates();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Homework submitted successfully!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile()));
          },
        ),
        title: Text("Home Work"),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(0, 9),
                _buildPage(9, 18),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  /// Build page with homework rows
  Widget _buildPage(int start, int end) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(end - start, (index) => _buildHomeworkRow(start + index)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Build each row with a checkbox only
  Widget _buildHomeworkRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              prayerNames[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 50,
            child: Checkbox(
              activeColor: Colors.green,
              checkColor: Colors.white,
              value: isCheckedList[index],
              onChanged: (bool? newValue) async {
                setState(() {
                  isCheckedList[index] = newValue!;
                });
                await _saveCheckedStates();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Navigation buttons for switching pages
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          ),
          ElevatedButton(
            onPressed: _confirmSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Submit"),
          ),
          IconButton(
            onPressed: () {
              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.arrow_forward_ios, size: 30, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
