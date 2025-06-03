import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/custom_appbar.dart';

class Cabinet extends StatelessWidget {
  const Cabinet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            Image.asset('assets/logo/img.png', width: 200, height: 200),

            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 1, // Chiziqning qalinligi
                    color: Colors.grey, // Chiziqning rangi
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                    ), // Vertikal va gorizontal bo'sh joy
                  ),

                  Text(
                    'OneDesk',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSubItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[700],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
