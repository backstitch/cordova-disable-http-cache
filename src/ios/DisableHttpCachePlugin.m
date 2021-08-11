#import "DisableHttpCachePlugin.h"

@implementation DisableHttpCachePlugin

- (void)pluginInitialize {
  NSLog(@"DisableHttpCachePlugin: initialize");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
}

- (DisableHttpCachePlugin*)initWithWebView:(UIWebView*)theWebView {
  return self;
}

- (void)onAppTerminate
{
  NSLog(@"DisableHttpCachePlugin: onAppTerminate");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)onReset
{
  NSLog(@"DisableHttpCachePlugin: onReset");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)dispose
{
  NSLog(@"DisableHttpCachePlugin: dispose");
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];
  [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
