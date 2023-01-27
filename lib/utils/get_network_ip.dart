import 'dart:io';

Future<String> getIPAddress() async {
  try {
    final List<NetworkInterface> interfaces = await NetworkInterface.list();

    for (NetworkInterface ni in interfaces) {
      for (InternetAddress address in ni.addresses) {
        if (address.isLinkLocal) {
          return address.address;
        } else {
          return address.address;
        }
      }
    }
  } on SocketException catch (_) {
    return 'Failed to get IP address';
  }
  return 'Failed to get IP address2';
}
