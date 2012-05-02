//
//  FileControlManager.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"
#import "InAppUpdateManager.h"

@interface FileControlManager : NSObject<ZipArchiveDelegate> {
    
}

@property (nonatomic) int currentZipFile;
@property (nonatomic) int totalZipFile;
@property (nonatomic, retain) NSMutableDictionary *progressData;
@property (nonatomic, retain) InAppUpdateManager *updateManager;

// fileCompare 에서 사용하는 방법들을 enum으로 정의함. MD5, SHA1, filesize(bytes) 정도?
typedef enum {
    IAUCompareMD5 = 0,
    IAUCompareSHA1,
    IAUCompareFileSize
} IAUCompareMode;

// fileCompare 한 결과가 , 두 파일이 서로 다르다 / 같다 이므로 enum으로 정의함. 그냥 Boolean 써도 될꺼같기도 한데....
typedef enum {
    IAUCompareResultFileSame = 0,
    IAUCompareResultFileDifferent
} IAUCompareResult;


-(BOOL)unZip:(ZipArchive *)zipArchive sourceDirectory:(NSString *)filePath destDirectory:(NSString *)destDirectory;
-(BOOL)directoryDelete:(NSString *)directoryPath;
-(BOOL)fileDelete:(NSString *)filePath;
-(BOOL)directoryDeleteWithoutItself:(NSString *)directoryPath;
-(BOOL)directoryCopy:(NSString *)fromPath dest:(NSString *)toPath;
-(void) doInstall:(NSString *)filePath destDirectory:(NSString *)destPath;
-(void) doInstallMultipleFiles:(NSArray *)filePathArray destDirectory:(NSString *)destPath;
-(NSString *) getDirectoryBasedOnDocumentsDirectory:(NSString *)path;
-(void)copyProcessing:(NSString *)destPath;
-(void)copySuccess:(NSString *)destPath;
-(void) getAppDataDirectory:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options;
-(NSString *) getEngineStatus;
-(NSString *) getApplicationStatus;
-(void) resourceCopy:(BOOL)forced;
-(void) resourceCopyEngine:(BOOL)forced;
-(void) isFirstLaunch;
-(double) getFileSize:(NSString *)filepath;
-(void) processDeleteManifest;

-(void) ErrorMessage:(NSString*) msg;
-(BOOL) OverWriteOperation:(NSString*) file;
-(void) UnzipProgress:(uLong)myCurrentFileIndex total:(uLong)myTotalFileCount;

-(void) callProcessManager:(NSMutableArray*) paramArray;

-(IAUCompareResult) fileCompare:(NSString *)sourceFilePath with:(NSString *)destFilePath mode:(IAUCompareMode)mode;

@end
