import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapor_book/components/komentar_dialog.dart';
import 'package:lapor_book/components/status_dialog.dart';
import 'package:lapor_book/models/akun.dart';
import 'package:lapor_book/models/laporan.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan({super.key});

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  final bool _isLoading = false;

  Future launch(String uri) async {
    if (uri == '') return;
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil : $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Laporan laporan = arguments['laporan'];
    Akun akun = arguments['akun'];

    void statusDialog(Laporan laporan) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatusDialog(
            laporan: laporan,
          );
        },
      );
    }

    void komentarDialog(Laporan laporan) {
      showDialog(
        context: context,
        builder: (context) {
          return KomentarDialog(laporan: laporan, akun: akun);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Detail Laporan'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            laporan.judul,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          laporan.gambar != ''
                              ? Image.network(laporan.gambar!)
                              : Image.asset('assets/istock-default.jpg'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              laporan.status == 'Posted'
                                  ? textStatus(
                                      'Posted', Colors.yellow, Colors.black)
                                  : laporan.status == 'Process'
                                      ? textStatus(
                                          'Process', Colors.green, Colors.white)
                                      : textStatus(
                                          'Done', Colors.blue, Colors.white),
                              textStatus(
                                  laporan.instansi, Colors.white, Colors.black),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Center(child: Text('Nama Pelapor')),
                            subtitle: Center(
                              child: Text(laporan.nama),
                            ),
                            trailing: const SizedBox(width: 45),
                          ),
                          ListTile(
                            leading: const Icon(Icons.date_range),
                            title: const Center(child: Text('Tanggal Laporan')),
                            subtitle: Center(
                                child: Text(DateFormat('dd MMMM yyyy')
                                    .format(laporan.tanggal))),
                            trailing: IconButton(
                              icon: const Icon(Icons.location_on),
                              onPressed: () {
                                launch(laporan.maps);
                              },
                            ),
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            'Deskripsi Laporan',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(laporan.deskripsi ?? ''),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Builder(
                            builder: (context) {
                              if (akun.role == 'admin') {
                                return SizedBox(
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {});
                                      statusDialog(laporan);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.orangeAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text('Ubah Status'),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {
                                komentarDialog(laporan);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Tambah Komentar'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'List Komentar',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Builder(
                            builder: (context) {
                              if (laporan.komentar != null) {
                                return ListView.builder(
                                  itemCount: laporan.komentar!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              laporan.komentar![index].nama,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(laporan.komentar![index].isi,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ))
                                          ]),
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ]),
                  ),
                )),
    );
  }

  Container textStatus(String text, var bgcolor, var textcolor) {
    return Container(
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgcolor,
          border: Border.all(width: 1, color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(25)),
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
    );
  }
}
