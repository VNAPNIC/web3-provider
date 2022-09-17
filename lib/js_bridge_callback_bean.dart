import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension Web3Result on InAppWebViewController {
  void cancel(int id) {
    sendError("Canceled", id);
  }

  void sendError(String error, int id) {
    final script = "window.ethereum.sendError($id,\"$error\")";
    evaluateJavascript(source: script);
  }

  void sendResult(String result, int id) {
    final script = "window.ethereum.sendResponse($id, \"$result\")";
    evaluateJavascript(source: script);
  }

  void sendResults(List<String> results, int id) {
    final array = results
        .map((e) => e.toLowerCase())
        .toList()
        .map((e) => "\"$e\"")
        .toList();
    final arrayStr = array.join(",");
    final script = "window.ethereum.sendResponse($id, [$arrayStr])";
    evaluateJavascript(source: script);
  }

  void setAddress(String address, int id) async {
    address = address.toLowerCase();
    final script = "window.ethereum.setAddress('$address');";
    await evaluateJavascript(source: script);
    sendResults([address], id);
  }
}
