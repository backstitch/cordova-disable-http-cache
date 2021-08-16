#import "DisableHttpCachePlugin.h"

@implementation DisableHttpCachePlugin

- (void)pluginInitialize {
  NSLog(@"DisableHttpCachePlugin: initialize");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];

  // We need this to enable the onPause hook
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPause) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (DisableHttpCachePlugin*)initWithWebView:(WKWebView*)theWebView {
  return self;
}

- (void)onAppTerminate
{
  NSLog(@"DisableHttpCachePlugin: onAppTerminate");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSSet *dataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                             WKWebsiteDataTypeOfflineWebApplicationCache,
                                             WKWebsiteDataTypeMemoryCache,
                                             WKWebsiteDataTypeCookies,
                                             WKWebsiteDataTypeSessionStorage,
                                             WKWebsiteDataTypeIndexedDBDatabases,
                                             WKWebsiteDataTypeWebSQLDatabases
    ]];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataTypes
                                             modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                         completionHandler:^{
          }];

    // ONLY delete the files in the NetworkCache folder for WebKit
    // This replaces the WKWebsiteDataTypeLocalStorage flag since that also logs out the user
    NSFileManager *fm = [NSFileManager defaultManager];

    // NSHomeDirectory() is something like /var/mobile/Containers/Data/Application/42DEC198-3D99-4A74-B21D-A87F001512BA
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/WebKit/NetworkCache"];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error]) {
        NSLog(@"Directory: %@; File: %@", directory, file);
        BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@", directory] error:&error];
        if (!success || error) {
            NSLog (@"Remove failed");
        }else {
            NSLog (@"Remove successful");
        }
    }
}


- (void)onPause
{
    NSLog(@"DisableHttpCachePlugin: onPause");
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
      NSSet *dataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                               WKWebsiteDataTypeOfflineWebApplicationCache,
                                               WKWebsiteDataTypeMemoryCache,
                                               WKWebsiteDataTypeCookies,
                                               WKWebsiteDataTypeSessionStorage,
                                               WKWebsiteDataTypeIndexedDBDatabases,
                                               WKWebsiteDataTypeWebSQLDatabases
      ]];
      [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataTypes
                                               modifiedSince:[NSDate dateWithTimeIntervalSince1970:0]
                                           completionHandler:^{
            }];
    
    // ONLY delete the files in the NetworkCache folder for WebKit
    // This replaces the WKWebsiteDataTypeLocalStorage flag since that also logs out the user
    NSFileManager *fm = [NSFileManager defaultManager];

    // NSHomeDirectory() is something like /var/mobile/Containers/Data/Application/42DEC198-3D99-4A74-B21D-A87F001512BA
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/WebKit/NetworkCache"];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error]) {
        NSLog(@"Directory: %@; File: %@", directory, file);
        BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@", directory] error:&error];
        if (!success || error) {
            NSLog (@"Remove failed");
        }else {
            NSLog (@"Remove successful");
        }
    }
}

@end
