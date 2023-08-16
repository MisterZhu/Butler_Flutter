package com.wishare.community.smartcommunity.ui.webview.helper;

public class DefaultHandler implements BridgeHandler {
	String TAG = "DefaultHandler";

	public DefaultHandler() {
	}

	public void handler(String data, CallBackFunction function) {
		if (function != null) {
			function.onCallBack("DefaultHandler response data");
		}

	}
}
