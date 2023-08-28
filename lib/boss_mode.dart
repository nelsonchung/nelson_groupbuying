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
import 'view_orders.dart';
import 'manage_products.dart';
import 'view_sales.dart';
import 'add_product.dart';

class BossModeScreen extends StatefulWidget {
  const BossModeScreen({Key? key}) : super(key: key);

  @override
  _BossModeScreenState createState() => _BossModeScreenState();
}

class _BossModeScreenState extends State<BossModeScreen> {
  int _selectedIndex = 0;
  Widget _selectedPage = ViewOrdersScreen();  // 定義_selectedPage 變量

  static List<Widget> _widgetOptions = <Widget>[
    ViewOrdersScreen(),
    ManageProductsScreen(),
    ViewSalesScreen(),
    AddProductScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = _widgetOptions[index];  // 更新_selectedPage 的值
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text('老闆模式'),
      ),
      */
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,  // 新增這一行
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: '查看所有訂單',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: '管理商品',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '查看銷售紀錄',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '新增商品',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}