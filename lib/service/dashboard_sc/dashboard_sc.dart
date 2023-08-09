import 'package:acc_test/model/dashboard_model/list_model.dart';
import 'package:dio/dio.dart';

import '../../model/dashboard_model/banner_model.dart';

class DashBoardSC{

  Future<BannerModel> bannerSC()async{
    try{
      Dio dio = Dio();
      final response = await dio.get("https://mocki.io/v1/783f8c69-af91-45ff-87df-e675c3f11fef");
      print(response.data);
      return BannerModel.fromJson(response.data);
    }on DioError catch(e){
      throw e;
    }
  }
  Future<ListModel> listSC()async{
    try{
      Dio dio = Dio();
      final response = await dio.get("https://mocki.io/v1/cead1ab5-8153-4557-a587-f6ebb2710769");
      print(response.data);
      return ListModel.fromJson(response.data);
    }on DioError catch(e){
      throw e;
    }
  }
}