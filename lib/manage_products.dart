/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Nelson Chung
 * Creation Date: August 28, 2023
 */
 
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:io';

class ManageProductsScreen extends StatefulWidget {
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  _fetchProducts() async {
    final productsList = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      products = productsList;
    });
  }

  _deleteProduct(int id, int index) async {
    await DatabaseHelper.instance.delete(id);
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
//
          child: ListTile(
            leading: (products[index][DatabaseHelper.columnPhoto] != null)
                ? Image.file(File(products[index][DatabaseHelper.columnPhoto]))
                : Icon(Icons.image_not_supported),
            title: Text(products[index][DatabaseHelper.columnName] ?? ''),
            subtitle: Text(
              '描述: ${products[index][DatabaseHelper.columnDescription] ?? ''}\n'
              '價格: ${products[index][DatabaseHelper.columnPrice] ?? ''}\n'
              '數量: ${products[index][DatabaseHelper.columnQuantity] ?? ''}'
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteProduct(products[index][DatabaseHelper.columnId], index),
            ),
          ),
//
        );
      },
    );
  }
}
