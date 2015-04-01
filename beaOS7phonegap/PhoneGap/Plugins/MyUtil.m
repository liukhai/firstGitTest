//  Created by yaojzy on 201307.

#import "MyUtil.h"

@implementation MyUtil

@synthesize mainVC;
@synthesize testVC;
@synthesize btn_close;
@synthesize btn_print;
@synthesize webView_4print;
@synthesize firstName;
@synthesize phoneNumber;

static MyUtil* _me;

+(MyUtil*) me
{
    if (!_me) {
        _me = [[MyUtil alloc] init];
    }
    return _me;
}

- (void)do_print_pdf {
    CGRect oldFrame = [MyUtil me].mainVC.webView.frame;

    // Resize the UIWebView, contentSize could be > visible size
    [[MyUtil me].mainVC.webView sizeToFit];

    NSMutableData *pdfData = [[NSMutableData alloc] init];
    CGDataConsumerRef dataConsumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)pdfData);

    CGRect mediaBox = [MyUtil me].mainVC.webView.scrollView.frame;
    CGContextRef pdfContext = CGPDFContextCreate(dataConsumer, &mediaBox, NULL);
    CGContextTranslateCTM(pdfContext, 0, mediaBox.size.height);
    CGContextScaleCTM(pdfContext, 1.0, -1.0);

    UIGraphicsPushContext(pdfContext);

    CGContextBeginPage(pdfContext, &mediaBox);

    // Your Quartz drawing code goes here
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext, 0, mediaBox.size.height);
    CGContextScaleCTM(resizedContext, 1, -1);
    [[MyUtil me].mainVC.webView.layer renderInContext:resizedContext];

    CGContextEndPage(pdfContext);
    CGPDFContextClose(pdfContext);

    UIGraphicsPopContext();

    CGContextRelease(pdfContext);
    CGDataConsumerRelease(dataConsumer);

    [MyUtil me].mainVC.webView.frame = oldFrame;

    // Write the UIImage to disk as PNG so that we can see the result
    NSString *path= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.pdf"];
    [pdfData writeToFile:path atomically:YES];
    NSLog(@"debug do_print:%@", path);

}

- (void)do_print_pdf2:(UIWebView*)contentView {
    CGRect oldFrame = contentView.frame;

    // Resize the UIWebView, contentSize could be > visible size
    [contentView sizeToFit];

    NSMutableData *pdfData = [[NSMutableData alloc] init];
    CGDataConsumerRef dataConsumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)pdfData);

    CGRect mediaBox = contentView.scrollView.frame;
    CGContextRef pdfContext = CGPDFContextCreate(dataConsumer, &mediaBox, NULL);
    CGContextTranslateCTM(pdfContext, 0, mediaBox.size.height);
    CGContextScaleCTM(pdfContext, 1.0, -1.0);

    UIGraphicsPushContext(pdfContext);

    CGContextBeginPage(pdfContext, &mediaBox);

    // Your Quartz drawing code goes here
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext, 0, mediaBox.size.height);
    CGContextScaleCTM(resizedContext, 1, -1);
    [contentView.layer renderInContext:resizedContext];

    CGContextEndPage(pdfContext);
    CGPDFContextClose(pdfContext);

    UIGraphicsPopContext();

    CGContextRelease(pdfContext);
    CGDataConsumerRelease(dataConsumer);

    contentView.frame = oldFrame;

    // Write the UIImage to disk as PNG so that we can see the result
    NSString *path= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.pdf"];
    [pdfData writeToFile:path atomically:YES];
    NSLog(@"debug do_print:%@", path);
    
}

- (void)do_print_pdf:(NSString*)content
{

    testVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    CGRect mediaBox = [MyUtil me].mainVC.webView.frame;
    mediaBox.origin.x = 0;
    mediaBox.origin.y = -20;
    webView_4print = [[UIWebView alloc] initWithFrame:mediaBox];

    [webView_4print loadHTMLString:content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];

    [testVC.view addSubview:webView_4print];
    [self.mainVC.view addSubview:testVC.view];

    btn_print = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 200;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_print.frame = mediaBox;
    [btn_print setTitle:@"confirm" forState:UIControlStateNormal];

	[btn_print addTarget:self action:@selector(printTextVCAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_print];

}

- (void)do_gotoMBK
{
//    NSString *path= @"https://mobile.hkbea-cyberbanking.com/servlet/FRIndex";
    NSString *path= @"http://magicj.info/hybird/";
    NSLog(@"debug do_gotoMBK:%@", path);

    testVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    CGRect mediaBox = [MyUtil me].mainVC.webView.frame;
    mediaBox.origin.x = 0;
    mediaBox.origin.y = -20;

    MainViewController* webView_4MBK;
#if __has_feature(objc_arc)
    webView_4MBK = [[MainViewController alloc] init];
#else
    webView_4MBK = [[[MainViewController alloc] init] autorelease];
#endif
    webView_4MBK.webView.frame = mediaBox;
    webView_4print = webView_4MBK.webView;

//    webView_4print = [[UIWebView alloc] initWithFrame:mediaBox];
    NSURL *targetURL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    webView_4print.delegate = self;
    [webView_4print loadRequest:request];

//    webView_4MBK.webView.delegate = self;
//    [webView_4MBK.webView loadRequest:request];
//    [testVC.view addSubview:webView_4MBK.webView];

    [testVC.view addSubview:webView_4print];
    [self.mainVC.view addSubview:testVC.view];

    btn_print = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 200;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_print.frame = mediaBox;
    [btn_print setTitle:@"confirm" forState:UIControlStateNormal];

	[btn_print addTarget:self action:@selector(printTextVCAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_print];
    
}

- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    NSLog(@"debug webViewDidStartLoad");
    return;
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    NSLog(@"debug didFailLoadWithError:%@", error);
    return;
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"debug shouldStartLoadWithRequest:%@", request);
    return YES;
}

- (void)printTextVCAction2:(id)sender
{
    [self do_print_pdf2:webView_4print];
    [self closeTextVCAction:sender];
    [self showPDFOnScreen];
}

- (void)showPDFOnScreen
{
    // Write the UIImage to disk as PNG so that we can see the result
    NSString *path= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.pdf"];
    NSLog(@"debug showPDFOnScreen:%@", path);

    testVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    CGRect mediaBox = [MyUtil me].mainVC.webView.frame;
    mediaBox.origin.x = 0;
    mediaBox.origin.y = -20;
    webView_4print = [[UIWebView alloc] initWithFrame:mediaBox];

    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView_4print loadRequest:request];

    [testVC.view addSubview:webView_4print];
    [self.mainVC.view addSubview:testVC.view];

    btn_close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 50;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_close.frame = mediaBox;
    [btn_close setTitle:@"close" forState:UIControlStateNormal];

	[btn_close addTarget:self action:@selector(closeTextVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_close];

    btn_print = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 200;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_print.frame = mediaBox;
    [btn_print setTitle:@"print" forState:UIControlStateNormal];

	[btn_print addTarget:self action:@selector(printTextVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_print];

}

- (void)closeTextVCAction:(id)sender
{
    [testVC.view removeFromSuperview];
    [btn_close removeFromSuperview];
    [btn_print removeFromSuperview];
}

- (void)printTextVCAction:(id)sender
{
    [self do_airprint:webView_4print];
}

- (void)do_airprint:(UIWebView*)printView {
    NSLog(@"debug do_print begin:%@", printView);

    if (!printView) {
        return;
    }

    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    pic.printInfo = printInfo;

    pic.printFormatter = [printView viewPrintFormatter];
    pic.printFormatter.maximumContentWidth = printView.frame.size.width;
    pic.printFormatter.maximumContentHeight = printView.frame.size.height;
    pic.showsPageRange = YES;

    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error)
    {
        if (!completed && error)
        {
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    [pic presentAnimated:YES completionHandler:completionHandler];

}

- (void)do_airprint {
    [self do_airprint:[MyUtil me].mainVC.webView];
}

- (void)accessUATserver {
    NSURL* url = [NSURL URLWithString:@"https://210.176.24.64/servlet/MBLogonShow/"];
//    NSError* error = [NSError alloc];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];

    NSLog(@"debug accessUATserver: %@", url);

    NSURLConnection* connection = [ NSURLConnection connectionWithRequest: urlRequest delegate:self ];

    NSLog(@"debug accessUATserver: %@", connection);

}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {

    NSLog(@"debug canAuthenticateAgainstProtectionSpace: %@", connection);
    return YES;
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
//        if ([trustedHosts containsObject:challenge.protectionSpace.host])
//            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];

    NSLog(@"debug didReceiveAuthenticationChallenge: %@", connection);

//    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (NSString*)do_getPhoneNum
{
    NSString *num = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    num = [NSString stringWithFormat:@"phonenum:%@",num];
    NSLog(@"debug do_getPhoneNum:%@", num);
    [self showPicker:nil];
    return num;
}

- (IBAction)showPicker:(id)sender
{
    ABAddressBookRef addressBook = [self getABAddressBookRef];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
    CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
    
    for ( int i = 0; i < nPeople; i++ )
    {
        ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString* name = (NSString*)ABRecordCopyValue(ref,
                                                                        kABPersonFirstNameProperty);
        NSLog(@"debug showPicker name:%@", name);
        
        NSString* phone = nil;
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(ref,
                                                         kABPersonPhoneProperty);
        if (ABMultiValueGetCount(phoneNumbers) > 0) {
            phone = (NSString*)
            ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        } else {
            phone = @"[None]";
        }

        CFRelease(phoneNumbers);
        NSLog(@"debug showPicker phone:%@", phone);

    }

    
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self.mainVC presentViewController:picker animated:YES completion:nil];
    
}

- (NSString*)do_getPhoneNumbers
{
    NSString *num = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    num = [NSString stringWithFormat:@"phonenum:%@",num];
    NSLog(@"debug do_getPhoneNum:%@", num);
    
    ABAddressBookRef addressBook = [self getABAddressBookRef];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
    CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
    
    for ( int i = 0; i < nPeople; i++ )
    {
        ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString* name = (NSString*)ABRecordCopyValue(ref,
                                                                        kABPersonFirstNameProperty);
        NSLog(@"debug showPicker name:%@", name);
        NSString* phone = nil;
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(ref,
                                                         kABPersonPhoneProperty);
        if (ABMultiValueGetCount(phoneNumbers) > 0) {
            phone = (NSString*)
            ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        } else {
            phone = @"[None]";
        }
        
        CFRelease(phoneNumbers);
        NSLog(@"debug showPicker phone:%@", phone);

        num = [NSString stringWithFormat:@"%@\n%@=%@", num, name, phone];
    }
    return num;
}
-(ABAddressBookRef) getABAddressBookRef{
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    {
        addressBook = [self getABAddressBookRef];
    }
    
//    NSArray *personArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    return addressBook;
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self.mainVC dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {

    [self displayPerson:person];
//    [self.mainVC dismissModalViewControllerAnimated:YES];

//    return NO;
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
//    return NO;
    return YES;
}

- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = ( NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    self.firstName = name;

    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    self.phoneNumber = phone;
    CFRelease(phoneNumbers);
    NSLog(@"phoneNumber:%@", self.phoneNumber);
}

- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)showScreenCaptureOnScreen
{
    // Write the UIImage to disk as PNG so that we can see the result
//    NSString *path= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.pdf"];
    NSLog(@"debug showScreenCaptureOnScreen:%@", self);
    
    testVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    CGRect mediaBox = [MyUtil me].mainVC.webView.frame;
    mediaBox.origin.x = 20;
    mediaBox.origin.y = 20;
    mediaBox.size.width = mediaBox.size.width * 0.8;
    mediaBox.size.height = mediaBox.size.height * 0.8;
//    webView_4print = [[UIWebView alloc] initWithFrame:mediaBox];
//    
//    NSURL *targetURL = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
//    [webView_4print loadRequest:request];
    
//    [testVC.view addSubview:webView_4print];
    UIImage *image = [self screenshot];
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[image CGImage]
                              orientation:(ALAssetOrientation)[image imageOrientation]
                          completionBlock:^(NSURL *assetURL, NSError *error){
                              if (error) {
                                  // TODO: error handling
                                  NSLog(@"showScreenCaptureOnScreens error");
                              } else {
                                  // TODO: success handling
                                  NSLog(@"showScreenCaptureOnScreens success");
                              }
                          }];
    //    [library release];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = mediaBox;
    
    [testVC.view addSubview:imgView];
    [self.mainVC.view addSubview:testVC.view];
    
    btn_close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 50;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_close.frame = mediaBox;
    [btn_close setTitle:@"close" forState:UIControlStateNormal];
    
	[btn_close addTarget:self action:@selector(closeTextVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_close];
    
    btn_print = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mediaBox.origin.x = 200;
    mediaBox.origin.y = 420;
    mediaBox.size.width = 80;
    mediaBox.size.height = 30;
    btn_print.frame = mediaBox;
    [btn_print setTitle:@"print" forState:UIControlStateNormal];
    
	[btn_print addTarget:self action:@selector(printTextVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainVC.view addSubview:btn_print];
    
}

- (NSString*)do_getNameByMobileNo:(NSString*)mobileno
{
    NSString* nameFound = @"[NOT FOUND]";
    
    ABAddressBookRef addressBook = [self getABAddressBookRef];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
    CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
    
    for ( int i = 0; i < nPeople; i++ )
    {
        ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString* name = (NSString*)ABRecordCopyValue(ref,
                                                                        kABPersonFirstNameProperty);
        NSLog(@"debug do_getNameByMobileNo name:%@", name);
        
        NSString* phone = nil;
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(ref,
                                                         kABPersonPhoneProperty);
        if (ABMultiValueGetCount(phoneNumbers) > 0) {
            phone = (NSString*)
            ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        } else {
            phone = @"[None]";
        }
        
        CFRelease(phoneNumbers);
        NSLog(@"debug do_getNameByMobileNo phone:%@", phone);

        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSLog(@"debug do_getNameByMobileNo phone deformatted:%@", phone);
        
        if ([mobileno isEqualToString:phone]) {
            nameFound = name;
            NSLog(@"debug do_getNameByMobileNo FOUND IT:%@--%@", phone, nameFound);

        }
        
    }
    
    return nameFound;
}

@end
