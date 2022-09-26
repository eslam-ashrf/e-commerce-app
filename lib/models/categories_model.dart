class CategoriseModel{
  bool? status;
  CategoriseDataModel? data;
  CategoriseModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    data = CategoriseDataModel.fromJson(json["data"]);

  }
}
class CategoriseDataModel{
  List<DataModel>data=[];
  int? current_page;

  CategoriseDataModel.fromJson(Map<String,dynamic>json){
    json["data"].forEach((element) {
      data.add(DataModel.fromJson(element));});
    current_page=json['current_page'];
  }

  }
  class DataModel{
    int? id;
    String?image;
    String?name;

    DataModel.fromJson(Map<String,dynamic>json){
      id=json['id'];
      image=json['image'];
      name=json['name'];
    }

  }