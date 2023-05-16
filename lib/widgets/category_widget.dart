import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/category_controller.dart';
import 'package:second_chance_admin/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

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

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Mengubah jumlah kolom menjadi 2
              mainAxisSpacing: 20, // Mengatur jarak vertikal antara item
              crossAxisSpacing: 20, // Mengatur jarak horizontal antara item
              childAspectRatio: 1.0, // Mengatur perbandingan lebar-tinggi item
            ),
            itemBuilder: (context, index) {
              final categoryData = snapshot.data![index];
              return Card(
                elevation: 4, // Mengatur elevasi kartu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Mengatur sudut melengkung kartu
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 200,
                        width: 250,
                        child: Image.network(
                          categoryData.image,
                          fit: BoxFit.cover, // Mengatur tipe pemadatan gambar
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      categoryData.categoryName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Category'),
                              content: Text(
                                  'Are you sure you want to delete ${categoryData.categoryName}?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () async {
                                    try {
                                      await _categoryController.deleteCategory(
                                          categoryData.categoryId);
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'Failed to delete category. Please try again later.'),
                                            actions: [
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                      ),
                      child: Text('Delete'),
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
