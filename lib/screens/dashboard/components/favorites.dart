import 'package:app/constants.dart';
import 'package:app/models/MyFiles.dart';
import 'package:app/responsive.dart';
import 'package:flutter/material.dart';

import '../../../models/Models.dart';
import 'favorite_info_card.dart';

class Favorites extends StatelessWidget {
  const Favorites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text("Favorites", style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: defaultPadding),
        Responsive(
            mobile: FavoriteInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: FavoriteInfoCardGridView(),
            desktop: FavoriteInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ))
      ],
    );
  }
}

class FavoriteInfoCardGridView extends StatelessWidget {
  const FavoriteInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userFavorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          FavoriteInfoCard(info: userFavorites[index]),
    );
  }
}
