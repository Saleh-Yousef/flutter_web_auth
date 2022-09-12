import '../constants/api_constants.dart';
import '../models/universities_model.dart';
import '../repo/Dio_service/dio_service.dart';
import '../utils/mixin.dart';

class HomeScreenService with Service {
  Future<List<University>?> getUniversities({required String? country}) async {
    final response =
        await repository!.callRequest(requestType: RequestType.GET, methodName: ApiConstants.getUniversitiesAPI + country!) as List<dynamic>;
    var univirityList = response.map((e) => University.fromJson(e)).toList();

    return univirityList;
  }
}
