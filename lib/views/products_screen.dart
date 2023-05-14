import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/product_controller.dart';
import 'package:second_chance_admin/models/product_model.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '\ProductScreen';

  final ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductDataModel>>(
        stream: _productController.getProductData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductDataModel>> snapshot) {
          print(snapshot);
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.map<DataRow>((ProductDataModel productData) {
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: productData.imageUrlList.isNotEmpty
                        ? Image.network(productData.imageUrlList[0])
                        : Text('-'),
                  ),
                )),
                DataCell(Text(
                  productData.productName.isNotEmpty
                      ? productData.productName
                      : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productData.productPrice.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productData.category.isNotEmpty ? productData.category : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(productData.approved == false
                    ? ElevatedButton(
                        onPressed: () {
                          _productController
                              .approveProduct(productData.productId);
                        },
                        child: Text('Approved'))
                    : ElevatedButton(
                        onPressed: () {
                          _productController
                              .rejectProduct(productData.productId);
                        },
                        child: Text('Reject'))),
              ],
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Manage Products',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.shade200),
                    columns: const [
                      DataColumn(label: Text('IMAGE')),
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('PRODUCT PRICE')),
                      DataColumn(label: Text('CATEGORY')),
                      DataColumn(label: Text('ACTION')),
                    ],
                    rows: dataRows,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
