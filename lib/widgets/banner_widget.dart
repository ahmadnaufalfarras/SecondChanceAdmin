import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/banner_controller.dart';
import 'package:second_chance_admin/models/banner_model.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController _bannerController = BannerController();

    return StreamBuilder<List<BannerDataModel>>(
      stream: _bannerController.getBannerData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<BannerDataModel>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            final bannerData = snapshot.data![index];
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    bannerData.image,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
