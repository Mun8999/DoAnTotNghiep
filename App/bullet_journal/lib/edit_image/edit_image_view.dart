import 'package:bullet_journel/model/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditImageView extends StatefulWidget {
  @override
  _EditImageViewState createState() => _EditImageViewState();
}

double width, height;
List<MyIcon> icons = [];

class _EditImageViewState extends State<EditImageView> {
  @override
  Widget build(BuildContext context) {
    // icons[0] = MyIcon('fhjsf', 'assets/icons/edit/approved.png');
    prepareIcons(icons);

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: SafeArea(
      child: LayoutBuilder(
          builder: (context, constraints) => Container(
              color: Colors.black,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth,
                      color: Colors.black,
                    ),
                    Container(
                      height: constraints.maxWidth * (4 / 3),
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/FB_IMG_1618136235995.jpg'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    //  Container(
                    //     height: constraints.maxHeight -
                    //         constraints.maxWidth * (4 / 3) -
                    //         constraints.maxHeight * 0.15,
                    Container(
                      height: constraints.maxHeight -
                          constraints.maxWidth * (4 / 3) -
                          constraints.maxHeight * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: icons.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    // child: Image(
                                    //     image: AssetImage(
                                    //   'assets/icons/edit/approved.png',
                                    // )),
                                    child: Image(
                                        image: AssetImage(
                                      icons[index].path,
                                    )),
                                  ),
                                ),
                                Text(
                                  icons[index].name,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))),
    ));
  }
}

void prepareIcons(List<MyIcon> icons) {
  icons.add(new MyIcon('Dán nhãn', 'assets/icons/edit/approved.png'));
  icons.add(new MyIcon('Văn bản', 'assets/icons/edit/font.png'));
  icons.add(new MyIcon('Bộ lộc', 'assets/icons/edit/filter.png'));
  icons.add(new MyIcon('Vẽ', 'assets/icons/edit/paintbrush.png'));
  icons.add(new MyIcon('Cắt ảnh', 'assets/icons/edit/crop-tool.png'));
}
