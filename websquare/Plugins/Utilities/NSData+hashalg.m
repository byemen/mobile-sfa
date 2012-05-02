//
//  NSData+md5.m
//  WebSquareHybridTemplate
//
//  Created by Kim Rejean on 12. 3. 20..
//  Copyright (c) 2012년 Inswave. All rights reserved.
//

#import "NSData+hashalg.h"
#import <CommonCrypto/CommonDigest.h> 

// Need to import for CC_MD5 access

@implementation NSData (md5)
- (NSString *) md5
{
    unsigned char result[16];
    CC_MD5(self.bytes, self.length, result); // This is the md5 call
    return[NSString stringWithFormat:
                              @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                              result[0], result[1], result[2], result[3],
                              result[4], result[5], result[6], result[7],
                              result[8], result[9], result[10], result[11],
                              result[12], result[13], result[14], result[15]
                              ];
}

- (NSString *) sha1
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, self.length, result);
    return[NSString stringWithFormat:
           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15],
           result[16], result[17], result[18], result[19]
           ];
}
@end
