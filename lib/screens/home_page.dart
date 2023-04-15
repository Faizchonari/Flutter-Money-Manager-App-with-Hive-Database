import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/database/catecory_database.dart';
import 'package:money_manager/model/transacion_model/transacion_model.dart';
import 'add_transacion.dart';
import '../constants.dart';
import '../model/catecory_model/catecory_model.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = const Color(0xff1c1c1e);

  final Color secondaryColor = const Color(0xff8e8e93);

  final Color accentColor = const Color(0xff007aff);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: accentColor,
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeft,
              childCurrent: widget,
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 400),
              child: const AddTrasacionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Money manager",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder<Box<TransacionModel>>(
        valueListenable: TransacionDB.getTransacion().listenable(),
        builder: (context, box, child) {
          final transacion = box.values.toList().cast<TransacionModel>();
          double totalIncome = 0;
          double totalExpense = 0;

          for (var t in transacion) {
            if (t.model.type == CategoryType.income) {
              totalIncome += t.amount;
            } else {
              totalExpense += t.amount;
            }
          }
          double netAmount = totalIncome - totalExpense;
          return Center(
            child: Column(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    shadowLightColorEmboss: blackgradiant,
                    shape: NeumorphicShape.convex,
                    border: const NeumorphicBorder.none(),
                    depth: 3,
                    oppositeShadowLightSource: true,
                    color: Colors.transparent,
                    intensity: 0.4,
                    lightSource: LightSource.bottomRight,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child:
                      amountCard(context, netAmount, totalIncome, totalExpense),
                ),
                transacion.isEmpty
                    ? Expanded(
                        child: SizedBox(
                        width: 350,
                        child: Opacity(
                            opacity: 0.6,
                            child: Lottie.asset('images/empty.json',
                                fit: BoxFit.contain)),
                      ))
                    : listTile(transacion)
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded listTile(List<TransacionModel> transacion) {
    return Expanded(
      child: ListView.builder(
        itemCount: transacion.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: blackgradiant,
              child: const FaIcon(
                FontAwesomeIcons.circleDollarToSlot,
                size: 30,
              ),
            ),
            title: Text(
              transacion[index].model.categoryName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              DateFormat.MMMMEEEEd().format(transacion[index].date),
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(
              transacion[index].amount.toStringAsFixed(2),
              style: const TextStyle(color: Colors.white),
            ),
            children: [
              tileButton(context, transacion, index),
            ],
          );
        },
      ),
    );
  }

  Container amountCard(BuildContext context, double netAmount,
      double totalIncome, double totalExpense) {
    return Container(
      color: blackgradiant,
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NeumorphicText(
            'B A L A N C E',
            style: const NeumorphicStyle(
                depth: 7, intensity: 0.5, lightSource: LightSource.bottom),
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\$$netAmount',
            style: TextStyle(
                fontSize: 25,
                color: netAmount >= 0 ? Colors.green : Colors.red),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              amountInticater(
                total: totalIncome,
                title: 'I n c o m e\n',
                iconcolor: Colors.green,
                icon: const Icon(
                  FontAwesomeIcons.arrowUp,
                  color: Colors.green,
                ),
              ),
              amountInticater(
                total: totalExpense,
                title: 'E x p e n s e\n',
                iconcolor: Colors.red,
                icon: const Icon(
                  FontAwesomeIcons.arrowDown,
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row amountInticater({
    required double total,
    required Color iconcolor,
    required String title,
    required Icon icon,
  }) {
    return Row(
      children: [
        Neumorphic(
          padding: const EdgeInsets.all(12),
          style: NeumorphicStyle(
            border: const NeumorphicBorder(isEnabled: true),
            shape: NeumorphicShape.convex,
            boxShape: const NeumorphicBoxShape.circle(),
            depth: 7,
            color: Colors.grey.shade300,
            intensity: 0.5,
            lightSource: LightSource.topLeft,
          ),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text: total.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 15,
                              color: iconcolor,
                              fontWeight: FontWeight.bold))
                    ]),
              )
            ],
          ),
        )
      ],
    );
  }

  Row tileButton(
      BuildContext context, List<TransacionModel> transacion, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => transacion[index].delete(),
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff1c1c1e),
            onPrimary: const Color(0xff8e8e93),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
