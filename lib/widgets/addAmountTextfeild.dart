import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class AmountTextfeild extends StatelessWidget {
  const AmountTextfeild({
    super.key,
    required this.amountController,
  });

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: blackgradiant,
          child: const FaIcon(
            FontAwesomeIcons.circleDollarToSlot,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            color: blackgradiant,
            intensity: 0.5,
            depth: 3,
            shape: NeumorphicShape.convex,
            lightSource: LightSource.bottomRight,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white54, width: 6)),
                  hintStyle: const TextStyle(color: Colors.white54),
                  hintText: 'Enter amount'),
              controller: amountController,
              style: const TextStyle(color: Color(0xffffffff)),
            ),
          ),
        ),
      ],
    );
  }
}
