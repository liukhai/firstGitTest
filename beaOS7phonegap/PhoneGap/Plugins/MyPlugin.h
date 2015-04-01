/********* Echo.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>

@interface MyPlugin : CDVPlugin

- (void)echo:(CDVInvokedUrlCommand*)command;

@end