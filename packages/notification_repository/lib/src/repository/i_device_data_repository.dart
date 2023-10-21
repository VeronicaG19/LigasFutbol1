import '../models/device_data.dart';
import '../typedefs.dart';

abstract class DeviceDataRepository {
  RepoResponse<DeviceData> postDeviceData(DeviceData deviceData);
  RepoResponse<DeviceData> updateDeviceData(DeviceData deviceData);
  RepoResponse<DeviceData> getDeviceDataById(int deviceDataId);
  Future<void> deleteDeviceData(int personId);
  RepoResponse<List<DeviceData>> getDeviceDataByPersonId(int personId);
  RepoResponse<List<DeviceData>> getFcmTokenDataByPersonId(int personId);
}
