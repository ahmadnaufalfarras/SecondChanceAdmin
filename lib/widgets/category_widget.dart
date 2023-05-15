import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/category_controller.dart';
import 'package:second_chance_admin/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController _categoryController = CategoryController();

    return StreamBuilder<List<CategoryDataModel>>(
      stream: _categoryController.getCategoryData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryDataModel>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              final categoryData = snapshot.data![index];
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      categoryData.image,
                    ),
                  ),
                  Text(
                    categoryData.categoryName,
                  ),
                ],
              );
            });
      },
    );
  }
}
