class SystemPlatformLoggedModel {
  final String device;
  final String model;
  final String os;
  final String osVersion;
  final String manufacturer;
  final String brand;
  final String cpuArchitecture;
  final String appVersion;
  final String buildNumber;
  final String ipAddress;

  const SystemPlatformLoggedModel({
    required this.device,
    required this.model,
    required this.os,
    required this.osVersion,
    required this.manufacturer,
    required this.brand,
    required this.cpuArchitecture,
    required this.appVersion,
    required this.buildNumber,
    required this.ipAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "device": device,
      "model": model,
      "os": os,
      "os_version": osVersion,
      "manufacturer": manufacturer,
      "brand": brand,
      "cpu_architecture": cpuArchitecture,
    };
  }
}
