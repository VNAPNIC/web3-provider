## Features
The project supported send and receive messages between Dapp and in-app webview “Only EIP-1193 standard supported”

## Overview

* Communicate between dapp and your app.

<img src="https://raw.githubusercontent.com/VNAPNIC/web3-provider/master/art/sequence_diagram_communication.png"/>

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

To use this library in your code :
* add a dependency in your `pubspec.yaml` :

```yaml
dependencies:
  web3_provider:
    path: ../
```
* add import in your `dart` code :
```dart
import 'package:web3_provider/web3_provider.dart';

InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  crossPlatform: InAppWebViewOptions(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    userAgent:
    "Mozilla/5.0 (Linux; Android 4.4.4; SAMSUNG-SM-N900A Build/tt) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36",
  ),
  android: AndroidInAppWebViewOptions(
    useHybridComposition: true,
    domStorageEnabled: true,
  ),
  ios: IOSInAppWebViewOptions(
    allowsInlineMediaPlayback: true,
  ),
);

/// By default config
InAppWebViewEIP1193(
    chainId: 56, // Replace your chain id network you want connect
    rpcUrl: 'https://bsc-dataseed.binance.org/', // Replace your rpc url network you want connect
    walletAddress: walletAddress,
    signCallback: (rawData, eip1193, controller) {
      // Handler callback when dapp interact with blockchain
    },
    initialUrlRequest: URLRequest(
        url: Uri.parse(
        'https://position.exchange', // Replace your dapp domain
        ),
    ),
    initialOptions: options
);

/// If you want use your provider script
/// you provide [customProvider] and [customWalletName]
```

When you pass data from dapp to your app
```dart
const args = {/* Pass data you want */};
if (window.flutter_inappwebview.callHandler) {
    window.flutter_inappwebview.callHandler('functionName', args)
        .then(function(result) {
          /// Receive data from your app
    });
}
```

And receive in your app
```dart
onWebViewCreated: (controller) {
    controller.addJavaScriptHandler(
        handlerName: 'functionName',
        callback: (args) {
          /// Receive data from dapp
          
          
          /// Send data to dapp;
          return /* anything */;
        },
    );
},
```
## License
Apache 2.0
