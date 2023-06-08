import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_chance_admin/controllers/product_controller.dart';
import 'package:second_chance_admin/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '\ProductScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _productController = ProductController();

  int _currentPage = 1;
  int _maxPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductDataModel>>(
        stream: _productController.getProductData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final sortedData = List<ProductDataModel>.from(snapshot.data!);
          sortedData
              .sort((a, b) => b.productAddedDate.compareTo(a.productAddedDate));

          final totalItems = sortedData.length;
          final maxPages = (totalItems / _maxPerPage).ceil();
          final startIndex = (_currentPage - 1) * _maxPerPage;
          final endIndex = startIndex + _maxPerPage;
          final displayedData = sortedData.sublist(
              startIndex.clamp(0, totalItems), endIndex.clamp(0, totalItems));

          final dataRows =
              displayedData.map<DataRow>((ProductDataModel productData) {
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: productData.imageUrlList.isNotEmpty
                      ? Container(
                          height: 50,
                          width: 50,
                          child: Image.network(productData.imageUrlList[0]))
                      : Text(
                          'No Image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                )),
                DataCell(Text(
                    DateFormat('dd MMM yyyy hh:mm a').format(
                      productData.productAddedDate.toDate(),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                  productData.productName.isNotEmpty
                      ? productData.productName
                      : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  '${NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(productData.productPrice)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productData.category.isNotEmpty ? productData.category : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productData.approved == false ? 'Unpublished' : 'Published',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
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
                          DataColumn(label: Text('ADDED DATE')),
                          DataColumn(label: Text('PRODUCT NAME')),
                          DataColumn(label: Text('PRODUCT PRICE')),
                          DataColumn(label: Text('CATEGORY')),
                          DataColumn(label: Text('STATUS')),
                        ],
                        rows: dataRows,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: _currentPage > 1
                              ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                          'Page $_currentPage of $maxPages',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: _currentPage < maxPages
                              ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ]));
        },
      ),
    );
  }
}
