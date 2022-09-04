import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../boxes.dart';
import '../components/base.dart';
import '../widgets/routeur_dialog.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<base> Bases =[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("img/logo.jpg",),
                      const Icon(Icons.balance,size: 40, color: Colors.grey,)
                    ],
                  ),
                ),
              )
          ),
          Expanded(
              flex:5,
              child:Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: const BoxDecoration(
                            color: Color(0xff046ECE),
                            borderRadius: BorderRadius.only(
                                bottomLeft:Radius.circular(40),
                                topRight: Radius.circular(40)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gestion des boxes internets",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => RouteurDialog(
                                  onClickedDone: addbase,
                                  ),
                                  ),
                                child: Text('Ajouter une box',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: const Color(0xff046ECE),
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              flex:2,
                              child: ValueListenableBuilder<Box<base>>(
                                valueListenable: Boxes.getTransactions().listenable(),
                                builder: (context, box, _) {
                                  final bases = box.values.toList().cast<base>();
                                  return buildContent(bases);
                                },
                              ),
                          ),
                          Expanded(
                              child: ValueListenableBuilder<Box<base>>(
                                valueListenable: Boxes.getTransactions().listenable(),
                                builder: (context, box, _) {
                                  final bases = box.values.toList().cast<base>();
                                  return buildContentNotif(bases);
                                },
                              ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget buildContent(List<base> bases) {
    if (bases.isEmpty) {
      return const Center(
        child: Text(
          'Pas de routeurs enregistrés',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {

      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: bases.length,
              itemBuilder: (BuildContext context, int index) {
                final Bases = bases[index];

                return buildBases(context, Bases);
              },
            ),
          ),
        ],
      );
    }
  }


  Widget buildContentNotif(List<base> bases) {
    if (bases.isEmpty) {
      return const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {

      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: bases.length,
              itemBuilder: (BuildContext context, int index) {
                final Bases = bases[index];

                return buildBasesNotif(context, Bases);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildBases(
      BuildContext context,
      base Bases,
      ) {

    return Container(
            height: 160,
            margin: const EdgeInsets.only(left: 40,top: 5, bottom: 5, right: 10),
            padding: const EdgeInsets.only(left: 40, top: 20, bottom: 10, right: 30),
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    left: BorderSide(width: 15, color: Colors.green)
                )
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Bases.Direction,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            //fontStyle: FontStyle.italic,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      Text(Bases.Fournisseur,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            //fontStyle: FontStyle.italic,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(Bases.DateFA),
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            //fontStyle: FontStyle.italic,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      const Icon(FontAwesomeIcons.arrowDown, color: Color.fromRGBO(0, 0, 0, 0.3), size: 25,),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Numéro SIM:",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(Bases.NumberSim.toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      const SizedBox(width: 30,),
                      Text("|",
                        style: GoogleFonts.montserrat(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.4)
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Text("Date abonnement",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(DateFormat('yyyy-MM-dd').format(Bases.DateA),
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("CodeBox:",
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(0, 0, 0, 0.8)
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Text(Bases.CodeBox,
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(0, 0, 0, 0.8)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RouteurDialog(
                                  Base:Bases,
                                  onClickedDone: ( Direction, Fournisseur, NumberSim, CodeBox, DateA, DateFA, DateNO) =>
                                      editbase( Bases,Direction, Fournisseur, NumberSim, CodeBox, DateA, DateFA, DateNO),
                                ),
                              ),
                            ),
                            child: Text("Modifier",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,),
                            ),
                          ), const SizedBox(width: 30,),
                          InkWell(
                            onTap: () => deletebase(Bases),
                            child: Text("Supprimer",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color:  Colors.red
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]
            )
        );
  }

  Widget buildBasesNotif(
      BuildContext context,
      base Bases,
      ) {

    return
      DateFormat('yyyy-MM-dd').format(Bases.DateNO)==DateFormat('yyyy-MM-dd').format(DateTime.now())?
      Container(
        height: 200,
        margin: const EdgeInsets.only(left: 40,top: 5, bottom: 5, right: 10),
        padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                right: BorderSide(width: 15, color: Colors.deepOrange)
            )
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Direction
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Direction:",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        color: const Color.fromRGBO(0, 0, 0, 0.8)
                    ),
                  ),
                  Text(Bases.Direction,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        color: const Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              //Fournisseur
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fournisseur:",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        color: const Color.fromRGBO(0, 0, 0, 0.8)
                    ),
                  ),
                  Text(Bases.Fournisseur,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        //fontStyle: FontStyle.italic,
                        color: const Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              //NumberSim
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number Sim:",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 0.8)
                    ),
                  ),
                  Text(Bases.NumberSim.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              //Date FA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text("Date de fin d'abonnement:",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(0, 0, 0, 0.8)
                      ),
                    ),
                  ),
                  Text(DateFormat('yyyy-MM-dd').format(Bases.DateFA),
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ],
              ),
              const SizedBox( height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text("Veuillez renouvelez avant la fin de votre abonnement",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              )


            ]
        )
    )
        :Container();
  }


  Future addbase(String Direction, String Fournisseur, int NumberSim, String CodeBox, DateTime DateA, DateTime DateFA, DateTime DateNO) async {
    final  bases= base()
      ..Direction= Direction
      ..Fournisseur = Fournisseur
      ..NumberSim = NumberSim
      ..CodeBox = CodeBox
      ..DateA = DateA
      ..DateFA = DateFA
      ..DateNO = DateNO;

    final box = Boxes.getTransactions();
    box.add(bases);
  }

  void editbase(
      base bases,
      String Direction,
      String Fournisseur,
      int NumberSim,
      String CodeBox,
      DateTime DateA,
      DateTime DateFA,
      DateTime DateNO
      ) {
    bases.Direction=Direction;
    bases.Fournisseur=Fournisseur;
    bases.NumberSim=NumberSim;
    bases.CodeBox=CodeBox;
    bases.DateA=DateA;
    bases.DateFA=DateFA;
    bases.DateNO=DateNO;

    bases.save();
  }

  void deletebase(base bases) {
    bases.delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor:  Colors.deepOrange,
          content: Text('Routeur supprimé',
            style: GoogleFonts.montserrat(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color:Colors.white,
            ),
          )),
    );
  }

}

/*Widget _buildPopupDialog(BuildContext context) {

  final _formKey = GlobalKey<FormState>();
  Routeur route = Routeur.empty();
  TextEditingController _txtDirection = TextEditingController();
  TextEditingController _txtFournisseur = TextEditingController();
  RouteurDAO  _routeurDAO = RouteurDAO();


  void Message(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void addofbase() async {
    try {
      Routeur retorno = await _routeurDAO.add(route);
      route.id = retorno.id;
      Message('Box ajouté avec succès');
      //setState(() {});
    } catch (error) {
      print(error);
      Message("Erreur lors de l'ajout");
    }
  }

  void save() {
    route.Direction = _txtDirection.text;
    route.Fournisseur = _txtFournisseur.text;
    if (route.id == null) {
      addofbase();
      return;
    }
  }




  return AlertDialog(
    title: const Center(child: Text("Enregistrer une nouvelle box",textAlign:TextAlign.center,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)),
    content: Container(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: _txtDirection,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor:Colors.grey,
                      decoration:  InputDecoration(
                        hintText: "Le nom de la Direction",
                        hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize:18,
                            fontWeight: FontWeight.w400
                        ),
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complètez de champ';
                        }
                        return null;
                      },

                    ),
                  ),
                  const SizedBox(height:20),
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: _txtFournisseur,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 0.7),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor:Colors.grey,
                      decoration:  InputDecoration(
                        hintText: "Le nom du Fournisseur",
                        hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize:18,
                            fontWeight: FontWeight.w400
                        ),
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complètez de champ';
                        }
                        return null;
                      },

                    ),
                  ),
                ],
              )
          )
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel', style: TextStyle(color: Colors.red),),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: InkWell(
          onTap:  () {
            if (_formKey.currentState!.validate())
            {save();}
          },
            child: const Text('Enregistrer', style: TextStyle(color: Colors.green),)),
      ),
    ],
  );
}*/
