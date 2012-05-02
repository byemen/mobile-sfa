//
//  HTTPRequest.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 10..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableData *receivedData;
    NSURLResponse *response;
    NSString *result;
    id target;
    id targetProgress;
    SEL selector;
    SEL selectorProgress;
    long totalFileSize;
    long receivedDataBytes;
}

//- (BOOL)requestUrl:(NSString *)url sendingData:(NSMutableData *)sendingData withDict:(NSMutableDictionary *)options;
- (BOOL)requestUrl:(NSString *)url sendingData:(NSData *)sendingData;
        //bodyObject:(NSDictionary *)bodyObject;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)setDelegate:(id)aTarget selector:(SEL)aSelector;
- (void)setProgressDelegate:(id)aTarget selector:(SEL)aSelector;
- (void)setErrorDelegate:(id)aTarget selector:(SEL)aSelector;

- (void)timeoutRequest;

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSMutableDictionary *progressData;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic, assign) NSString *result;
@property (nonatomic, retain) id target;
@property (nonatomic, retain) id targetProgress;
@property (nonatomic, retain) id targetError;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) SEL selectorProgress;
@property (nonatomic, assign) SEL selectorError;
@property (nonatomic, assign) BOOL isReturnData;
@property (nonatomic, retain) NSString *fileSavepath;
@property (nonatomic, retain) NSString *requestName;
@property (nonatomic) int fileNum;
@property (nonatomic, retain) NSURLConnection *_connection;
@property (nonatomic) NSTimeInterval _timeout;
@property (nonatomic, retain) NSTimer *_timeoutTimer;
@end
