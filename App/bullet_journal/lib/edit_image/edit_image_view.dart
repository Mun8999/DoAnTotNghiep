import 'package:bullet_journel/edit_image/image_croper.dart';
import 'package:bullet_journel/model/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditImageView extends StatefulWidget {
  @override
  _EditImageViewState createState() => _EditImageViewState();
}

double? width, height;
List<MyIcon> icons = [];

class _EditImageViewState extends State<EditImageView> {
  @override
  void initState() {
    super.initState();
    prepareIcons(icons);
  }

  @override
  Widget build(BuildContext context) {
    // icons[0] = MyIcon('fhjsf', 'assets/icons/edit/approved.png');

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
                              child: InkWell(
                                onTap: () {
                                  if (icons[index].id == 'crop') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageCroperView()));
                                  }
                                },
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ))),
    ));
  }
}

void prepareIcons(List<MyIcon> icons) {
  icons
      .add(new MyIcon('sticker', 'Dán nhãn', 'assets/icons/edit/approved.png'));
  icons.add(new MyIcon('text', 'Văn bản', 'assets/icons/edit/font.png'));
  icons.add(new MyIcon('filter', 'Bộ lộc', 'assets/icons/edit/filter.png'));
  icons.add(new MyIcon('paint', 'Vẽ', 'assets/icons/edit/paintbrush.png'));
  icons.add(new MyIcon('crop', 'Cắt ảnh', 'assets/icons/edit/crop-tool.png'));
}
