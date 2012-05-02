//
//  InAppUpdateManager.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 9..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatchFileInfo.h"
#import "ZipArchive.h"
#import "JSON.h"
#import "NSData+hashalg.h"
#import "NSString+hashalg.h"

@class FileControlManager;
@class NetworkControlManager;
@class JavascriptControlManager;

@interface InAppUpdateManager : NSObject <ZipArchiveDelegate>{
}

@property (nonatomic, retain) FileControlManager *fileControlManager;
@property (nonatomic, retain) NetworkControlManager *networkControlManager;
@property (nonatomic, retain) JavascriptControlManager *javascriptControlManager;

@property (nonatomic, retain) NSMutableArray *processQueue;
		
@property (nonatomic, copy) NSString* successCallback;
@property (nonatomic, copy) NSString* failCallback;
@property (nonatomic, copy) NSString* progressCallback;
@property (nonatomic, copy) NSString* logCallback;

@property (nonatomic, copy) NSString* logFunction;
@property (nonatomic, copy) NSString* progressFunction;
@property (nonatomic, copy) NSString* statusFunction;

@property (nonatomic, retain) NSString *serverURL;
@property (nonatomic, retain) NSString *currentVersion;
@property (nonatomic) BOOL isUpdating;
@property (nonatomic) BOOL forcedCopy;
@property (nonatomic, retain) NSString *appid;
@property (nonatomic, retain) NSString *fileSavePath;
@property (nonatomic, retain) NSString *backupDirectory;
@property (nonatomic, retain) NSString *websqDirectory;
@property (nonatomic, retain) NSString *appdataDirectory;
@property (nonatomic, retain) NSString *DTR;
@property (nonatomic) int currentZipFile;
@property (nonatomic) int totalZipFile;

@property (nonatomic, retain) NSMutableDictionary *jsonMessage;
@property (nonatomic, retain) NSMutableDictionary *localFiles;
@property (nonatomic, retain) NSMutableArray *patchFileInfoList;
@property (nonatomic, retain) NSMutableArray *processParamArray;
@property (nonatomic, retain) NSMutableDictionary *processParamOptions;

@property (nonatomic, retain) NSString *server;
@property (nonatomic, retain) NSString *wqVersion;
@property (nonatomic) int patchNumber;
@property (nonatomic, retain) NSString *startPage;
@property (nonatomic, retain) NSString *wqStartPage;
@property (nonatomic, retain) NSString *errorPage;
@property (nonatomic) BOOL engineUpdatePolicy;
@property (nonatomic) BOOL applicationUpdatePolicy;
@property (nonatomic) BOOL refreshUpdatePolicy;

-(void) writeJavascript:(NSString *)msg;
-(void) setLog:(NSString *)msg;


// Javascript functions
-(void) processManager:(NSMutableArray*) paramArray;
-(void) processManager:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) initParameter:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) ping:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) getFile:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) getFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) patchGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doBackup:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doRestore:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) launch:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) clean:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) getRefreshFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) copyResource:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) copyLocalResource:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) copyEngine:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) onSuccess:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) onFail:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doInstall;
-(void) isFirstLaunch;
-(void) updateConfig;
-(void) updateStatus;
-(void) putCommand:(NSString *)commandString;
-(void) setEngineVersion:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) setAppVersion:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) compareEngineVersion:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) getEngineUpdate:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) getEngineJS:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) getEngineRecovery:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) getApplicationRecovery:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) installEngine:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) installApplication:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) getMultipleFiles:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) installMultipleFiles:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
-(void) flush:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) flushCommand;
-(void) readConfig:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) setLogFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) setStatusFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) setProgressFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(void) processManager:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;

// Error
-(void) onError:(NSMutableDictionary *)errorDescription;

@end
