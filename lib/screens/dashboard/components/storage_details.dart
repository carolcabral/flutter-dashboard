import 'package:dashboard/constants.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Storage Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            title: "Document Files",
            amountOfFiles: "1.3GB",
            numOfFiles: 1329,
            svgSrc: "assets/icons/Documents.svg",
          ),
          StorageInfoCard(
            title: "Media Files",
            amountOfFiles: "1.3GB",
            numOfFiles: 1329,
            svgSrc: "assets/icons/media.svg",
          ),
          StorageInfoCard(
            title: "Other Files",
            amountOfFiles: "1.3GB",
            numOfFiles: 1329,
            svgSrc: "assets/icons/folder.svg",
          ),
          StorageInfoCard(
            title: "Unknown",
            amountOfFiles: "1.3GB",
            numOfFiles: 1329,
            svgSrc: "assets/icons/unknown.svg",
          ),
        ],
      ),
    );
  }
}
