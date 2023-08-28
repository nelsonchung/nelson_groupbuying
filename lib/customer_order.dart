
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

//UI design by reference from https://www.figma.com/file/6wVChfTNXHAZ7ZPQxngo8a/Grocery-Mobile-apps-Design-Community?type=design&is-community-duplicate=1&fuid=

class CustomerOrderScreen extends StatelessWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('顧客模式'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to view products
              },
              child: Text('查看商品'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to submit order
              },
              child: Text('提交訂單'),
            ),
          ],
        ),
      ),
    );
  }
}
