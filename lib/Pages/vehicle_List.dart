import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp1/Pages/register_car.dart';

class Vehiclelist extends StatefulWidget {
  const Vehiclelist({super.key});

  @override
  State<Vehiclelist> createState() => _VehiclelistState();
}

class _VehiclelistState extends State<Vehiclelist> {
  Future<List<Map<String, dynamic>>> getUserVehicles() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String userEmail = user.email ?? "";
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('contactDetails', isEqualTo: userEmail)
          .get();

      List<Map<String, dynamic>> vehicleList = [];
      querySnapshot.docs.forEach((document) {
        vehicleList.add({
          'imageUrl': document['imageUrl'],
          'transmission': document['transmission'],
          'model': document['model'],
        });
      });

      return vehicleList;
    } else {
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> getVehicleDataStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Delay to refresh data
      yield await getUserVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.of(context).pop(); // Navigate to previous page
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VEHICLES ADDED',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            Icon(
              Icons.car_repair_rounded,
              size: 35,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Registercar()),
          );
        },
        tooltip: 'add vehicle',
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: getVehicleDataStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading data'));
            } else {
              List<Map<String, dynamic>> vehicleList = snapshot.data ?? [];

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vehicleList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // TODO: Handle tapping on a vehicle to view details
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            vehicleList[index]['imageUrl'],
                            width: 100,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 5),
                          Text(
                            vehicleList[index]['model'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            vehicleList[index]['transmission'],
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
