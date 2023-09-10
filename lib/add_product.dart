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
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Product {
  final String? name;
  final String? description;
  final int price;
  final int quantity;
  final String? photo;
  final String? shop;

  Product({
    this.name,
    this.description,
    required this.price,
    required this.quantity,
    this.photo,
    this.shop,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'photo': photo,
      'shop': shop,
    };
  }
}

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? productName;
  String? productDescription;
  String? selectedPhoto;
  //List<String> priceDigits = ['0', '0', '0', '0']; // 千, 百, 十, 個
  String? quantityDigit = '0';
  String? selectedShop = "KingsChun";
  int selectedPrice = 0;
  int selectedQuantity = 0;

/*
  double get price {
    int priceValue = int.parse(priceDigits.join());
    return priceValue.toDouble();
  }
*/
/*
  double get quantity {
    return double.parse(quantityDigit ?? '0');
  }
*/

  final picker = ImagePicker();

  Future<void> _addProductToDb() async {
    final product = Product(
      name: productName,
      description: productDescription,
      price: selectedPrice,
      quantity: selectedQuantity,
      photo: selectedPhoto,
      shop: selectedShop,
    );

    final db = DatabaseHelper.instance;
    final result = await db.insert(product.toMap());

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('新增商品成功!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('新增商品失敗!')),
      );
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('拍照'),
            onTap: () async {
              final pickedFile = await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                setState(() {
                  selectedPhoto = pickedFile.path;
                });
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('從相片庫選擇'),
            onTap: () async {
              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  selectedPhoto = pickedFile.path;
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0xcf, 0xf0, 0x91, 1.0),
      appBar: AppBar(
        title: Text('新增商品'),
        backgroundColor: Color.fromRGBO(0x79, 0xbd, 0x9a, 1.0),
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
            children: [
                //
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                        _addProductToDb();
                    },
                    child: Text('新增', style: TextStyle(fontSize: 20.0)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0x98, 0xdb, 0x98, 1.0),
                    ),
                ),
                //
                TextFormField(
                onChanged: (value) => productName = value,
                decoration: InputDecoration(
                    labelText: '商品名稱',
                ),
                ),            
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('選擇照片', style: TextStyle(fontSize: 20.0)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0x98, 0xdb, 0x98, 1.0),
                    ),
                ),
                if (selectedPhoto != null) ...[
                    const SizedBox(height: 16),
                    Image.file(
                        File(selectedPhoto!),
                        width: 150,  // 您可以根據需要調整這些值
                        height: 150,
                    ),
                ],                
                const SizedBox(height: 16),
                TextFormField(
                onChanged: (value) => productDescription = value,
                decoration: InputDecoration(
                    labelText: '商品描述',
                    //contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                ),
                ),
                const SizedBox(height: 16),
                Text('選擇價格'),
                SizedBox(height: 10.0),
                Container(
                height: 150.0,
                child: CupertinoPicker(
                    itemExtent: 30.0,
                    onSelectedItemChanged: (index) {
                    setState(() {
                        selectedPrice = index;
                    });
                    },
                    children: List<Widget>.generate(
                    1001,
                    (index) => Text('\$${index.toString()}'),
                    ),
                ),
                ),
                const SizedBox(height: 16),
                    Text('選擇數量'),
                    SizedBox(height: 10.0),
                    Container(
                        height: 150.0,
                        child: CupertinoPicker(
                            itemExtent: 30.0,
                            onSelectedItemChanged: (index) {
                                setState(() {
                                    selectedQuantity = index;
                                });
                            },
                            children: List<Widget>.generate(
                                101,
                                (index) => Text('${index.toString()}'),
                            ),
                        ),
                    ),
                ],
            ),
        ),
      ),
    );
  }
}