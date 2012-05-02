//
//  InAppUpdate.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 21..
//  Copyright 2011 Inswave. All rights reserved.
//
#import "InAppUpdateManager.h"

#ifdef CORDOVA_FRAMEWORK
#import <CORDOVA/CDVPlugin.h>
#import <CORDOVA/NSData+Base64.h>
#endif

@interface InAppUpdate : CDVPlugin {
    InAppUpdateManager *inAppUpdateManager;	//실제 구현부분
}

@property (nonatomic, retain) InAppUpdateManager *inAppUpdateManager;

// Javascript 와 직접 연결되는 외부 공개 API
-(void) ping:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) getFile:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) getFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) patchGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) refreshGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doBackup:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doRestore:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doInitialize:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) engineUpdateGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) engineRestoreGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) applicationUpdateGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) applicationRestoreGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doBackup:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) doRestore:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) initialize:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) isFirstLaunch:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
-(void) copyResource:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) copyLocalResource:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) launch:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) setLogFunction:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) setStatusFunction:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) setProgressFunction:(NSMutableArray*) paramArray withDict:(NSMutableDictionary *)options;
-(void) clean:(NSMutableArray*) paramArray withDict:(NSMutableArray *)options;
-(void) updateFromLocal:(NSMutableArray *) paramArray withDict:(NSMutableDictionary *)options;
@end
