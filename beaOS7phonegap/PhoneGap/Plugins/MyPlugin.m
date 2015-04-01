/********* Echo.m Cordova Plugin Implementation *******/

#import "MyPlugin.h"
#import <Cordova/CDV.h>
#import "MyUtil.h"
#import "CoreData.h"
#import "OpenUDID.h"
@implementation MyPlugin

- (void)echo:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) nativeFunction:(CDVInvokedUrlCommand*)command
{
    //get the callback id
    NSString *callbackId = command.callbackId;
    NSString *resultType = [command.arguments objectAtIndex:0];
    CDVPluginResult *pluginResult;
    NSLog(@"native nativeFunction:%@--%@", callbackId, resultType);
    if ([resultType isEqualToString:@"getPhoneNum"]) {
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: [[MyUtil me] do_getPhoneNumbers]];
//        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    } else if ([resultType isEqualToString:@"gotoMBK"]) {
        [[MyUtil me] do_gotoMBK];
    } else if ([resultType isEqualToString:@"print"]) {
        [[MyUtil me] do_print_pdf];
        [[MyUtil me] showPDFOnScreen];
    } else if ([resultType isEqualToString:@"screencap"]) {
        [[MyUtil me] showScreenCaptureOnScreen];
    }
    
}

- (void) nativeFunction2:(CDVInvokedUrlCommand*)command
{
    //get the callback id
    NSString *callbackId = command.callbackId;
    NSString *resultType = [command.arguments objectAtIndex:0];
    NSLog(@"native nativeFunction2:%@--%@", callbackId, resultType);
    //    [[MyUtil me] do_getNameByMobileNo:resultType];
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: [[MyUtil me] do_getNameByMobileNo:resultType]];
    [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

- (void)showP2PSettingPage:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* _url = [command.arguments objectAtIndex:0];
    
    if (_url != nil && [_url length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:_url];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
     [[CoreData sharedCoreData].sP2PMenuViewController setSettingURL:_url];
    [[CoreData sharedCoreData].sP2PMenuViewController.mv_rmvc.rmUtil showMenu:0];
}
- (void)showP2PAlertView:(CDVInvokedUrlCommand*)command
{
    [MyUtil me].msgcommand = command;
    NSString* msg = [command.arguments objectAtIndex:0];
    [self showAlertView:msg];
}
-(void)showAlertView:(NSString *)Msg{
    NSLog(@"debug P2PMenuViewController showMessage");
    NSArray * array= [Msg componentsSeparatedByString:@"<->"];
    if ([array count]<=1) {
        return;
    }
    if ([array count] == 2) {
        NSString *msg= [[NSString alloc] initWithFormat:@"%@",[array firstObject]];
        NSString *buttonName=[[NSString alloc] initWithFormat:@"%@",[array objectAtIndex:1]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:buttonName otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else{
        NSString *msg= [[NSString alloc] initWithFormat:@"%@",[array firstObject]];
        NSString *buttonName1=[[NSString alloc] initWithFormat:@"%@",[array objectAtIndex:1]];
        NSString *buttonName2=[[NSString alloc] initWithFormat:@"%@",[array objectAtIndex:2]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:buttonName1 otherButtonTitles:buttonName2,nil];
        [alert show];
        [alert release];
    }

}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    CDVPluginResult* pluginResult = nil;
    if (buttonIndex==0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
    }else if (buttonIndex==1){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"1"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:[MyUtil me].msgcommand.callbackId];
    [MyUtil me].msgcommand = nil;
}
-(void)toBrowser:(CDVInvokedUrlCommand*)command{
    CDVPluginResult* pluginResult = nil;
    NSString* url = [command.arguments objectAtIndex:0];
    
    if (url != nil && [url length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:url];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    [[CoreData sharedCoreData].sP2PMenuViewController openBrowserURL:url];
}

- (void) getUDID:(CDVInvokedUrlCommand*)command
{
    //get the callback id
    NSString *callbackId = command.callbackId;
    NSString *resultType = [command.arguments objectAtIndex:0];
    CDVPluginResult *pluginResult;
    NSLog(@"native nativeFunction:%@--%@", callbackId, resultType);
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: [OpenUDID value]];
    //        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end