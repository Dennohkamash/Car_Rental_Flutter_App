import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp1/Pages/vehicle_List.dart';

class Registercar extends StatefulWidget {
  const Registercar({super.key});

  @override
  State<Registercar> createState() => _RegistercarState();
}

class _RegistercarState extends State<Registercar> {
  dynamic _image; // Used dynamic type to store either File or Uint8List
  TextEditingController _modelController = TextEditingController();
  TextEditingController _registrationPlateController = TextEditingController();
  TextEditingController _transmissionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _chargeController = TextEditingController();
  TextEditingController _contactDetailsController = TextEditingController();

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (kIsWeb) {
      // For web, use Uint8List
      final bytes = await image.readAsBytes();
      setState(() {
        _image = bytes;
      });
    } else {
      // For mobile, use File
      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;
      });
    }
  }

  Future<void> addVehicleToFirestore(BuildContext context) async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please choose an image')),
      );
      return;
    }

    String model = _modelController.text;
    String registrationPlate = _registrationPlateController.text;
    String transmission = _transmissionController.text;
    String type = _typeController.text;
    String charge = _chargeController.text;
    String contactDetails = _contactDetailsController.text;

    String imagePath = 'vehicles/${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child(imagePath);

    try {
      if (kIsWeb) {
        await storageReference.putData(_image as Uint8List);
      } else {
        await storageReference.putFile(_image as File);
      }

      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance.collection('vehicles').add({
        'model': model,
        'registrationPlate': registrationPlate,
        'transmission': transmission,
        'type': type,
        'charge': charge,
        'contactDetails': contactDetails,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle added successfully')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Vehiclelist()),
        (route) => false,
      );
    } catch (error) {
      print('Error adding vehicle: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding vehicle')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VEHICLE DETAILS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            Icon(
              Icons.car_repair_rounded,
              size: 35,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MODEL:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  hintText: 'Enter Car Model',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "REGISTRATION PLATE:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _registrationPlateController,
                decoration: InputDecoration(
                  hintText: 'Enter Registration Plate',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "TRANSMISSION:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _transmissionController,
                decoration: InputDecoration(
                  hintText: 'Enter Transmission',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "TYPE:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  hintText: 'Enter Type',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "CHARGE RATE PER HOUR IN \$:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _chargeController,
                decoration: InputDecoration(
                  hintText: 'Enter Charge',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "CONTACT DETAILS:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              TextFormField(
                controller: _contactDetailsController,
                decoration: InputDecoration(
                  hintText: 'Enter Email/Phone Number',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "UPLOAD IMAGE:",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              if (_image == null)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "addimage.jpg",
                    height: 350,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              if (_image != null)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: kIsWeb
                      ? Image.memory(
                          _image as Uint8List,
                          height: 350,
                          width: 350,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _image as File,
                          height: 350,
                          width: 350,
                          fit: BoxFit.cover,
                        ),
                ),
              ElevatedButton(
                onPressed: getImage,
                child: Text('Choose Image'),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 150,
                  child: GestureDetector(
                    onTap: () => addVehicleToFirestore(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "ADD VEHICLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
