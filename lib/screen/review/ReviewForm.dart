import 'package:flutter/material.dart';
import 'package:project_flutter/Element/General.dart';
import 'package:project_flutter/Element/Titile.dart';

List<int> text = [1, 2, 3, 4];
class ReviewFormScreen extends StatefulWidget {
  const ReviewFormScreen({Key? key}) : super(key: key);

  @override
  ReviewForm createState() => ReviewForm();
}

class ReviewForm extends State<ReviewFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleAppBar('Đánh giá sản phẩm'),
        backgroundColor: Color(0xffe59191),
      ),
      body: background(
          ListView(
            padding: EdgeInsets.all(10),
            children: [
              for (var item in text)
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 40,
                            child:Image.asset(
                              'images/camtumixrose.jpg',
                            )),
                            const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Tên sản phẩm',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                      child: TextField(decoration: InputDecoration(
                        labelText: 'Đánh giá và cảm nhận',
                        icon:Icon(Icons.reviews) ,

                      ),
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      )
                    ),
                    
                  ],
                ),
              )
            ],
          ),
          context),
    );
  }
}
