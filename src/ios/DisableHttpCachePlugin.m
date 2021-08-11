#import "DisableHttpCachePlugin.h"

@implementation DisableHttpCachePlugin

- (void)pluginInitialize {
  NSLog(@"DisableHttpCachePlugin: initialize");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];

  // We need this so that we can utilize the onPause hook
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPause) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (DisableHttpCachePlugin*)initWithWebView:(UIWebView*)theWebView {
  return self;
}

- (void)onAppTerminate {
  NSLog(@"DisableHttpCachePlugin: onAppTerminate");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSSet *dataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                        WKWebsiteDataTypeMemoryCache,
                        WKWebsiteDataTypeDiskCache,
                        WKWebsiteDataTypeOfflineWebApplicationCache,
                        WKWebsiteDataTypeMemoryCache,
                        WKWebsiteDataTypeLocalStorage,
                        WKWebsiteDataTypeCookies,
                        WKWebsiteDataTypeSessionStorage,
                        WKWebsiteDataTypeIndexedDBDatabases,
                        WKWebsiteDataTypeWebSQLDatabases
    ]];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataTypes
                                             modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                         completionHandler:^{}
                                         ];
}

- (void)onPause {
  NSLog(@"DisableHttpCachePlugin: onPause");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSSet *dataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                        WKWebsiteDataTypeMemoryCache,
                        WKWebsiteDataTypeDiskCache,
                        WKWebsiteDataTypeOfflineWebApplicationCache,
                        WKWebsiteDataTypeMemoryCache,
                        WKWebsiteDataTypeSessionStorage,
                        WKWebsiteDataTypeIndexedDBDatabases,
                        WKWebsiteDataTypeWebSQLDatabases
    ]];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataTypes
                                             modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                         completionHandler:^{}
                                         ];
}

@end
