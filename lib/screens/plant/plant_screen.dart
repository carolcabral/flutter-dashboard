import 'package:app/constants.dart';
import 'package:app/models/Models.dart';
import 'package:app/screens/components/status_details.dart';
import 'package:flutter/material.dart';

import 'components/devices_card.dart';

class PlantPage extends StatelessWidget {
  final String? name;

  const PlantPage({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name!,
          //style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(children: [
            const StatusDetails(title: "Plant"),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              "Devices",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(defaultPadding),
                itemCount: userDevices.length,
                itemBuilder: (context, index) =>
                    DevicesCard(info: userDevices[index])),
          ]),
        ),
      ),
    );
  }
}
