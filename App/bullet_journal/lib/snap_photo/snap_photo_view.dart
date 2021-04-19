import 'package:bullet_journel/snap_photo/snap_photo_viewmodel.dart';
import 'package:flutter/material.dart';

class SnapPhotoView extends StatefulWidget {
  @override
  _SnapPhotoViewState createState() => _SnapPhotoViewState();
}

double selected = 0;
List<BlendMode> blendModes = [];
SnapPhotoViewModel editImageViewModel = SnapPhotoViewModel();

class _SnapPhotoViewState extends State<SnapPhotoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    prepareFilter(blendModes);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black)),
            child: Text(
              '3:4',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_rounded,
                size: 30,
                color: Colors.black,
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              StreamBuilder<BlendMode>(
                  stream: editImageViewModel.filterImageStream,
                  builder: (context, blendMode) {
                    // print(blendMode.data);
                    return StreamBuilder<double>(
                        stream: editImageViewModel.sliderStream,
                        builder: (context, slider) {
                          return Container(
                            height: width * (4 / 3),
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/FB_IMG_1618136235995.jpg'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      slider.hasData
                                          ? Colors.white54
                                              .withOpacity(slider.data * 0.01)
                                          : Colors.white.withOpacity(0),
                                      blendMode.data,
                                    ))),
                          );
                        });
                  }),
              Container(
                height: 40,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    valueIndicatorColor: Colors.red,
                  ),
                  child: Slider(
                    min: 0,
                    max: 100,
                    activeColor: Colors.red,
                    inactiveColor: Colors.red[50],
                    value: selected,
                    label: selected.round().toString(),
                    divisions: 100,
                    onChanged: (double value) {
                      setState(() {
                        selected = value;
                        editImageViewModel.changeValueOfSliderEvent(value);
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(left: 5, right: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: blendModes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        editImageViewModel.changeFilterEvent(blendModes[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/FB_IMG_1618136235995.jpg'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.purple.withOpacity(0.06),
                                        blendModes[index],
                                      ))),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 100,
                                height: 25,
                                color: const Color(0xFF8000FF).withOpacity(0.5),
                                child: Center(
                                  child: Text(
                                    blendModes[index]
                                        .toString()
                                        .split('.')[1]
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.2)),
                    child: MaterialButton(
                      // color: Colors.red,
                      onPressed: () {},
                      shape: CircleBorder(),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: MaterialButton(
                        // color: Colors.red,
                        onPressed: () {},
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void prepareFilter(List<BlendMode> blendModes) {
  blendModes.addAll(BlendMode.values);
  blendModes.remove(BlendMode.clear);
  blendModes.remove(BlendMode.src);
  blendModes.remove(BlendMode.srcIn);
  blendModes.remove(BlendMode.srcOut);
  blendModes.remove(BlendMode.difference);
  blendModes.remove(BlendMode.exclusion);
}
