import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generate/components/base.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class RouteurDialog extends StatefulWidget {
  final base? Base;
  //final Transaction? transaction;
  final Function(String Direction, String Fournisseur, int NumberSim, String CodeBox, DateTime DateA, DateTime DateFA, DateTime DateNO ) onClickedDone;

  const RouteurDialog({
    Key? key,
    this.Base,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _RouteurDialogState createState() => _RouteurDialogState();
}

class _RouteurDialogState extends State<RouteurDialog> {
  final formKey = GlobalKey<FormState>();
  final DirectionController = TextEditingController();
  final FournisseurController = TextEditingController();
  final NumberSimController = TextEditingController();
  final CodeBoxController = TextEditingController();
  final DateAController = TextEditingController();
  final DateFAController = TextEditingController();
  final DateNOController = TextEditingController();

  List<String> Routeurs=[
    "DG",
    "DAF",
    "DSV",
    "DDTA",
    "DSF",
    "SP",
    "PCA",
    "MÉDECIN CONSEIL",

  ];

  @override
  void initState() {
    super.initState();

    if (widget.Base != null) {
      final bases = widget.Base!;

      DirectionController.text = bases.Direction;
      FournisseurController.text = bases.Fournisseur;
      NumberSimController.text = bases.NumberSim.toString();
      CodeBoxController.text=bases.CodeBox;
      DateAController.text=(DateFormat('yyyy-MM-dd').format(bases.DateA)).toString();
      DateFAController.text=(DateFormat('yyyy-MM-dd').format(bases.DateFA)).toString();
      DateNOController.text=(DateFormat('yyyy-MM-dd').format(bases.DateNO)).toString();

    }
  }

  @override
  void dispose() {
    DirectionController.dispose();
    FournisseurController.dispose();
    NumberSimController.dispose();
    CodeBoxController.dispose();
    DateAController.dispose();
    DateFAController.dispose();
    DateNOController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.Base != null;
    final title = isEditing ? 'Modifier un routeur' : 'Ajouter un routeur';

    return AlertDialog(
      content: Form(
        key: formKey,
        child: SizedBox(
          width: 600,
          height: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff046ECE),
                  fontSize: 18,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: Column(
                        children: [
                          buildDirection(),
                          const SizedBox(height: 10,),
                          buildCodeBox(),
                        ],
                      )
                  ),
                  const SizedBox(width: 30,),
                  Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 25,),
                          buildFournisseur(),
                          const SizedBox(height: 10,),
                          buildNumberSim(),

                        ],
                      )
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130.0),
                child: buildDateA(),
              )
            ],
          )
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildDirection() => TextFormField(
        controller: DirectionController,
        style: GoogleFonts.montserrat(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon:const Icon(FontAwesomeIcons.nfcDirectional, color: Colors.grey, size:15),
          hintText: 'Entrer le nom de la Direction',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xff046ECE), width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildFournisseur() => TextFormField(
        controller: FournisseurController,
        style: GoogleFonts.montserrat(
      fontSize: 15,
    ),
        decoration: InputDecoration(
          prefixIcon:const Icon(FontAwesomeIcons.server, color: Colors.grey, size:15),
          border: const OutlineInputBorder(),
          hintText: 'Entrer le nom du Fournisseur',
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xff046ECE), width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildCodeBox() => TextFormField(
        controller: CodeBoxController,
        style: GoogleFonts.montserrat(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon:const Icon(FontAwesomeIcons.box, color: Colors.grey, size:15),
          border: const OutlineInputBorder(),
          hintText: 'Entrer le CodeBox',
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xff046ECE), width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDateA() => TextFormField(
        controller: DateAController,
        style: GoogleFonts.montserrat(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon:const Icon(FontAwesomeIcons.calendar, color: Colors.grey, size:15),
          border: const OutlineInputBorder(), hintText: "Entrer la date de début d'abonnement",
          focusedBorder: OutlineInputBorder(
        borderSide:
        const BorderSide(color: Color(0xff046ECE), width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
        ),
          onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101)
            );

            if(pickeddate !=null){
              setState(() {
                DateAController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
              });
            }
          },


        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDateFA() => TextFormField(
        controller: DateFAController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
          onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101)
            );

            if(pickeddate !=null){
              setState(() {
                DateFAController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
              });
            }
          },


        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDateNO() => TextFormField(
        controller: DateNOController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
          onTap: () async {
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101)
            );

            if(pickeddate !=null){
              setState(() {
                DateNOController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
              });
            }
          },


        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildNumberSim() => TextFormField(
        style: GoogleFonts.montserrat(
          fontSize: 15,
        ),
        maxLength: 8,
        decoration: InputDecoration(
          prefixIcon:const Icon(FontAwesomeIcons.simCard, color: Colors.grey, size:15),
          border: const OutlineInputBorder(),
          hintText: 'Entrer le numéro de la SIM',
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xff046ECE), width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (numbersim) => numbersim != null && double.tryParse(numbersim) == null
            ? 'Enter a valid number'
            : null,
        controller: NumberSimController,
      );


  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            color: Colors.deepOrange,
            fontWeight: FontWeight.w700
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Sauvegarder' : 'Ajouter';
    final text2 = isEditing ? 'Routeur modifié' : 'Routeur ajouté';

    return TextButton(
      child: Text(text,
        style: GoogleFonts.montserrat(
            fontSize: 15,
            color: Colors.green,
            fontWeight: FontWeight.w700
        ),
      ),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {

          DateTime datetemp1=DateTime.tryParse(DateAController.text)!;
          DateTime datetemp2;
          DateTime datetemp3;
          datetemp2=datetemp1.add(const Duration(days: 90));
          datetemp3=datetemp1.add(const Duration(days: 61));

          final Direction = DirectionController.text;
          final Fournisseur = FournisseurController.text;
          final CodeBox = CodeBoxController.text;
          final DateA = DateTime.tryParse(DateAController.text)!;
          final DateFA = datetemp2;
          final DateNO = datetemp3;
          final NumberSim = int.tryParse(NumberSimController.text) ?? 0;

          widget.onClickedDone(Direction, Fournisseur, NumberSim, CodeBox, DateA, DateFA, DateNO );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor:  Colors.green,
                content: Text(text2,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color:Colors.white,
                  ),
                )),
          );
          Navigator.of(context).pop();
        }
      },
    );
  }
}
