//
//  QRCodeScannerViewController.h
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol didQRScannedDelegate;
@interface QRCodeScannerViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (retain, nonatomic) IBOutlet UIButton *btn_cancel;

@property (retain, nonatomic) id<didQRScannedDelegate> delegate;
- (IBAction)cancel_onTouch:(id)sender;

@end
@protocol didQRScannedDelegate <NSObject>

- (void)didQRScanned:(id) scannerValue;
@end