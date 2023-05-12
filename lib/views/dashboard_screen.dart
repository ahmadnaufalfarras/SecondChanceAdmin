import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Articles',
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '6 Articles',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          size: 26,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Comments',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '+32 Comments',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 26,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Subscribers',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '3.2M Subscribers',
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on_outlined,
                                          size: 26,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Revenue',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '2.300\$',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '6 Articles',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '3 new Articles',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type Article Title',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.deepPurple.shade400,
                          ),
                          label: Text(
                            '2023, May 11, May 12, May 13',
                            style: TextStyle(
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            DropdownButton(
                                hint: Text('Filter by'),
                                items: [
                                  DropdownMenuItem(
                                    value: 'Date',
                                    child: Text('Date'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Comments',
                                    child: Text('Comments'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Views',
                                    child: Text('Views'),
                                  ),
                                ],
                                onChanged: (value) {}),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton(
                                hint: Text('Order by'),
                                items: [
                                  DropdownMenuItem(
                                    value: 'Date',
                                    child: Text('Date'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Comments',
                                    child: Text('Comments'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Views',
                                    child: Text('Views'),
                                  ),
                                ],
                                onChanged: (value) {}),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: [
                            DataColumn(
                              label: Text('ID'),
                            ),
                            DataColumn(
                              label: Text('Article Title'),
                            ),
                            DataColumn(
                              label: Text('Creation Date'),
                            ),
                            DataColumn(
                              label: Text('Views'),
                            ),
                            DataColumn(
                              label: Text('Comments'),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text('0')),
                                DataCell(
                                    Text('How to build a Flutter Web App')),
                                DataCell(Text('${DateTime.now()}')),
                                DataCell(Text('2.3K Views')),
                                DataCell(Text('102 Comments')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('1')),
                                DataCell(
                                    Text('How to build a Flutter Mobile App')),
                                DataCell(Text('${DateTime.now()}')),
                                DataCell(Text('21.3K Views')),
                                DataCell(Text('1020 Comments')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('2')),
                                DataCell(
                                    Text('Flutter for your first project')),
                                DataCell(Text('${DateTime.now()}')),
                                DataCell(Text('2.3M Views')),
                                DataCell(Text('10K Comments')),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '1',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '3',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   static const String routeName = '/DashboardScreen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Dashboard Screen'),
//       ),
//     );
//   }
// }
