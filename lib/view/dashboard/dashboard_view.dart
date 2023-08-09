import 'package:acc_test/constants/color_constant.dart';
import 'package:acc_test/controller/dashboard_controller/dashboard_controller.dart';
import 'package:acc_test/model/dashboard_model/banner_model.dart';
import 'package:acc_test/model/dashboard_model/language_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/navigations.dart';
import 'video_player_view.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _currentIndex =0;
  final dashboard = Provider.of<DashBoardController>(NavigationService.navigatorKey.currentState!.context, listen: false);
  @override
  void initState() {
    // TODO: implement initState
    dashboard. fetchBanner();
    dashboard. fetchListData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(initialIndex: 0,length: 5, child:  Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Image.asset(
          "assets/logo.png",
          height: 40,
          width: 100,
          color: Colors.white,
        ),
        actions: [
          actionWidget()
        ],
        bottom: tabBarTitleWidget()
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
      ),
      body: TabBarView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
              imageSlider(),
              homeWidget(),

            ],),
          ),

          Center(child: Text("Originals"),),
          Center(child: Text("Movies"),),
          Center(child: Text("Videos"),),
          Center(child: Text("Music"),),
        ],
      ),

    ));
  }
  actionWidget(){
    return Row(children: [ IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      SizedBox(
        width: 5,
      ),
      IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))],);
  }
  tabBarTitleWidget(){
    return TabBar(
      isScrollable: true,
      tabs: [
        Tab(
          text: "Home",
        ),
        Tab(
          text: "Originals",
        ),
        Tab(
          text: "Movies",
        ),
        Tab(
          text: "Videos",
        ),
        Tab(
          text: "Music",
        ),
      ],
    );
  }
  homeWidget(){
    return Consumer<DashBoardController>(builder: (context, value, child) {
      if(value.getListData.statusCode == 200){
        return Column(
          children: [
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return showTimeWidget(index);
                }, separatorBuilder: (context, index) => Padding(padding: EdgeInsets.all(5),child: promotionWidget(),), itemCount:value.getListData.data!.length),
            SizedBox(),
            languageWidget(),
            SizedBox(height: 100,),
          ],
        );
      }else{
        return SizedBox();
      }

    },);

  }
  imageSlider(){
    return Consumer<DashBoardController>(builder: (context, value, child) {
      if(value.getBannerData.statusCode == 200){
        return Column(
          children: [
            SizedBox(height: 10,),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,  // Adjust the height as needed
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3), // Adjust the interval
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: true,
                aspectRatio: 16 / 5,  // Adjust the aspect ratio
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: value.getBannerData.data?.first.contentList?.map((ContentList imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Image.network(
                        imageUrl.imageUrl!,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 5,),
            Wrap(
              children: List.generate(value.getBannerData.data!.first!.contentList!.length, (index) {

                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.deepPurple : Colors.grey,
                  ),
                );
              }),
            ),

          ],
        );
      }else{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              CircularProgressIndicator()]);
      }

    },);
  }
  showTimeWidget(int index){
    return Consumer<DashBoardController>(builder: (context, value, child) {
      return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value.getListData.data![index].cardName!,style: TextStyle(color: ColorConstant.primaryThemeColor,fontSize: 15),),
                Text("See more",style: TextStyle(color: ColorConstant.textColor,fontSize: 12),),
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 10,
                children: List.generate(
                  value.getListData.data![index].contentList!.length,
                      (i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 4.5,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    value.getListData.data![index].contentList![i].imageUrl!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: CircleAvatar(
                                backgroundColor: ColorConstant.primaryThemeColor,
                                child: Image.asset(
                                  "assets/crown.png",
                                  height: 10,
                                  width: 10,
                                  color: Colors.white,
                                ),
                                radius: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(value.getListData.data![index].contentList![i].name!),
                      ],
                    );
                  },
                ),
              ),
            )


          ],),
      );
    },);
  }
  promotionWidget(){
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey.withOpacity(0.2),
        child: Image.network("https://i.pinimg.com/736x/67/6e/cb/676ecb6b2285efc0fd531383c8567a26.jpg",height: 50,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,));
  }
  languageWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Language",style: TextStyle(color: ColorConstant.primaryThemeColor,fontSize: 15),),
            Text("See more",style: TextStyle(color: ColorConstant.textColor,fontSize: 12),),
          ],
        ),
        SizedBox(height: 10,),
        Consumer<DashBoardController>(builder: (context, value, child) {
          return Wrap(

              spacing: 10,
              direction: Axis.horizontal,
              children: List.generate(value.getLangList.length, (index) {
          return Column(
            children: [
              Container(
              height:60,
              width: 60,
              decoration: BoxDecoration(
              color: ColorConstant.primaryThemeColor,
              borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text(value.getLangList[index].value!)),),
              SizedBox(height: 5,),
              Text(value.getLangList[index].name!)
            ],
          );
          }),
          );
        },)

      ],);
  }

}
