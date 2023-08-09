import 'package:acc_test/model/dashboard_model/banner_model.dart';
import 'package:acc_test/model/dashboard_model/language_model.dart';
import 'package:acc_test/service/dashboard_sc/dashboard_sc.dart';
import 'package:flutter/cupertino.dart';

import '../../model/dashboard_model/list_model.dart';

class DashBoardController extends ChangeNotifier{

  DashBoardSC dashBoardSC = DashBoardSC();

  BannerModel bannerData = BannerModel();
  BannerModel get getBannerData => bannerData;
  set setBannerData(BannerModel val){
    bannerData = val;
    notifyListeners();
  }
  fetchBanner()async{
    try{
      setBannerData = await dashBoardSC.bannerSC();
    }catch(e){
      throw e;
    }

  }

  ListModel listData = ListModel();
  ListModel get getListData => listData;
  set setListData(ListModel val){
    listData = val;
    notifyListeners();
  }
  fetchListData()async{
    try{
      setListData = await dashBoardSC.listSC();
    }catch(e){
      throw e;
    }

  }

  List<LanguageModel> langList = <LanguageModel>[LanguageModel(name: "Hindi",value: "अ"),LanguageModel(name: "Gujarati",value: "અ"),LanguageModel(name: "English",value: "A"),LanguageModel(name: "Kannada",value: "ಅ"),LanguageModel(name: "Bengali",value: "অ")];
  List<LanguageModel> get getLangList =>langList;

}