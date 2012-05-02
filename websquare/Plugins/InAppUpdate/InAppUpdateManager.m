//
//  InAppUpdateManager.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 9..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "InAppUpdateManager.h"
#import "PatchFileInfo.h"
#import "HTTPRequest.h"
#import "ZipArchive.h"
#import "FileControlManager.h"
#import "JavascriptControlManager.h"
#import "NetworkControlManager.h"
#import "NSMutableArray+QueueAdditions.h"

@implementation InAppUpdateManager

@synthesize successCallback, failCallback, progressCallback, logCallback;
@synthesize serverURL, currentVersion, isUpdating, jsonMessage, appid, fileSavePath;
@synthesize patchFileInfoList;
@synthesize backupDirectory, websqDirectory, appdataDirectory;
@synthesize currentZipFile, totalZipFile;
@synthesize fileControlManager,javascriptControlManager,networkControlManager;
@synthesize processQueue, processParamArray, processParamOptions;
@synthesize server, startPage, wqStartPage, engineUpdatePolicy, applicationUpdatePolicy, refreshUpdatePolicy, errorPage, wqVersion;
@synthesize logFunction, statusFunction, progressFunction;
@synthesize patchNumber, forcedCopy, DTR;
@synthesize localFiles;

-(id) init 
{
    [super init];
    
    fileControlManager = [[[[FileControlManager alloc] init] retain] autorelease];
    networkControlManager = [[[[NetworkControlManager alloc] init] retain] autorelease];
    javascriptControlManager = [[[[JavascriptControlManager alloc] init] retain] autorelease];
    processQueue = [[[[NSMutableArray alloc] init] retain] autorelease];
    
    [fileControlManager setUpdateManager:self];
    [networkControlManager setUpdateManager:self];
    [javascriptControlManager setUpdateManager:self];
    
    return self;
}

-(void) processManager:(NSMutableArray *)paramArray
{
    [self processManager:paramArray withDict:nil];
}

-(void) processManager:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
   NSString *nextCommand = [processQueue dequeue];
    NSLog(@"command : %@", nextCommand);
    if(nextCommand) {
        //[self setLog:[NSString stringWithFormat:@"Process command : %@", nextCommand]];
    }
    if([nextCommand isEqualToString:@"ping"]) {
        [self ping:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getRefreshFileList"]) {
        [self getRefreshFileList:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"initParameter"]) {
        [self initParameter:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getFile"]) {
        [self getFile:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getFileList"]) {
        [self getFileList:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"launch"]) {
        [self launch:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"copyResource"]) {
        [self copyResource:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"isFirstLaunch"]) {
        [self isFirstLaunch];
    } else if([nextCommand isEqualToString:@"updateConfig"]) {
        [self updateConfig];
    } else if([nextCommand isEqualToString:@"updateStatus"]) {
        [self updateStatus];
    } else if([nextCommand isEqualToString:@"onSuccess"]) {
        [self onSuccess:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"onFail"]) {
        [self onFail:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"setEngineVersion"]) {
        [self setEngineVersion:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"setAppVersion"]) {
        [self setAppVersion:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"compareEngineVersion"]) {
        [self compareEngineVersion:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getEngineUpdate"]) {
        [self getEngineUpdate:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getEngineRecovery"]) {
        [self getEngineRecovery:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getEngineJS"]) {
        [self getEngineJS:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getApplicationRecovery"]) {
        [self getApplicationRecovery:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"getMultipleFiles"]) {
        [self getMultipleFiles:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"installMultipleFiles"]) {
        [self installMultipleFiles:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"installEngine"]) {
        [self installEngine:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"installApplication"]) {
        [self installApplication:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"flush"]) {
        [self flush:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"clean"]) {
        [self clean:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"readConfig"]) {
        [self readConfig:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"setLogFunction"]) {
        [self setLogFunc:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"setProgressFunction"]) {
        [self setProgressFunc:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"setStatusFunction"]) {
        [self setStatusFunc:paramArray withDict:options];
    } else if([nextCommand isEqualToString:@"copyLocalResource"]) {
        [self copyLocalResource:paramArray withDict:options];
    } else if(!nextCommand) {
        //[self setLog:@"operation complete"];
    } else {
        [self setLog:[NSString stringWithFormat:@"command %@ undefined!", nextCommand]];
    }
}


-(void) setLog:(NSString *)msg 
{
    [javascriptControlManager setLog:msg];
}

-(void) writeJavascript:(NSString *)msg
{
    [javascriptControlManager writeJavascript:msg];
}

-(void) initParameter:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    NSUInteger argc = [paramArray count];
    
    self.isUpdating = true;
    
    NSLog(@"argc : %@", [NSNumber numberWithInt:argc]);
    
    if(argc < 1) {
        //@TODO 에러처리
        NSLog(@"No parameter in updateManager");
        [self setLog:@"No parameter in updateManager"];
        self.isUpdating = false;
        return;
    }

    [networkControlManager setServerURL:serverURL];
    [self setLog:[NSString stringWithFormat:@"success callback : %@", [paramArray objectAtIndex:0]]];
    [javascriptControlManager setSuccessCallback:[paramArray objectAtIndex:0]];
    if(argc > 1) {
        [javascriptControlManager setFailCallback:[paramArray objectAtIndex:1]];
    }
    
    [self processManager:nil withDict:nil];
}



-(void) ping:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [networkControlManager setHeader:@"ping"];
    [networkControlManager sendRequest];
}

-(void) getFile:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [networkControlManager setHeader:@"getFile"];
    
    NSString *serverLocation = [paramArray objectAtIndex:0];
    NSString *saveLocation = [paramArray objectAtIndex:1]; 

    [self setLog:[NSString stringWithFormat:@"url : %@, savelocation : %@", serverLocation, saveLocation]];
    
    [networkControlManager sendRequestReturnDataWithFilePath:@"gotResponseSingleFile:" fileURL:serverLocation filePath:saveLocation];
}

-(void) getFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    //[self initParameter:paramArray withDict:options];
    [networkControlManager setHeader:@"checkUpdate"];
    [networkControlManager setJsonMessageObject:[NSString stringWithFormat:@"%d",[self patchNumber]] forKey:@"patchNumber"];
	NSLog(@"patchNumber : %d", [self patchNumber]);
    [networkControlManager sendRequest:@"gotResponseFileList:"];
}

-(void) getRefreshFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    //[self initParameter:paramArray withDict:options];
    [networkControlManager setHeader:@"checkRefreshUpdate"];
    [networkControlManager sendRequest:@"gotResponseRefreshFileList:"];
}

-(void) patchGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    
}

-(void) refreshGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{	
    //[self initParameter:paramArray withDict:options];
    [networkControlManager setHeader:@"checkRefreshUpdate"];
    [jsonMessage setObject:@"1.01" forKey:@"appVersion"];
    [networkControlManager sendRequest:@"gotResponseRefreshFileList:"];
}

-(void) doBackup:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    
}

-(void) doRestore:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    
}

-(void) launch:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *appdataPath = [fileControlManager getDirectoryBasedOnDocumentsDirectory:[self websqDirectory]];
    NSString *xmlPath = [self wqStartPage];
    if(wqStartPage) {
        [javascriptControlManager writeJavascript:[NSString stringWithFormat:@"location.href = '%@%@'",[appdataPath stringByAppendingPathComponent:@"/websquare.html?w2xPath="],xmlPath]];
    } else {
        [javascriptControlManager writeJavascript:[NSString stringWithFormat:@"location.href = '%@'",[appdataPath stringByAppendingPathComponent:@"/websquare.html"]]];
    }
    [self setLog:[NSString stringWithFormat:@"location.href = '%@'",[appdataPath stringByAppendingPathComponent:@"/websquare.html"]]];    
}

-(void) doInstall
{
    
}

-(void) putCommand:(NSString *)commandString
{
    [processQueue enqueue:commandString];
}

-(void) copyEngine:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
        
}

-(void) copyResource:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    //NSString *forced = [paramArray objectAtIndex:0];
    //NSLog(@"forced : %@", forced);
    [self setSuccessCallback:[paramArray objectAtIndex:1]];
    //[fileControlManager resourceCopy:[forced boolValue]];
    [fileControlManager resourceCopyEngine:[self forcedCopy]];
    [fileControlManager resourceCopy:[self forcedCopy]];
    [self processManager:nil withDict:nil];
}

-(void) isFirstLaunch
{
    [fileControlManager isFirstLaunch];
    [self processManager:nil withDict:nil];
}

-(void) updateConfig
{
    [javascriptControlManager updateConfig];
    [self processManager:nil withDict:nil];
}

-(void) updateStatus
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:[fileControlManager getEngineStatus] forKey:@"engineStatus"];
    [dic setObject:[fileControlManager getApplicationStatus] forKey:@"applicationStatus"];
    [[self javascriptControlManager] updateStatus:dic];
    [self processManager:nil withDict:nil];
}

-(void) onSuccess:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [javascriptControlManager onSuccess:[paramArray objectAtIndex:0]];
    [self processManager:nil withDict:nil];
}

-(void) onFail:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *error = [paramArray objectAtIndex:0];
    NSString *errordesc;
    if(!error) {
        errordesc = @"Unknown error";
    } else {
        errordesc = error;
    }
    [[self javascriptControlManager] onFail:errordesc];
    [self processManager:nil withDict:nil];
}

-(void) setEngineVersion:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSError *error = nil;
    NSString *versionString = [NSString stringWithContentsOfFile:    [[fileControlManager getDirectoryBasedOnDocumentsDirectory:[self websqDirectory]] stringByAppendingPathComponent:@"VERSION"] encoding:NSUTF8StringEncoding error:&error];
    NSString *appdatapath = [[self fileControlManager] getDirectoryBasedOnDocumentsDirectory:[self appdataDirectory]];
    NSString *plistpath = [appdatapath stringByAppendingPathComponent:@"hybridConfig.plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistpath];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistpath] || !plistDict) {
        //@TODO Error
    }
    
    if(versionString) {
        [self setWqVersion:versionString];      
        [plistDict setValue:versionString forKey:@"wqVersion"];
    } else {
        [self setWqVersion:@"0"];
        [plistDict setValue:@"0" forKey:@"wqVersion"];
    }
    
    if(![plistDict writeToFile:plistpath atomically:YES]) {
        //@TODO Error
    }
    
    [self setLog:[NSString stringWithFormat:@"websquare version : %@", wqVersion]];
    [self processManager:paramArray withDict:options];
}

-(void) setAppVersion:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *appdatapath = [[self fileControlManager] getDirectoryBasedOnDocumentsDirectory:[self appdataDirectory]];
    NSString *patchInfoPath = [appdatapath stringByAppendingPathComponent:@"META-INF/PATCHINFO.mf"];
	NSString *appVersion = [NSString stringWithFormat:@"%d", [self patchNumber]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error = nil;
	
	[fileManager createDirectoryAtPath:[appdatapath stringByAppendingPathComponent:@"META-INF"] withIntermediateDirectories:YES attributes:nil error:&error];
	if(error) {
		NSLog(@"error : %@", error);
		//@TODO error!
	}			

	[appVersion writeToFile:patchInfoPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	if(error) {
		NSLog(@"error :%@", [error localizedDescription]);
		//@TODO error!
	}
	/*
	NSString *plistpath = [appdatapath stringByAppendingPathComponent:@"hybridConfig.plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistpath];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistpath] || !plistDict) {
        //@TODO Error
    }
    
    [plistDict setValue:[NSString stringWithFormat:@"%d",[self patchNumber]] forKey:@"initialPatchNumber"];

    if(![plistDict writeToFile:plistpath atomically:YES]) {
        //@TODO Error
    }
	 */
    
    [self setLog:[NSString stringWithFormat:@"app version : %d", patchNumber]];
    [self processManager:paramArray withDict:options];
}

-(void) compareEngineVersion:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    
}

-(void) getEngineUpdate:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [networkControlManager setHeader:@"getEngineUpdate"];
    [networkControlManager setJsonMessageObject:[self wqVersion] forKey:@"engineVersion"];
    [networkControlManager setJsonMessageObject:@"iphone" forKey:@"platform"];
    [networkControlManager sendRequest:@"gotResponseEngineFile:"];
}

-(void) getEngineRecovery:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [networkControlManager setHeader:@"getEngineRecoveryFile"];
    [networkControlManager setJsonMessageObject:@"iphone" forKey:@"platform"];
    [networkControlManager sendRequest:@"gotResponseEngineFile:"];
}

-(void) getApplicationRecovery:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [networkControlManager setHeader:@"getApplicationRecoveryFile"];
    [networkControlManager sendRequest:@"gotResponseApplicationFile:"];
}

-(void) installEngine:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *filePath = [paramArray objectAtIndex:0];
    [fileControlManager doInstall:filePath destDirectory:[self websqDirectory]];
}

-(void) installApplication:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *filePath = [paramArray objectAtIndex:0];
    [fileControlManager doInstall:filePath destDirectory:[self appdataDirectory]];
}

-(void) getMultipleFiles:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [networkControlManager getFileFromPatchFileList];    
}

-(void) installMultipleFiles:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [fileControlManager doInstallMultipleFiles:[self patchFileInfoList] destDirectory:[self appdataDirectory]];    
}

-(void) clean:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [fileControlManager directoryDeleteWithoutItself:[fileControlManager getDirectoryBasedOnDocumentsDirectory:@"/"]];
}

-(void) flush:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [self processManager:nil withDict:nil];
}

-(void) flushCommand
{
    [[self processQueue] clearQueue];
}

-(void) getEngineJS:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [networkControlManager setHeader:@"getFile"];
    NSString *serverLocation = [[self serverURL] stringByAppendingPathComponent:@"javascriptHybrid.wq"];
    NSString *saveLocation = [[self websqDirectory] stringByAppendingPathComponent:@"HybridPluginAll.js"]; 
    
    [self setLog:[NSString stringWithFormat:@"url : %@, savelocation : %@", serverLocation, saveLocation]];
    
    [networkControlManager sendRequestReturnDataWithFilePath:@"gotResponseSingleFile:" fileURL:serverLocation filePath:saveLocation];
}

-(void) onError:(NSMutableDictionary *)errorDescription
{
    /*
    NSString *errorMessage = [errorDescription objectForKey:@"msg"];
    NSString *errorPageAddr = [self errorPage];*/
    
}

-(void) readConfig:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if([self appdataDirectory]) {
        rootPath = [[self fileControlManager] getDirectoryBasedOnDocumentsDirectory:[self appdataDirectory]];
    }
    plistPath = [rootPath stringByAppendingPathComponent:@"hybridConfig.plist"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"hybridConfig" ofType:@"plist" inDirectory:@"www"];
    }
    
    //무조건 번들에 있는 plist 우선
    plistPath = [[NSBundle mainBundle] pathForResource:@"hybridConfig" ofType:@"plist" inDirectory:@"www"];
    
    NSLog(@"plistpath : %@", plistPath);
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if(!temp) {
        NSLog(@"Error reading plist : %@, format : %d", errorDesc, format);
    }
    NSDictionary *versionInfo = [temp objectForKey:@"version"];
    NSDictionary *pathInfo = [temp objectForKey:@"directory"];
    [self setBackupDirectory:[pathInfo objectForKey:@"backupDirectory"]];
    [self setWebsqDirectory:[pathInfo objectForKey:@"wqDirectory"]];
    [self setAppdataDirectory:[pathInfo objectForKey:@"workingDirectory"]];
    [self setCurrentVersion:[versionInfo objectForKey:@"AppVersion"]];
    [self setWqStartPage:[temp objectForKey:@"wqStartPage"]];
    [self setStartPage:[temp objectForKey:@"startPage"]];

    patchNumber = [[temp objectForKey:@"initialPatchNumber"] intValue];
    
    [self setErrorPage:[temp objectForKey:@"errorPage"]];
    [self setServerURL:[temp objectForKey:@"server"]];
    [self setForcedCopy:[[temp objectForKey:@"forcedCopy"] boolValue]];
    [self setDTR:[temp objectForKey:@"DTR"]];
    if(![DTR isEqualToString:@"D"] && ![DTR isEqualToString:@"T"] && ![DTR isEqualToString:@"R"]) {
        [self setDTR:@"D"];
    }
    if(!forcedCopy) {
        forcedCopy = false;
    }
    engineUpdatePolicy = [[temp objectForKey:@"engineUpdatePolicy"] boolValue];
    applicationUpdatePolicy = [[temp objectForKey:@"applicationUpdatePolicy"] boolValue];
    refreshUpdatePolicy = [[temp objectForKey:@"refreshUpdatePolicy"] boolValue];
    [self setAppid:[temp objectForKey:@"appID"]];
    currentZipFile = 0;
    totalZipFile = 0;    
    // patch number logic
	NSError *error = nil;
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"www" ofType:nil];
	NSString *local = [[self fileControlManager] getDirectoryBasedOnDocumentsDirectory:[self appdataDirectory]];
	NSString *localVersionFile = [local stringByAppendingPathComponent:@"/META-INF/PATCHINFO.mf"];
	if(![fileManager fileExistsAtPath:localVersionFile]) {
		localVersionFile = [bundle stringByAppendingPathComponent:@"/META-INF/PATCHINFO.mf"];
	}
	NSString *localVersion = [NSString stringWithContentsOfFile:localVersionFile encoding:NSUTF8StringEncoding error:&error];
	
    self.patchNumber = 0;
    if(!error && [localVersion intValue] > 0) {
		NSLog(@" patch number : %d", [localVersion intValue]);
        self.patchNumber = [localVersion intValue];
    } 

    [self processManager:paramArray withDict:options];
}

-(void) setLogFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *functionName = [paramArray objectAtIndex:0];
    if(functionName) {
        [self setLogFunction:functionName];
    }
    [self processManager:paramArray withDict:options];
}

-(void) setProgressFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *functionName = [paramArray objectAtIndex:0];
    if(functionName) {
        [self setProgressFunction:functionName];
    }
    [self processManager:paramArray withDict:options];
}

-(void) setStatusFunc:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSString *functionName = [paramArray objectAtIndex:0];
    if(functionName) {
        [self setStatusFunction:functionName];
    }
    [self processManager:paramArray withDict:options];
}


@end
