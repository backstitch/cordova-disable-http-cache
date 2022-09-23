package com.backstitch.cordova;

import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;

public class DisableHttpCachePlugin extends CordovaPlugin {
  private static final String TAG = "DisableHttpCachePlugin";

  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    Log.i(TAG, "initialize");
    super.initialize(cordova, webView);
    WebView wv = (WebView) webView.getView();
    WebSettings ws = wv.getSettings();
    CookieSyncManager.createInstance(this);
    CookieManager cookieManager = CookieManager.getInstance();
    cookieManager.setAcceptCookie(true);
    ws.setAppCacheEnabled(true);
    ws.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
  }

  @Override
  public void onStop() {
    Log.i(TAG, "onStop");
    this.webView.clearCache(true);
  }
}
