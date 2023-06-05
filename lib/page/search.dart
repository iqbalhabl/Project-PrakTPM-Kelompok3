import 'package:flutter/material.dart';
import 'package:jadwal_sholat/model/location_model.dart';
import 'package:jadwal_sholat/page/jadwal.dart';

const accessoriesColor = Colors.cyan;
const backgroundColor = Colors.white;
const iconColor = Colors.grey;
const textColor = Colors.cyan;
const fillColor = Colors.white;

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tugas Akhir - Search',
          style: TextStyle(color: fillColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: accessoriesColor,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(color: backgroundColor),
        child: Column(
          children: [
            const SizedBox(height: 220),
            TextFormField(
              controller: queryController,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: accessoriesColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: accessoriesColor,
                    width: 3,
                  ),
                ),
                filled: true,
                fillColor: fillColor,
                focusColor: accessoriesColor,
                hintText: 'Masukkan kota',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: iconColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: accessoriesColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                String query = queryController.text;
                print('query: $query');

                Future<List<Location>> locationResults =
                    Location.fetchLocation(query);
                locationResults.then((value) {
                  if (value.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JadwalPage(
                            location: value[0].lokasi, id: value[0].id),
                      ),
                    );
                  }
                });
              },
              child: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
