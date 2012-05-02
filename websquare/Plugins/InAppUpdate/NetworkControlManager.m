//
//  NetworkControlManager.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "NetworkControlManager.h"
#import "FileControlManager.h"
#import "JavascriptControlManager.h"
#import "JSON.h"

@implementation NetworkControlManager
@synthesize serverURL, jsonMessage;
@synthesize updateManager;

-(NSString *) getCurrentDateString
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSDate *date = [NSDate date];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return formattedDateString;    
}

-(NSArray *) getArrayWithJsonString: (NSString *)jsonString
{
    SBJSON *json = [SBJSON new];
    [json setHumanReadable:YES];
    return [json objectWithString:jsonString error:nil];
}

-(NSString *) getJsonStringWithParam: (NSMutableDictionary *) dict
{
    SBJSON *json = [SBJSON new];
    [json setHumanReadable:YES];
    return [json stringWithObject:dict error:nil];
}

-(NSString *) getJsonString
{
    return [self getJsonStringWithParam:jsonMessage];
}

-(void) setJsonMessageObject:(id)jsonobject forKey:(id)jsonkey
{
    [jsonMessage setObject:jsonobject forKey:jsonkey];
}

-(void) setHeader:(NSString *)method
{
    NSMutableDictionary *myjsonMessage = [[NSMutableDictionary alloc] init];
    [myjsonMessage setObject:[updateManager appid] forKey:@"appid"];
    [myjsonMessage setObject:method forKey:@"method"];
    [myjsonMessage setObject:[self getCurrentDateString] forKey:@"timestamp"];
    
    [self setJsonMessage:myjsonMessage];
}

-(BOOL)sendRequest
{
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    [httpRequest setIsReturnData:FALSE];
    [httpRequest setDelegate:self selector:@selector(gotResponse:)];  
    [httpRequest setErrorDelegate:self selector:@selector(gotErrorResponse:)];
    return [httpRequest requestUrl:[serverURL stringByAppendingPathComponent:@"inAppUpdate.wq"] sendingData:[[self getJsonString] dataUsingEncoding:NSUTF8StringEncoding]];
}

-(BOOL)sendRequest:(NSString *)mySelector
{
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    [httpRequest setIsReturnData:FALSE];
    [httpRequest setDelegate:self selector:NSSelectorFromString(mySelector)];  
    [httpRequest setErrorDelegate:self selector:@selector(gotErrorResponse:)];
    return [httpRequest requestUrl:[serverURL stringByAppendingPathComponent:@"inAppUpdate.wq"] sendingData:[[self getJsonString] dataUsingEncoding:NSUTF8StringEncoding]];
}

-(BOOL)sendRequestReturnData:(NSString *)mySelector
{
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    [httpRequest setIsReturnData:TRUE];
    [httpRequest setFileSavepath:serverURL];
    [httpRequest setDelegate:self selector:NSSelectorFromString(mySelector)];  
    [httpRequest setProgressDelegate:self selector:@selector(gotResponseProgress:)];  
    [httpRequest setErrorDelegate:self selector:@selector(gotErrorResponse:)];
    return [httpRequest requestUrl:serverURL sendingData:[[self getJsonString] dataUsingEncoding:NSUTF8StringEncoding]];
}

-(BOOL)sendRequestReturnDataWithFilePath:(NSString *)mySelector filePath:(NSString *)path
{
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    [httpRequest setIsReturnData:TRUE];
    [httpRequest setFileSavepath:path];
    [httpRequest setDelegate:self selector:NSSelectorFromString(mySelector)];  
    [httpRequest setProgressDelegate:self selector:@selector(gotResponseProgress:)];  
    [httpRequest setErrorDelegate:self selector:@selector(gotErrorResponse:)];
    return [httpRequest requestUrl:serverURL sendingData:[[self getJsonString] dataUsingEncoding:NSUTF8StringEncoding]];
}


-(BOOL)sendRequestReturnDataWithFilePath:(NSString *)mySelector fileURL:(NSString *)fileURL filePath:(NSString *)path
{  
    HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
    [httpRequest setIsReturnData:TRUE];
    [httpRequest setFileSavepath:path];
    [httpRequest setDelegate:self selector:NSSelectorFromString(mySelector)];  
    [httpRequest setProgressDelegate:self selector:@selector(gotResponseProgress:)];  
    [httpRequest setErrorDelegate:self selector:@selector(gotErrorResponse:)];
    [updateManager setLog:[NSString stringWithFormat:@"fileURL : %@",fileURL]];
    return [httpRequest requestUrl:fileURL sendingData:nil];
}


-(void)gotResponse:(NSString *)result 
{
    NSLog(@" result : %@", result);
    
    [updateManager setLog:@"=========== response ==========="];
    [updateManager setLog:result];
    [updateManager setLog:@"=============================="];
        
    [updateManager processManager:nil withDict:nil];
}

-(void)gotResponseProgress:(NSMutableDictionary *)progressData
{
    [progressData setObject:@" 다운중" forKey:@"message"];
   // NSLog(@"progress name : %@, progress : %@", [progressData valueForKey:@"name"], [progressData valueForKey:@"progress"]);
    [[updateManager javascriptControlManager] setProgress:[progressData JSONRepresentation]];
}

-(void)gotResponseProgressZip:(NSMutableDictionary *)progressData
{
    [progressData setObject:@" 설치중" forKey:@"message"];
    //NSLog(@"progress name : %@, progress : %@", [progressData valueForKey:@"name"], [progressData valueForKey:@"progress"]);
    [[updateManager javascriptControlManager] setProgress:[progressData JSONRepresentation]];
    //NSLog(@" %@ / %@ ", [progressData objectForKey:@"current"], [progressData objectForKey:@"total"]);
}

-(void)gotResponseFileList:(NSString *)result	
{   
    [updateManager setLog:@"=========== response ==========="];
    [updateManager setLog:result];
    [updateManager setLog:@"=============================="];
 
    NSArray *jsonDict = [self getArrayWithJsonString:result];
    NSDictionary *patchFilesJson = [jsonDict objectAtIndex:1];
    double patchFilesCount = [[patchFilesJson objectForKey:@"count"] doubleValue];
    
    if(patchFilesCount <= 0) {
        [updateManager flushCommand];
        [updateManager putCommand:@"onSuccess"];
        [updateManager processManager:nil withDict:nil];
    }
    
    if([updateManager patchFileInfoList]) {
        [updateManager.patchFileInfoList release];
    }
    [updateManager setPatchFileInfoList:[[NSMutableArray alloc] init]];
    
    NSArray *patchFiles = [patchFilesJson objectForKey:@"patchFiles"];
    NSDictionary *singlePatchFile = nil;
    PatchFileInfo *singlePatchInfo = nil;
    int patchnumberint = 0;
    
    for(int i = 0; i < patchFilesCount; i++) {
        singlePatchFile = [patchFiles objectAtIndex:i];
        singlePatchInfo = [[[PatchFileInfo alloc] initWithJsonData:singlePatchFile] autorelease];
        [[updateManager patchFileInfoList] addObject:singlePatchInfo];
        patchnumberint = [singlePatchInfo patchnumber];
        if(patchnumberint > [updateManager patchNumber]) {
            [updateManager setPatchNumber:patchnumberint];
        }
    }
    
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {
        singlePatchInfo = [[updateManager patchFileInfoList] objectAtIndex:i];
        [singlePatchInfo setIndex:i];
    }
   
   [updateManager processManager:nil withDict:nil];
}

-(void) gotResponseFile:(NSMutableDictionary *)fileDataInfo 
{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSData* theData = [fileDataInfo valueForKey:@"data"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	[updateManager setFileSavePath:[fileDataInfo valueForKey:@"file"]];
    if([updateManager fileSavePath] == nil) {
        [updateManager setFileSavePath:@"/"];
    }
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:[updateManager fileSavePath]];
    
    [updateManager setLog:[NSString stringWithFormat:@"newfilepath : %@", newFilePath]];
    
    NSError *error = nil;
    
    [theData writeToFile:newFilePath options:NSDataWritingFileProtectionNone error:&error];
	
    if(error) {
        //@TODO 에러처리
        [updateManager setLog:[NSString stringWithFormat:@"An error occurred saving: %@", [error description]]];
        return;
    }
    PatchFileInfo *myPatch;
    NSString *patchFileName = [fileDataInfo valueForKey:@"name"];
    BOOL allReceived = YES;
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {
        myPatch = [[updateManager patchFileInfoList] objectAtIndex:i];
        if([[myPatch filePath] isEqualToString:patchFileName]) {
            [myPatch setReceived:YES];
            [myPatch setFilePath:newFilePath];
        }
    }
    
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {
        myPatch = [[updateManager patchFileInfoList] objectAtIndex:i];
        if(![myPatch received]) {            
            allReceived = NO;
            break;
        }
    }
    
    if(allReceived){
        [updateManager setLog:[NSString stringWithFormat:@"All file received"]];
        [updateManager processManager:nil withDict:nil];       
    }
    
    [pool drain];    
}

-(void) gotResponseSingleFile:(NSMutableDictionary *)fileDataInfo
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSData* theData = [fileDataInfo valueForKey:@"data"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	[updateManager setFileSavePath:[fileDataInfo valueForKey:@"file"]];
    if([updateManager fileSavePath] == nil) {
        [updateManager setFileSavePath:@"/"];
    }
	NSString *newFilePath = [documentsDirectory stringByAppendingPathComponent:[updateManager fileSavePath]];
    
    [updateManager setLog:[NSString stringWithFormat:@"newfilepath : %@", newFilePath]];
    
    NSError *error = nil;
    
    [theData writeToFile:newFilePath options:NSDataWritingFileProtectionNone error:&error];
	
    if(error) {
        //@TODO 에러처리
        [updateManager setLog:[NSString stringWithFormat:@"An error occurred saving: %@", [error description]]];        
        [updateManager processManager:nil withDict:nil];
    }
    NSMutableArray *fileParameter = [[NSMutableArray alloc] init];
    [fileParameter addObject:newFilePath];
    
    [updateManager processManager:fileParameter withDict:nil];
    [pool drain]; 
}

-(void) getFileFromPatchFileList
{
    NSString *jsonPatchFileName;
    NSString *patchFileSavePath;
    NSString *patchFileFilePath;
    
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {       
        jsonPatchFileName = [[[updateManager patchFileInfoList] objectAtIndex:i] name];
        [updateManager setLog:[NSString stringWithFormat:@"fileurl : %@", jsonPatchFileName]];
    }
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {  
        jsonPatchFileName = [[[updateManager patchFileInfoList] objectAtIndex:i] name];    
        patchFileFilePath = [[[updateManager patchFileInfoList] objectAtIndex:i] filePath];
        patchFileSavePath = [[[updateManager patchFileInfoList] objectAtIndex:i] savePath];
        if(!patchFileSavePath) {
            [self sendRequestReturnDataWithFilePath:@"gotResponseFile:" fileURL:patchFileFilePath filePath:[patchFileFilePath lastPathComponent]];
        } else {
            [self sendRequestReturnDataWithFilePath:@"gotResponseFile:" fileURL:patchFileFilePath filePath:[[updateManager appdataDirectory] stringByAppendingPathComponent:[patchFileSavePath stringByAppendingPathComponent:jsonPatchFileName]]];
        }
    }
}

-(void) getRefreshFileList:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [self setHeader:@"checkRefreshUpdate"];
    [jsonMessage setObject:@"1.01" forKey:@"appVersion"];
    [self sendRequest:@"gotResponseRefreshFileList:"];
}

-(void) gotResponseRefreshFileList:(NSString *)result
{
    [updateManager setLog:[NSString stringWithFormat:@" result : %@", result]];
    
    NSArray *jsonDict = [self getArrayWithJsonString:result];
    NSDictionary *patchFilesJson = [jsonDict objectAtIndex:1];
    int patchFilesCount = [[patchFilesJson objectForKey:@"count"] intValue];
    NSLog(@"Refresh Files : %d", patchFilesCount);
    if(patchFilesCount <= 0) {
        [updateManager setLog:@"no refresh files"];
        [updateManager flushCommand];
        [updateManager putCommand:@"onSuccess"];
        [updateManager processManager:nil withDict:nil];
    }
    
    if([updateManager patchFileInfoList]) {
        [[updateManager patchFileInfoList] release];
    }
    [updateManager setPatchFileInfoList:[[NSMutableArray alloc] init]];
    
    NSArray *patchFiles = [patchFilesJson objectForKey:@"refreshFiles"];
    NSDictionary *singlePatchFile = nil;
    PatchFileInfo *singlePatchInfo = nil;
    double filesize = 0;
    NSString *originalFilePath = nil;
    
    for(int i = 0; i < patchFilesCount; i++) {
        singlePatchFile = [patchFiles objectAtIndex:i];
        singlePatchInfo = [[[PatchFileInfo alloc] initWithJsonData:singlePatchFile] autorelease];
        originalFilePath = [[singlePatchInfo savePath] stringByAppendingPathComponent:[singlePatchInfo name]] ;
        filesize = [[updateManager fileControlManager] getFileSize:originalFilePath];
        if([singlePatchInfo size] != [[updateManager fileControlManager] getFileSize:originalFilePath]) {
            [[updateManager patchFileInfoList] addObject:singlePatchInfo];
        }
    }
    
    if([[updateManager patchFileInfoList] count] <= 0) {
        [updateManager flushCommand];
        [updateManager putCommand:@"onSuccess"];
        [updateManager processManager:nil withDict:nil];
    }
    
    for(int i = 0; i < [[updateManager patchFileInfoList] count]; i++) {
        singlePatchInfo = [[updateManager patchFileInfoList] objectAtIndex:i];
        [singlePatchInfo setIndex:i];
        NSLog(@"name : %@", [[[updateManager patchFileInfoList] objectAtIndex:i] name]);
        //NSLog(@"filename : %@ size : %@", [singlePatchInfo name], [singlePatchInfo size]);
        //[updateManager setLog:[NSString stringWithFormat:@"filename : %@ size : %@", [singlePatchInfo name], [singlePatchInfo size]]];
    }
    
    [updateManager processManager:nil withDict:nil];    
}

-(void) gotResponseEngineFile:(NSString *)result
{
    [updateManager setLog:[NSString stringWithFormat:@" result : %@", result]];
    SBJSON *jsonresult = [SBJSON new];
    [jsonresult setHumanReadable:YES];
    NSDictionary *resultDictionary = [jsonresult objectWithString:result error:nil];
    [updateManager setLog:[NSString stringWithFormat:@"path : %@", [resultDictionary objectForKey:@"engineURL"]]];
    NSMutableArray *fileParameter = [[NSMutableArray alloc] init];
    NSString *fileSaveName;
    if([resultDictionary objectForKey:@"engineURL"]) {
        fileSaveName = [[resultDictionary objectForKey:@"engineURL"] lastPathComponent];
        if(!fileSaveName) {
            fileSaveName = @"WebSquareEngine.zip";
        }
        
        [fileParameter addObject:[resultDictionary objectForKey:@"engineURL"]];
        [fileParameter addObject:fileSaveName];
        
        [updateManager processManager:fileParameter withDict:nil];
    } else {
        if([[resultDictionary objectForKey:@"status"] isEqualToString:@"same"]) {
            [updateManager flushCommand];        
            [updateManager putCommand:@"onSuccess"];
            [updateManager processManager:nil withDict:nil];
        } else {
            //@TODO OnError
			if(result == (id)[NSNull null] || result.length == 0) {
				[self gotErrorResponse:@"Response is null"];
			} else if(resultDictionary) {
				if(![resultDictionary objectForKey:@"recoveryURL"]) {
					[self gotErrorResponse:@"No recovery URL in the response"];
				} else {
					if([[resultDictionary objectForKey:@"status"] isEqualToString:@"NO"]) {
						[self gotErrorResponse:[resultDictionary objectForKey:@"description"]];
					} else {
						[self gotErrorResponse:@"Patch server returned status:NO. Check application ID and patch server settings"];
					}
				}
			} else {
				[self gotErrorResponse:@"Response data parsing error"];
			}		
        }
    }
}

-(void) gotResponseApplicationFile:(NSString *)result
{
    [updateManager setLog:[NSString stringWithFormat:@" result : %@", result]];
    SBJSON *jsonresult = [SBJSON new];
    [jsonresult setHumanReadable:YES];
    NSDictionary *resultDictionary = [jsonresult objectWithString:result error:nil];
    [updateManager setLog:[NSString stringWithFormat:@"path : %@", [resultDictionary objectForKey:@"recoveryURL"]]];
    NSMutableArray *fileParameter = [[NSMutableArray alloc] init];
    NSString *fileSaveName;
    if([resultDictionary objectForKey:@"recoveryURL"]) {
        fileSaveName = [[resultDictionary objectForKey:@"recoveryURL"] lastPathComponent];
        if(!fileSaveName) {
            fileSaveName = @"WebSquareEngine.zip";
        }
        [updateManager setPatchNumber:[[resultDictionary objectForKey:@"patchnumber"] intValue]];
        [fileParameter addObject:[resultDictionary objectForKey:@"recoveryURL"]];
        [fileParameter addObject:fileSaveName];
        
        //@TODO 파일이름 파싱해서 hoyoon2 말고 파일이름으로 사용하기
        
        [updateManager processManager:fileParameter withDict:nil];        
    } else {
        //@TODO OnError
		if(result == (id)[NSNull null] || result.length == 0) {
			[self gotErrorResponse:@"Response is null"];
		} else if(resultDictionary) {
			if(![resultDictionary objectForKey:@"recoveryURL"]) {
				[self gotErrorResponse:@"No recovery URL in the response"];
			} else {
				if([[resultDictionary objectForKey:@"status"] isEqualToString:@"NO"]) {
					[self gotErrorResponse:[resultDictionary objectForKey:@"description"]];
				} else {
					[self gotErrorResponse:@"Patch server returned status:NO. Check application ID and patch server settings"];
				}
			}
		} else {
			[self gotErrorResponse:@"Response data parsing error"];
		}		
    }
}

-(void) gotErrorResponse:(NSString *)errormsg
{
    [updateManager flushCommand];
    [updateManager putCommand:@"onFail"];
    [updateManager processManager:[NSMutableArray arrayWithObject:errormsg] withDict:nil];
}

@end
