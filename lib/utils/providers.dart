import 'package:acc_test/controller/dashboard_controller/dashboard_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: DashBoardController(),),


];