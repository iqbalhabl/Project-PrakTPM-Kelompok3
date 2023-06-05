import 'package:flutter/material.dart';
import 'package:jadwal_sholat/model/schedule_model.dart';

class JadwalPage extends StatefulWidget {
  final String? id;
  final String? location;
  const JadwalPage({Key? key, required this.location, required this.id})
      : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  final jadwal = Jadwal();
  Future<List<Jadwal>>? jadwalResults;

  @override
  void initState() {
    if (widget.id != null) {
      jadwalResults = Jadwal.fetchJadwal(widget.id);
    }
    print("widgetid : ${widget.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(40),
              height: 200,
              width: 200,
              child: Image.asset("assets/images/praying.png"),
            ),
            Text(
              widget.location ?? "No location",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: jadwalResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data?[index].tanggal.toString() ??
                                    "No data",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              customRow('Subuh',
                                  snapshot.data?[index].subuh.toString()),
                              const SizedBox(height: 5),
                              customRow('Dhuha',
                                  snapshot.data?[index].dhuha.toString()),
                              const SizedBox(height: 5),
                              customRow('Dzuhur',
                                  snapshot.data?[index].dzuhur.toString()),
                              const SizedBox(height: 5),
                              customRow('Maghrib',
                                  snapshot.data?[index].maghrib.toString()),
                              const SizedBox(height: 5),
                              customRow('Isya',
                                  snapshot.data?[index].isya.toString()),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(String text1, String? text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 120,
          child: Text(
            text1,
            style:
                const TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.teal[50],
          ),
          child: Text(
            text2 ?? ' No Data',
            style: const TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
