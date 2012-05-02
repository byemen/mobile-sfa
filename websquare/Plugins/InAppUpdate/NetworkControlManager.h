//
//  NetworkControlManager.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"
#import "PatchFileInfo.h"
#import "InAppUpdateManager.h"

@interface NetworkControlManager : NSObject {
    
}

@property (nonatomic, retain) NSString *serverURL;
@property (nonatomic, retain) NSMutableDictionary *jsonMessage;
@property (nonatomic, retain) InAppUpdateManager *updateManager;

-(void) setHeader:(NSString *)method;
-(NSString *) getJsonString;
-(NSString *) getCurrentDateString;
-(NSArray *) getArrayWithJsonString: (NSString *)jsonString;
-(void) setJsonMessageObject:(id)jsonobject forKey:(id)jsonkey;

-(BOOL)sendRequest;
-(BOOL)sendRequest:(NSString *)mySelector;
-(BOOL)sendRequestReturnData:(NSString *)mySelector;
-(BOOL)sendRequestReturnDataWithFilePath:(NSString *)mySelector filePath:(NSString *)path;
-(BOOL)sendRequestReturnDataWithFilePath:(NSString *)mySelector fileURL:(NSString *)fileURL filePath:(NSString *)path;

-(void) gotResponse:(NSString *)result;
-(void) gotErrorResponse:(NSString *)error;
-(void) gotResponseProgress:(NSMutableDictionary *)progressData;
-(void) gotResponseFileList:(NSString *)result;
-(void) gotResponseFile:(NSMutableDictionary *)fileDataInfo;
-(void) gotResponseSingleFile:(NSMutableDictionary *)fileDataInfo;
-(void) gotResponseEngineFile:(NSString *)result;
-(void) gotResponseApplicationFile:(NSString *)result;

-(void) getFileFromPatchFileList;

-(void) gotResponseRefreshFileList:(NSString *)result;
-(void) getRefreshFileList:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;

@end
