import 'package:datasource_client/datasource_client.dart';
import 'package:notification_repository/src/extensions.dart';
import 'package:notification_repository/src/models/device_data.dart';
import 'package:notification_repository/src/typedefs.dart';

import '../endpoints.dart';
import 'i_device_data_repository.dart';

class DeviceDataRepositoryImpl implements DeviceDataRepository {
  final ApiClient _apiClient;

  const DeviceDataRepositoryImpl(this._apiClient);

  @override
  Future<void> deleteDeviceData(int personId) => _apiClient.deleteData(
      endpoint: Endpoints.deleteDeviceData(personId), converter: (response) {});

  @override
  RepoResponse<DeviceData> getDeviceDataById(int deviceDataId) =>
      _apiClient.fetchData(
          endpoint: Endpoints.getDeviceDataById(deviceDataId),
          converter: DeviceData.fromJson);

  @override
  RepoResponse<List<DeviceData>> getDeviceDataByPersonId(int personId) =>
      _apiClient.fetchCollectionData(
          endpoint: Endpoints.getDeviceDataByPersonId(personId),
          converter: DeviceData.fromJson);

  @override
  RepoResponse<List<DeviceData>> getFcmTokenDataByPersonId(int personId) =>
      _apiClient.fetchCollectionData(
          endpoint: Endpoints.getFCMTokensByPersonId(personId),
          converter: DeviceData.fromJson);

  @override
  RepoResponse<DeviceData> postDeviceData(DeviceData deviceData) =>
      _apiClient.postData(
          endpoint: Endpoints.notificationBase,
          data: deviceData.toJson(),
          converter: DeviceData.fromJson);

  @override
  RepoResponse<DeviceData> updateDeviceData(DeviceData deviceData) =>
      _apiClient.updateData(
          endpoint: Endpoints.notificationBase,
          data: deviceData.toJson(),
          converter: DeviceData.fromJson);
}
