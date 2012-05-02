//
//  HTTPRequest.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 10..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest

@synthesize receivedData;
@synthesize response;
@synthesize result;
@synthesize target;
@synthesize selector;
@synthesize targetProgress, targetError;
@synthesize selectorProgress, selectorError;
@synthesize isReturnData, fileSavepath, fileNum;
@synthesize requestName;
@synthesize progressData;
@synthesize _connection, _timeout, _timeoutTimer;

- (id) init
{
    progressData = [[NSMutableDictionary alloc] init];
    
    return [super init];
}

- (BOOL)requestUrl:(NSString *)url sendingData:(NSData *)sendingData
{
    // URL Request 객체 생성
    NSLog(@"url : %@", url);
    /*NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:5.0f];*/
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    if(url) {
        requestName = [[NSString alloc] initWithString:url];
    }
    // option 설정
    NSString *httpMethod;
    //NSString *contentType;
    
    //httpMethod = [options objectForKey:@"httpMethod"];
    //contentType = [options objectForKey:@"contentType"];
    
    if(!sendingData) {
        NSLog(@"Get ");
        httpMethod = @"GET";
    } else {
        NSLog(@"Post ");
        httpMethod = @"POST";
    }
    
    // 통신방식 정의 (POST, GET)
    [request setHTTPMethod:httpMethod];

    // 데이터 첨부
    [request setHTTPBody:sendingData];
    
    _timeout = 30.0;
    
    if(_timeout) {
        _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:_timeout target:self selector:@selector(timeoutRequest) userInfo:nil repeats:NO];    
    }
    
    NSLog(@"Request headers : %@", [request allHTTPHeaderFields]);
    // Request를 사용하여 실제 연결을 시도하는 NSURLConnection 인스턴스 생성
    //NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [self set_connection:[[NSURLConnection alloc] initWithRequest:request delegate:self]];
    // 정상적으로 연결이 되었다면
    //if(connection)
    if(_connection)
    {
        // 데이터를 전송받을 멤버 변수 초기화
        receivedData = [[NSMutableData alloc] init];
        return YES;
    } 
    
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
    // 데이터를 전송받기 전에 호출되는 메서드, 우선 Response의 헤더만을 먼저 받아 온다.
    //[receivedData setLength:0];
    self.response = aResponse;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)aResponse;
    NSLog(@"status : %d Response headers : %@", [httpResponse statusCode],[httpResponse allHeaderFields]);
    totalFileSize = [aResponse expectedContentLength];
    if([httpResponse statusCode] != 200) {
        [connection cancel];
        if(targetError) {
            [targetError performSelector:selectorError withObject:[NSString stringWithFormat:@"HTTP status %d on requesting %@", [httpResponse statusCode], [httpResponse URL]]];
        }   
    }
    receivedDataBytes = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 데이터를 전송받는 도중에 호출되는 메서드, 여러번에 나누어 호출될 수 있으므로 appendData를 사용한다.
    receivedDataBytes += [data length];
    [receivedData appendData:data];
    NSNumber *progress = [NSNumber numberWithDouble:receivedDataBytes / (double)totalFileSize];
    NSLog(@"%f percents", [progress doubleValue] * 100);
    [[self progressData] setObject:progress forKey:@"progress"];
    
    if(fileSavepath != nil) {
        [[self progressData] setObject:[NSMutableString stringWithString:fileSavepath] forKey:@"file"];
    }
    
    if(requestName != nil) {
        [[self progressData] setObject:[NSMutableString stringWithString:[requestName lastPathComponent]] forKey:@"name"];
    }
    //NSLog(@"targetProgress");
    if(targetProgress)
    {
        [targetProgress performSelector:selectorProgress withObject:progressData];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // 에러가 발생되었을 경우 호출되는 메서드
    [_timeoutTimer invalidate];
    NSLog(@"Error: %@", [error localizedDescription]);
    if(targetError) {
        [targetError performSelector:selectorError withObject:[error localizedDescription]];
    } else {        
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
    [_timeoutTimer invalidate];
    result = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    // 델리게이트가 설정되어있다면 실행한다.
    if(target)
    {
        if(isReturnData) 
        {  
            NSMutableDictionary *dataInfo = [[NSMutableDictionary alloc] init];
            if(requestName != nil) {
                [dataInfo setObject:[NSMutableString stringWithString:requestName] forKey:@"name"];
            }
            [dataInfo setObject:receivedData forKey:@"data"];
            if(fileSavepath) {
                [dataInfo setObject:fileSavepath forKey:@"file"];
            }
            [target performSelector:selector withObject:dataInfo];
        } 
        else 
        {
            [target performSelector:selector withObject:result];
        }
    }
}

- (void)setDelegate:(id)aTarget selector:(SEL)aSelector
{
    // 데이터 수신이 완료된 이후에 호출될 메서드의 정보를 담고 있는 셀렉터 설정
    self.target = aTarget;
    self.selector = aSelector;
}

-(void)setProgressDelegate:(id)aTarget selector:(SEL)aSelector
{
    self.targetProgress = aTarget;
    self.selectorProgress = aSelector;
}

-(void)setErrorDelegate:(id)aTarget selector:(SEL)aSelector
{
    [self setTargetError:aTarget];
    [self setSelectorError:aSelector];
}

-(void)timeoutRequest
{
    [_timeoutTimer invalidate];
    [_connection cancel];
    if(targetError) {
        [targetError performSelector:selectorError withObject:@"The request timed out"];
    }   
}

- (void)dealloc
{
    [_connection release];
    if(_timeoutTimer) {
        [_timeoutTimer invalidate];
        [_timeoutTimer release];
    }
    [receivedData release];
    [response release];
    [result release];
    [super dealloc];
}

@end
