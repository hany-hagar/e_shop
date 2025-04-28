
import 'dart:convert';

import 'data_model.dart';


String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    HomeModel({
        required this.data,
        required this.status,
    });

    DataModel data;
    bool status;


    factory HomeModel.fromJson(Map<dynamic, dynamic> json ) => HomeModel(
        data: DataModel.fromJson(json["data"]),
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}




