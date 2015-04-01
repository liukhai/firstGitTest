//
//  NSData_AES.h
//  CashTrader
//
//  Created by Megahub on 02/09/2010.
//  Copyright 2010 CASH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (NSDataAES)

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128EncryptWithKeyData:(NSData *)key iv:(NSData *)iv;
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKeyData:(NSData *)key iv:(NSData *)iv;

@end
