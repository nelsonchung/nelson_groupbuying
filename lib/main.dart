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
import 'customer_order.dart';
import 'boss_mode.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // 新增這行導入

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nelson Group Buy App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> deleteDatabaseFile(BuildContext context) async {
    String documentsDirectory = await getDatabasesPath();
    String dbPath = join(documentsDirectory, 'orders.db');
    if (await File(dbPath).exists()) {
      await File(dbPath).delete();
      print('Database file deleted.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('資料庫已清除'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('Database file does not exist.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('資料庫不存在'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0xcf, 0xf0, 0x91, 1.0), // #FFE3AB 的 RGB 比例
          image: DecorationImage(
            image: AssetImage('assets/background.jepg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerOrderScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0x98, 0xdb, 0x98, 1.0), // #FFE300 的 RGB 比例
                    minimumSize: const Size(320, 88),
                  ),
                  child: const Text(
                    '顧客模式',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BossModeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0x98, 0xdb, 0x98, 1.0), // #FFE300 的 RGB 比例
                    minimumSize: const Size(320, 88),
                  ),
                  child: const Text(
                    '老闆模式',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await deleteDatabaseFile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('清除資料庫'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
