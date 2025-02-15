import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/app_sank_bar.dart';
import '../../../index.dart';

class WifiProvision extends StatefulWidget {
  const WifiProvision({super.key});

  @override
  State<WifiProvision> createState() => _WifiProvisionState();
}

class _WifiProvisionState extends State<WifiProvision> {
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WifiProvisingBloc>().add(WifiProvisingInitialFethingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ESP32 BLE Provisioning")),
      body: BlocConsumer<WifiProvisingBloc, WifiProvisingState>(
        listener: (context, state) {
          if (state is WifiProvisingScanningPopUpState) {
            getAppSankBar(context: context, message: "Scanning Device");
          } else if (state is WifiProvisingStatusPopupState) {
            getAppSankBar(context: context, message: state.status);
          } else if (state is WifiProvisingErrorPopUpState) {
            getAppSankBar(context: context, message: state.error);
          }
        },
        buildWhen: (previous, current) => current is! WifiProvisingActionState,
        listenWhen: (previous, current) => current is WifiProvisingActionState,
        builder: (context, state) {
          if (state is WifiProvisingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WifiProvisingErrorState) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          } else if (state is WifiProvisingSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Scan & Connect to ESP32:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.devicesList.length,
                      itemBuilder: (context, index) {
                        final device = state.devicesList[index].device;
                        return ListTile(
                          tileColor: device.isConnected ? Colors.green : null,
                          title: Text(device.advName),
                          subtitle: Text(device.remoteId.toString()),
                          onTap: () => context.read<WifiProvisingBloc>().add(
                              WifiProvisingConnectToDeviceEvent(
                                  bluetoothDevice:
                                      state.devicesList[index].device)),
                        );
                      },
                    ),
                  ),
                  state.connectedDevice != null
                      ? buildWifiProvisingForm()
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            context
                .read<WifiProvisingBloc>()
                .add(WifiProvisingScannDevicesEvent());
          },
          icon: Icon(Icons.bluetooth_searching)),
    );
  }

  buildWifiProvisingForm() {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextField(
            controller: ssidController,
            decoration: const InputDecoration(labelText: "Wi-Fi SSID")),
        TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Wi-Fi Password")),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            context.read<WifiProvisingBloc>().add(
                WifiProvisingSendWifiProvisingEvent(
                    ssid: ssidController.text,
                    password: passwordController.text));
          },
          child: const Text("Send Credentials"),
        ),
      ],
    );
  }
}
