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

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.2),
            itemBuilder: (context, index) {
              final bannerData = snapshot.data![index];
              return Card(
                elevation: 2, // Mengatur elevasi kartu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Mengatur sudut melengkung kartu
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Image.network(
                            bannerData.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _bannerController.deleteBanner(bannerData.bannerId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                        ),
                        child: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
