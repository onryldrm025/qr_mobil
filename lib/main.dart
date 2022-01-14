import 'package:flutter/material.dart';
import 'package:qr_mobil/qr_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController scNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  String? nameP;
  String? scNoP;
  String? companyP;
  SharedPreferences? prefs;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nameP = prefs?.getString('name');
      scNoP = prefs?.getString('scNo');
      companyP = prefs?.getString('company');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: scNoP == null
          ? Scaffold(
              // resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Qr Oluşturma'),
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 25),
                centerTitle: true,
              ),
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/blue_full_WH.png',
                              width: MediaQuery.of(context).size.width * 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Center(
                            child: Text(
                              'Hoş geldiniz.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: company,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Şirket ismi!';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.characters,
                            cursorColor: Colors.grey,
                            style: const TextStyle(color: Colors.white),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Şirket İsmi  ',
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: scNo,
                            validator: (value) {
                              if (value?.length != 5 || value!.isEmpty) {
                                return 'Sicil no eksik veya yanlış!';
                              }
                              return null;
                            },
                            cursorColor: Colors.grey,
                            style: const TextStyle(color: Colors.white),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Sicil No  ',
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: name,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'İsim ve soyisim';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Ad Soyad  ',
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                prefs?.setString('name', name.text);
                                prefs?.setString('scNo', scNo.text);
                                prefs?.setString('company', company.text);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QrScreen(
                                      name: name.text,
                                      scNo: scNo.text,
                                      sirket: company.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('Qr Oluştur'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : QrScreen(
              name: nameP!,
              scNo: scNoP!,
              sirket: companyP!,
            ),
    );
  }
}
