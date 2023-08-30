import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';

class Product {
  final String? name;
  final String? description;
  final double price;
  final double quantity;
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
  List<String> priceDigits = ['0', '0', '0', '0']; // 千, 百, 十, 個
  String? quantityDigit = '0';
  String? selectedShop;

  double get price {
    int priceValue = int.parse(priceDigits.join());
    return priceValue.toDouble();
  }

  double get quantity {
    return double.parse(quantityDigit ?? '0');
  }

  final picker = ImagePicker();

  Future<void> _addProductToDb() async {
    final product = Product(
      name: productName,
      description: productDescription,
      price: price,
      quantity: quantity,
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
              final pickedFile = await picker.getImage(source: ImageSource.camera);
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
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
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
                onPressed: _pickImage,
                child: Text('選擇照片', style: TextStyle(fontSize: 20.0)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0x98, 0xdb, 0x98, 1.0),
                ),
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
              child: Text('價錢: ${priceDigits.join()}'),  // 顯示價錢

            ),
            Row(
              children: List.generate(4, (index) {
                return DropdownButton<String>(
                  value: priceDigits[index],
                  items: List.generate(10, (number) {
                    return DropdownMenuItem(
                      value: number.toString(),
                      child: Text(number.toString()),
                    );
                  }),
                  onChanged: (newValue) {
                    setState(() {
                      priceDigits[index] = newValue!;
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
              value: quantityDigit,
              items: List.generate(10, (number) {
                return DropdownMenuItem(
                  value: number.toString(),
                  child: Text(number.toString()),
                );
              }),
              onChanged: (newValue) {
                setState(() {
                  quantityDigit = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}