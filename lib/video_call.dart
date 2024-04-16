import 'package:agora_app/config.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: Config.appId,
      channelName: Config.channelName,
      tempToken: Config.token,
    ),
  );

  Future<void> _initAgora() async {
    await _client.initialize();
  }

  @override
  void initState() {
    _initAgora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              renderModeType: RenderModeType.renderModeHidden,
            ),
            AgoraVideoButtons(
              client: _client,
              enabledButtons: const [
                BuiltInButtons.toggleCamera,
                BuiltInButtons.callEnd,
                BuiltInButtons.toggleMic,
                BuiltInButtons.switchCamera,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//

// class VideoCall extends StatefulWidget {
//   const VideoCall({super.key});
//
//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }
//
// class _VideoCallState extends State<VideoCall> {
//
//   late Map<String, dynamic> config; // Configuration parameters
//   int localUid = -1;
//   String appId = "e8c1c92a06904338b1625daabec76665", channelName = "appdid_test";
//   List<int> remoteUids = []; // Uids of remote users in the channel
//   bool isJoined = false; // Indicates if the local user has joined the channel
//   bool isBroadcaster = true; // Client role
//   RtcEngine? agoraEngine; // Agora engine instance
//
//
//   Future<void> setupAgoraEngine() async {
//     // Retrieve or request camera and microphone permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     // Create an instance of the Agora engine
//     agoraEngine = createAgoraRtcEngine();
//     await agoraEngine!.initialize(RtcEngineContext(appId: appId));
//
//     // if (currentProduct != ProductName.voiceCalling) {
//       await agoraEngine!.enableVideo();
//     // }
//
//     // Register the event handler
//     agoraEngine!.registerEventHandler(getEventHandler());
//   }
//
//   RtcEngineEventHandler getEventHandler() {
//     return RtcEngineEventHandler(
//       // Occurs when the network connection state changes
//       onConnectionStateChanged: (RtcConnection connection,
//           ConnectionStateType state, ConnectionChangedReasonType reason) {
//         if (reason ==
//             ConnectionChangedReasonType.connectionChangedLeaveChannel) {
//           remoteUids.clear();
//           isJoined = false;
//         }
//         // Notify the UI
//         Map<String, dynamic> eventArgs = {};
//         eventArgs["connection"] = connection;
//         eventArgs["state"] = state;
//         eventArgs["reason"] = reason;
//         // eventCallback("onConnectionStateChanged", eventArgs);
//       },
//       // Occurs when a local user joins a channel
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         isJoined = true;
//         // messageCallback(
//         //     "Local user uid:${connection.localUid} joined the channel");
//         // Notify the UI
//         Map<String, dynamic> eventArgs = {};
//         eventArgs["connection"] = connection;
//         eventArgs["elapsed"] = elapsed;
//         // eventCallback("onJoinChannelSuccess", eventArgs);
//       },
//       // Occurs when a remote user joins the channel
//       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//         remoteUids.add(remoteUid);
//         // messageCallback("Remote user uid:$remoteUid joined the channel");
//         // Notify the UI
//         Map<String, dynamic> eventArgs = {};
//         eventArgs["connection"] = connection;
//         eventArgs["remoteUid"] = remoteUid;
//         eventArgs["elapsed"] = elapsed;
//         // eventCallback("onUserJoined", eventArgs);
//       },
//       // Occurs when a remote user leaves the channel
//       onUserOffline: (RtcConnection connection, int remoteUid,
//           UserOfflineReasonType reason) {
//         remoteUids.remove(remoteUid);
//         // messageCallback("Remote user uid:$remoteUid left the channel");
//         // Notify the UI
//         Map<String, dynamic> eventArgs = {};
//         eventArgs["connection"] = connection;
//         eventArgs["remoteUid"] = remoteUid;
//         eventArgs["reason"] = reason;
//         // eventCallback("onUserOffline", eventArgs);
//       },
//     );
//   }
//
//   AgoraVideoView remoteVideoView(int remoteUid) {
//     return AgoraVideoView(
//       controller: VideoViewController.remote(
//         rtcEngine: agoraEngine!,
//         canvas: VideoCanvas(uid: remoteUid),
//         connection: RtcConnection(channelId: channelName),
//       ),
//     );
//   }
//
//   AgoraVideoView localVideoView() {
//     return AgoraVideoView(
//       controller: VideoViewController(
//         rtcEngine: agoraEngine!,
//         canvas: const VideoCanvas(uid: 0), // Use uid = 0 for local view
//       ),
//     );
//   }
//
//   Future<void> leave() async {
//     // Clear saved remote Uids
//     remoteUids.clear();
//
//     // Leave the channel
//     if (agoraEngine != null) {
//       await agoraEngine!.leaveChannel();
//     }
//     isJoined = false;
//
//     // Destroy the Agora engine instance
//     destroyAgoraEngine();
//   }
//
//   void destroyAgoraEngine() {
//     // Release the RtcEngine instance to free up resources
//     if (agoraEngine != null) {
//       agoraEngine!.release();
//       agoraEngine = null;
//     }
//   }
//
// @override
//   void initState() {
//     setupAgoraEngine();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     leave();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           localVideoView(),
//           remoteVideoView(remoteUids[0]),
//         ],
//       ),
//     );
//   }
// }
