import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/entity_model.dart';
import '../models/union_model.dart';
import '../models/identity_model.dart';

class DataProvider {
  Future<List<EntityModel>> getEntities() async {
    final String response = await rootBundle.loadString('assets/data/entities.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => EntityModel.fromJson(e)).toList();
  }

  Future<List<UnionModel>> getUnions() async {
    final String response = await rootBundle.loadString('assets/data/unions.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => UnionModel.fromJson(e)).toList();
  }

  Future<List<QuestionnaireModel>> getQuestionnaires() async {
    final String response = await rootBundle.loadString('assets/data/identity.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((e) => QuestionnaireModel.fromJson(e)).toList();
  }
}
