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

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? productName;
  String? productDescription;
  String? selectedPhoto;
  List<String> price = ['0', '0', '0', '0'];  // 千, 百, 十, 個
  String? quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增商品'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              onChanged: (value) => productName = value,
              decoration: InputDecoration(
                labelText: '商品名稱',
              ),
            ),            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement image picker functionality
              },
              child: Text('選擇照片'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              onChanged: (value) => productDescription = value,
              decoration: InputDecoration(
                labelText: '商品描述',
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('價錢: ${price.join()}'),  // 顯示價錢
            ),
            Row(
              children: List.generate(4, (index) {
                return DropdownButton<String>(
                  value: price[index],
                  items: List.generate(10, (number) {
                    return DropdownMenuItem(
                      value: number.toString(),
                      child: Text(number.toString()),
                    );
                  }),
                  onChanged: (newValue) {
                    setState(() {
                      price[index] = newValue!;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('數量: $quantity'),  // 顯示數量
            ),
            DropdownButton<String>(
              value: quantity,
              items: List.generate(10, (number) {
                return DropdownMenuItem(
                  value: number.toString(),
                  child: Text(number.toString()),
                );
              }),
              onChanged: (newValue) {
                setState(() {
                  quantity = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
