import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task.dart';

class SharedPrefService {
  static Future<bool> setToDoList(List<TaskModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("ToDo_List", "");
    final String encodedData = TaskModel.encode(list);
    prefs.setString("ToDo_List", encodedData);
    return true;
  }

  static Future<List<TaskModel>> getToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("ToDo_List")) {
      prefs.setString("ToDo_List", "");
    }
    final String? dataString = prefs.getString('ToDo_List');
    List<TaskModel> templist = [];
    if (dataString != null && dataString.isNotEmpty) {
      templist = TaskModel.decode(dataString);
    }
    return templist;
  }
}
