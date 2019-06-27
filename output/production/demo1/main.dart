import 'package:flutter/material.dart';
import 'package:demo1/HomePage.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new LayoutDemo(),
    );
  }
}


class LayoutDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      //ͷ��Ԫ�� ���磺��෵�ذ�ť �м���� �Ҳ�˵�
      appBar: AppBar(
        title: Text('Scaffold-show'),
      ),
      //��ͼ���ݲ���
      body: Center(
        child: Text('Scaffold'),
      ),
      //�ײ�������
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50.0,),
      ),
      //���FAB��ť
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
      //FAB��ť����չʾ
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}



