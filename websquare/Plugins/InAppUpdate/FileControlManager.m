//
//  FileControlManager.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "FileControlManager.h"
#import "JavascriptControlManager.h"
#import "ZipArchive.h"

@implementation FileControlManager
@synthesize currentZipFile, totalZipFile;
@synthesize updateManager;
@synthesize progressData;

/**
 패치용 파일간 비교 함수. md5, sha1, 파일 크기 등의 방법을 이용하여 두 파일이 동일한 파일인지, 다른 파일인지(업데이트가 필요한지)를 판정한다. mode및 파일 같음/다름 여부를 나타내기 위한 enum으로 IAUCompareResult와 IAUCompareMode를 사용한다(FileControlManager.h에 정의함). 기본적으로는 두 파일이 다름(IAUCompareResultFileDifferent)을 리턴함. destFilePath가 존재하지 않거나 해당 위치에 파일이 없을 경우, 항상 업데이트가 필요하다는 취지로 IAUCompareResultFileDifferent를 반환.
 @param (NSString *)sourceFilePath 
    원본 파일의 경로. 일반적으로 복사를 하고자 하는 Bundle App에 포함된 파일
 @param (NSString *)destFilePath 
    목적 파일의 경로. 일반적으로 덮어쓰고자 하는 AppData dir의 파일
 @param (IAUCompareMode)mode 
    MD5, SHA1, 파일크기 중 사용할 비교 방법
 @returns IAUCompareResult 
    두 파일이 다를 경우 IAUCompareResultFileDifferent, 같을 경우 IAUCompareResultFileSame을 리턴
 @exception 
    sourceFilePath가 없거나 파일이 존재하지 않을 경우 FileException 날 수 있음
 */
-(IAUCompareResult) fileCompare:(NSString *)sourceFilePath with:(NSString *)destFilePath mode:(IAUCompareMode)mode
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *destCode, *sourceCode;                    
    NSDictionary *sourceFileAttr, *destFileAttr;
    NSError *error = nil;
    UInt32 sourceFileSize, destFileSize;
    
    if(![fileManager fileExistsAtPath:sourceFilePath]) { // bundle file not exist(error)
        //@TODO Error
    }
    if(![fileManager fileExistsAtPath:destFilePath]) // file does not exist
    {
        return IAUCompareResultFileDifferent;
    }
    switch(mode) {
        case IAUCompareMD5 : //MD5
            destCode = [[NSData dataWithContentsOfFile:destFilePath] md5];
            sourceCode = [[NSData dataWithContentsOfFile:sourceFilePath] md5];
            NSLog(@" destMD5 : %@ sourceMD5 : %@", destCode, sourceCode);		//
            if([destCode isEqualToString:sourceCode]) {
                return IAUCompareResultFileSame;
            }
            return IAUCompareResultFileDifferent;
            break;
        case IAUCompareSHA1 : //SHA1
            destCode = [[NSData dataWithContentsOfFile:destFilePath] sha1];
            sourceCode = [[NSData dataWithContentsOfFile:destFilePath] sha1];
            NSLog(@" destSHA1 : %@ sourceSHA1 : %@", destCode, sourceCode);
            if([destCode isEqualToString:sourceCode]) {
                return IAUCompareResultFileSame;
            }
            return IAUCompareResultFileDifferent;
            break;
        case IAUCompareFileSize : //FileSize
            sourceFileAttr = [fileManager attributesOfItemAtPath:sourceFilePath error:&error];	
            if(error) {	
                NSLog(@"from attribute error : %@", [error description]);
            }
            error = nil;
            destFileAttr = [fileManager attributesOfItemAtPath:destFilePath error:&error];
            if(error) {
                NSLog(@"from attribute Error! : %@", [error description]);
            }
            error = nil;
            sourceFileSize = [sourceFileAttr fileSize];
            destFileSize = [destFileAttr fileSize];
            NSLog(@" destFileSize : %ld sourceFileSize : %ld ", sourceFileSize, destFileSize);	// 로그찍는거 생각보다 오래걸림
            if(destFileSize == sourceFileSize) {
                return IAUCompareResultFileSame;
            } else {
                return IAUCompareResultFileDifferent;
            }
            break;
        default :
            return IAUCompareResultFileDifferent;
    }
}

/**
 FileControlManager용 init함수
 @param 없음
 @returns id
    객체 object 포인터 리턴
 @exception 없음
 */
-(id) init
{
    progressData = [[NSMutableDictionary alloc] init];
    [self setProgressData:progressData];
    
    return [super init];
}

/**
 현재 사용하지 않음
 AppData dir의 위치를 javascript에 통지하기 위한 함수. javascriptControlManager를 이용하여 javascript의 window.AppDataDirectory 변수에 AppData dir의 절대경로를 저장
 @param (NSMubtableArray *)paramArray
    Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
    Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) getAppDataDirectory:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{ 
	NSString *appDataDirectoryPath = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
	// @TODO : AppDataDirectory와 같은 변수이름들은 바뀔 수 있으므로 javascript 영역에서 처리하게 하거나 변수로 빼 놓는 것이 좋을듯
	NSString *returnString = [NSString stringWithFormat:@"window.AppDataDirectory = '%@'", appDataDirectoryPath]; 
	[[updateManager javascriptControlManager] writeJavascript:returnString];	//javascriptControlManager에서 returnString 전달
	
	/*
	 아래처럼 쓰는 것보다는 위처럼 단계를 나누어 주는 것이 코드 읽기가 편하다. 일반적으로 2~3단계 이상 넘어가지 않는 것을 권장
    [[updateManager javascriptControlManager] writeJavascript:[NSString stringWithFormat:@"window.AppDataDirectory = '%@'",[self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]]]]; 
	 */
    NSLog(@"callback : %@", [NSString stringWithFormat:@"window.AppDataDirectory = '%@'",[updateManager appdataDirectory]]);
}

/**
 주어진 상대경로 또는 절대경로를 App의 Document Directory를 중심으로 한 상대경로로 해석하여 실제 파일시스템에서 사용할 수 있는 절대경로를 리턴
 @param (NSString *)path
    경로값. 일반적으로 "/appdata/websquare/websquare.html"과 같이 개념상의 절대경로(마치 서버에서의 절대경로와 흡사)가 들어오는 경우가 많다. 이 함수를 통해 실제 파일시스템에서 해당 경로를 어디에 위치시키는지 결정하는데, 일반적으로 각 App 마다 마련된 Documents dir을 사용한다.
 @returns NSString
    Documents dir을 기준으로 변환된 절대경로."/appdata/websquare/websquare.html" 같은 경로를 "/Users/administrator/Library/Application Support/iPhone Simulator/5.1/Applications/BBA10C66-06F3-4574-B19F-3A48B7B9AB73/Documents/appdata/websquare/websquare.html" 과 같이 변환함.
 @exception 없지않나싶다
 */
-(NSString *) getDirectoryBasedOnDocumentsDirectory:(NSString *)path
{
	//아래 두 줄은 Documents dir 경로를 구하기 위한 일종의 패턴
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    if(!path) {
        path=@"/"; //경로에 null string이 들어오면 루트 경로, 즉 Document dir의 절대경로를 리턴함
    }
    return [documentsDirectory stringByAppendingPathComponent:path];
}

/**
 zipArchive 라이브러리를 이용해서 filePath에 지정한 zip 압축파일을 destDirectory로 풀어주는 단순한 기능모듈함수.
 @param (ZipArchive *)zipArchive
	압축해제에 사용할 zipArchive 객체
 @param (NSString *)filePath
	압축을 해제할 압축파일의 경로(실제 파일시스템 상의 절대경로여야 함)
 @param (NSString *)destDirectory
	압축을 해제해서 가져다놓을 dir 경로(실제 파일시스템 상의 절대경로여야 함)
 @returns BOOL
	압축을 정상해제했는지 여부인데...에러처리를 따로 해야 하나?
 @exception 
	zip 파일 풀다가 에러 나올수 있음. ret을 보면 알 수 있을텐데 정확한 에러코드같은것은 못받아옴.
 */
-(BOOL)unZip:(ZipArchive *)zipArchive sourceDirectory:(NSString *)filePath destDirectory:(NSString *)destDirectory
{
    if([zipArchive UnzipOpenFile:filePath]) {
        NSLog(@"total file : %d", [[zipArchive getZipFileContents] count]); // ZipFileContents의 count를 읽어서 파일 개수를 알 수 있다. Progress찍을때 요긴할듯
        BOOL ret = [zipArchive UnzipFileTo:destDirectory overWrite:YES];	// 실제로 압축푸는 부분
        if(NO == ret){
			// @TODO 에러처리 필요
            NSLog(@"Unzip error!");
        }
        [zipArchive UnzipCloseFile];
    } else {
        return FALSE;
    }
    return TRUE;
}

/**
 updateManager의 프로제스 플로우 제어함수인 processManager를 호출하기 위해 한번 싸 놓은 함수. 쓰는 데가 딱히 없으면 지워도 될듯. 쓰레드 하면서 썼던 것 같은데...
 @param (NSMubtableArray *)paramArray
	processManager 호출 Spec에 따른 API parameter 배열
 @returns 없음
 @exception 없음
 */
-(void) callProcessManager:(NSMutableArray *)paramArray
{
    [updateManager processManager:paramArray];
}

/**
 파일 하나만 설치하는 함수로 앱 리커버리나 엔진 업데이트, 리커버리를 탔을 경우에 실행됨. 파일이 여러개일 경우는 아래 doInstallMultipleFiles 참조. install이 말은 거창하지만 실제 하는 일은 순서대로 압축 풀고 sucess 복사해 넣는 일이 다임. 다만 처리상황 업데이트 및 UI thread가 반응이 없는 경우를 방지하기 위해서 Grand Central Dispatch 라는 테크닉을 이용해 thread 처리를 해 준다. iOS 4.0 이상에서만 지원됨.
 @param (NSString *)filePath
	패치과정을 통해 다운받은 압축 패치파일의 경로. 실제 파일시스템에서 사용하는 절대경로 필요.
 @param (NSString *)destPatch
	패치파일을 설치할 위치로 Spec상 AppData dir의 경로가 들어온다. Appdata를 root로 하는 상대경로 필요(@TODO 이건 위랑 맞출 필요 있을듯)
 @returns 없음
 @exception
	각종 file error 및 zip error 가능성이 있음. onFail 처리해줌.
 */
-(void) doInstall:(NSString *)filePath destDirectory:(NSString *)destPath
{
    ZipArchive *za = [[[ZipArchive alloc] init] retain];
    [za setDelegate:self];
    [[self progressData] setObject:[filePath lastPathComponent] forKey:@"name"];
    dispatch_queue_t queue = dispatch_queue_create("inswave.fileoperation", NULL);	// file operation에 사용할 thread
    dispatch_queue_t main = dispatch_get_main_queue();								// main ui thread
    //dispatch_group_t group = dispatch_group_create();
    NSLog(@" install file : %@ path : %@", filePath, destPath);
    dispatch_async(queue, ^{				// objective c의 block ^{ } 으로 묶인 코드를 queue (다른 thread) 에서 실행
        [self copyProcessing:destPath];		// PROCESSING 이라는 빈 파일을 destPath에 미리 옮겨놓음
        if([self unZip:za sourceDirectory:filePath destDirectory:[self getDirectoryBasedOnDocumentsDirectory:destPath]]) {
			// 실제 unZip 함수를 통해 압축해제. 성공할 경우 PROCESSING 지우고 SUCCESS 빈 파일 복사함
            [self copySuccess:destPath];
            [self fileDelete:filePath];        // 할 일을 다한 패치 zip 파일 지워줌
            dispatch_async(main, ^{			   // main thread에서 다음 작업을 호출하기 위해 processManager 콜
                [updateManager processManager:nil withDict:nil];            
            });
        } else {
            dispatch_async(main, ^{
				// 에러나면 일어나는 3단콤보. flushCommand를 불러서 여태까지 CommandQueue에 저장되어 있던 미 실행 명령들을 다 날리고 onFail만 추가. processManager의 parameter 전달 spec에 따라 에러메시지와 함께 processManager 호출 -> processManager에서 onFail 실행
                [updateManager flushCommand];
                [updateManager putCommand:@"onFail"];
                [updateManager processManager:[NSMutableArray arrayWithObject:@"unzip file error"] withDict:nil];            
            });
        }
        
    });     
}

/**
 AppUpdate를 타서 여러개의 patch파일을 받아왔을 때 순차적으로 설치하는 함수. Recovery를 통해 하나만 설치할 경우는 doInstall 참조. Install이 말은 거창하지만 실제로 압축 풀고 sucess 복사하는 일이 다임.  다만 처리상황 업데이트 및 UI thread가 반응이 없는 경우를 방지하기 위해서 Grand Central Dispatch 라는 테크닉을 이용해 thread 처리를 해 준다. iOS 4.0 이상에서만 지원됨.
 @param (NSArray *)filePathArray
	다운받은 패치파일들의 경로 및 메타정보를 저장하고 있는 배열. PatchFileInfo 객체의 배열임.
 @param (NSArray *)destPath
	패치파일을 설치할 위치로 Spec상 AppData dir의 경로가 들어온다. Appdata를 root로 하는 상대경로 필요(@TODO 이건 위랑 맞출 필요 있을듯)
 @returns 없음
 @exception 
	각종 file error, zip error 가능성 있음. onFail 처리해줌.
 */
-(void) doInstallMultipleFiles:(NSArray *)filePathArray destDirectory:(NSString *)destPath
{
    NSArray *sortedArray;
    
    if(!filePathArray || ![filePathArray objectAtIndex:0]) {
        //@TODO : Error!
    }
    
    if([[filePathArray objectAtIndex:0] patchnumber]) {			// filePatchArray를 patchNumber 순서대로 소팅함
        NSLog(@"sort");
        sortedArray = [filePathArray sortedArrayUsingComparator:^(id a, id b) {		// lambda 함수 (함수명 없음)
            NSNumber *first = [NSNumber numberWithInt:[(PatchFileInfo*)a patchnumber]];	// 소팅로직 정의. patchNumber끼리 비교하게 함
            NSNumber *second = [NSNumber numberWithInt:[(PatchFileInfo*)b patchnumber]];
            return [first compare:second];
        }];
    } else {
        sortedArray = filePathArray;
    }
    NSLog(@"sorted Array : %d", [sortedArray count]);
    [sortedArray retain];		// sortedArray를 미리 retain해놓지 않으면 쓰레드 타면서 메모지 해제되는 경우 있음. 메모리 관련 코드는 한번 나중에 다시 볼 필요 있음
    ZipArchive *za = [[[ZipArchive alloc] init] retain];	// zip 압축해제용 ZipArchive 객체. 역시 미리 retain해놓음
    [za setDelegate:self];	// ZipArchive에서 진행상황 업데이트를 위해 설정한 Delegate를 현재 FileControlManager 객체로 해 놓고 여기에서 처리함
    dispatch_queue_t queue = dispatch_queue_create("inswave.fileoperation", NULL);	// file operation에 사용할 thread
    dispatch_queue_t main = dispatch_get_main_queue();								// main ui thread
    dispatch_async(queue, ^{
        NSLog(@"sorted Array : %d", [sortedArray count]);			//일단 array가 파싱되서 잘 들어왔는지 파일개수 찍어봄.
        for(int i = 0; i < [sortedArray count]; i++) {
			// lastPathComponent 하면 말 그대로 경로의 마지막 구성인자, 디렉토리면 디렉토리명, 파일이면 파일명이 나온다. 이걸 progressData에 써줌.
            [[self progressData] setObject:[[[sortedArray objectAtIndex:i] name] lastPathComponent] forKey:@"name"];
            [self copyProcessing:destPath];	// PROCESSING 파일 복사
            [self unZip:za sourceDirectory:[[sortedArray objectAtIndex:i] filePath] destDirectory:[self getDirectoryBasedOnDocumentsDirectory:destPath]];	//실제 zip 압축해제하는 곳 @TODO filePath 없으면 어쩌지?
            [self processDeleteManifest];						// DELETE.mf 처리용 추가코드
            [self copySuccess:destPath]; // PROCESSING지우고 SUCCESS 파일 복사
            [self fileDelete:[[sortedArray objectAtIndex:i] filePath]];	// 할일 끝낸 패치 파일 삭제
        }
        dispatch_async(main, ^{
            [za release];		// 할꺼 다했으면 ZipArchive객체 풀어줌. @TODO 에러났으면 어쩌지?
            [updateManager processManager:nil withDict:nil];            
        });
    });        
}

/**
 일반적인 dir to dir 복사함수. Cocoa framwork에서 파일 overwrite 복사가 없기 때문에 한번 지우고 그 자리에 복사.
 @param (NSString *)fromPath
	복사할 원본 dir 경로. 실제 파일시스템에서 사용하는 절대경로 필요.
 @param (NSString *)fromPath
	복사할 목적 dir 경로. 실제 파일시스템에서 사용하는 절대경로 필요.
 @returns BOOL
	성공 실패 여부인데...이결로 뭘 처리하지는 않는듯....허술함....
 @exception 
	디렉토리 카피 중 에러날수 있음. @TODO 로그만 찍고 끝내지 말고 onFail 처리 필요할듯
 */
-(BOOL)directoryCopy:(NSString *)fromPath dest:(NSString *)toPath
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;	// if(error) 와 같이 처리하려면 초기값으로 nil 꼭 넣어줘야 함(한번 피봄 ㅠㅠ)
    NSLog(@"directory copy from : %@ to : %@", fromPath, toPath);
    [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:&error];	//fromPath는 항상 존재한다고 치고 (@TODO 정말?) 목표 dir의 부모 dir이 존재하지 않을 경우 존재하지 않습니다 에러가 뜸. 방지 위해 아래에서 지우더라도 일단 만들어주고 시작.
    [self directoryDelete:toPath];	// 목적 dir 삭제
    success = [fileManager copyItemAtPath:fromPath toPath:toPath error:&error];
    if(success != YES || error){
        NSLog(@"Error : %@",[error description] );   // @TODO onFail 처리
    }	
    return success;
    
}

/**
 엔진 빼놓고 bundle에 포함된 리소스 전체를 복사하는 함수. 걍 단순한 directoryCopy 함수만 쓰다가 bundle resource copy 기능 spec이 정해지면서 엔진 복사 / App 복사로 리소스 복사 스텝을 나눌 필요성이 생김. 이 함수는 그 중 App 복사. 예전과 달리 App 실행시마다 항상 실행
 @param (NSString *)fromPath
	복사할 원본 dir 경로. app bundle의 www dir의 파일시스템 상에서 사용되는 절대경로가 들어오는 것이 일반적임. 
 @param (NSString *)toPath
	복사할 목적 dir 경로. local app document dir의 appdata 경로가 파일시스템 상에서 사용되는 절대경로로 들어오는 것이 일반적임
 @returns BOOL
	성공실패 여부인데 역시 엄밀하지 않음. 
 @exception 
	파일에러 날 수 있음. onFail 처리 필요
 */
-(BOOL)directoryCopyWithoutEngine:(NSString *)fromPath dest:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *de = [fileManager enumeratorAtPath:fromPath];	// 이걸로 bundle의 www dir enumerator(iterator)얻어옴
    NSString *file;
    NSString *filePath;
    NSString *destFilePath;
    NSError *error = nil;
    BOOL isDir;
    NSLog(@" from : %@ to : %@", fromPath, toPath);
	// toPath 존재하지 않으면 또 에러뱉을까봐 일단 한번 만들어줌
    [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:&error];
    NSDate *date = [NSDate date];		// 시간계산 위해 현재시간 받아놓기
    while((file = [de nextObject])) {	// bundle 파일 기준으로 순회
        error = nil;	// 에러 초기화 꼭 필요
		// 같은 이름을 경로에 붙여줌. depth가 내려가면 디렉토리명도 붙어서 나오기 때문에 이것으로 충분함. 상대경로로 나오니까 미리 준비된 toPath, fromPath 사용함.
        filePath = [fromPath stringByAppendingPathComponent:file];	
        destFilePath = [toPath stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:filePath isDirectory:&isDir];		// 존재체크와 dir 체크를 한번에
        if(!isDir) { // 파일일 경우     
            BOOL isDestExist = [fileManager fileExistsAtPath:destFilePath];	// 복사될 위치에 파일이 존재하는가?
            if(isDestExist) {	// 존재하면 fileCompare를 통해 같은 파일인지 검사
                if([self fileCompare:filePath with:destFilePath mode:IAUCompareMD5] == IAUCompareResultFileSame) {
                    continue;	// 같은 파일이면 이번은 패쓰
                } 
                [fileManager removeItemAtPath:destFilePath error:&error]; // 같은 파일 아니면 일단 삭제
                if(error) {
                    NSLog(@"remove error : %@", [error localizedDescription]);	//@TODO onFail
                }
            }             
            [fileManager copyItemAtPath:filePath toPath:destFilePath error:&error];	//dest가 존재하지 않아도 파일복사해야하니까 복사코드는 여기로 뺌
            NSLog(@"copying file : %@", file);
            if(error) {
                NSLog(@"copy error : %@", [error localizedDescription]);//@TODO onFail
            }
        } else {	//
            if([file isEqualToString:@"websquare"]) {	// dir 이름이 websquare면 그 아래 전부 패쓰
                [de skipDescendents];
            }
            if(![fileManager fileExistsAtPath:destFilePath]) {	// dir이 존재하지 않으면 만들어놓기
                NSLog(@"Creating Dir");
                [fileManager createDirectoryAtPath:destFilePath withIntermediateDirectories:YES attributes:nil error:&error];
            }
        }
    }
    NSTimeInterval elapsed = [date timeIntervalSinceNow] * -1000.0;		// ms 단위로 시간계산하는 코드
    NSLog(@"total time : %f", elapsed);
    return true;
}

/**
 디렉토리 삭제용 단순작업함수
 @param (NSString *)directoryPath
	삭제할 디렉토리명
 @returns BOOL
	삭제 성공여부
 @exception 
	삭제 실패시 에러처리가 부족함
 */
-(BOOL)directoryDelete:(NSString *)directoryPath
{
    BOOL success;
    NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    NSError *error = nil;
    NSLog(@"delete directory : %@", directoryPath);
    success = [fileManager removeItemAtPath:directoryPath error:&error];
	if(error) {
		// @TODO 에러처리 필요
	}
    return success;
}

/**
 파일삭제용 단순작업함수. Cordova 구현코드보고 약간 에러처리 로직을 만들어놓음.
 @param (NSString *)filePath
	삭제할 파일의 경로. 실제 파일시스템에서 사용하는 절대경로.
 @returns BOOL
	삭제성공여부
 @exception 
	NoSuchFileError, WriteNoPermissionError 있을 수 있음
 */
-(BOOL)fileDelete:(NSString *)filePath
{
    NSError *error;
    BOOL successStatus;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    successStatus = [fileManager removeItemAtPath:filePath error:&error];
    
    if(successStatus) {
        return YES;
    } else {
        if([error code] == NSFileNoSuchFileError) {		// @TODO onFail 처리 필요
            NSLog(@"No File");
        } else if([error code] == NSFileWriteNoPermissionError) {
            NSLog(@"No permission");
        }
        return NO;
    }
}

/**
 Debug용 clean 함수에서 실행. Documents dir 전체를 삭제하지만 Documents dir 자기 자신을 삭제해서는 안되기 때문에 WithoutItself를 붙여 스스로는 지우지 않음을 표시하였음. clean 함수 외에는 사용하는 곳이 없음.
 @param (NSString *)directoryPath
	삭제할 dir 경로. 실제 파일시스템에서 사용되는 절대경로이어야 한다. 일반적으로 App의 Documents dir을 인자로 받음
 @returns BOOL
	삭제 성공/실패 여부. 하지만 에러처리는 안되는듯
 @exception 
	파일 에러날수 있음 @TODO 에러처리 필요
 */
-(BOOL)directoryDeleteWithoutItself:(NSString *)directoryPath
{
    NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    NSError *error = nil;
    NSLog(@"delete directory without itself: %@", directoryPath);
    for(NSString *file in [fileManager contentsOfDirectoryAtPath:directoryPath error:&error]) {
        BOOL success = [fileManager removeItemAtPath:[directoryPath stringByAppendingPathComponent:file] error:&error];
        if(!success || error) {
            NSLog(@"delete directory without itself error");
        }        
    }
    return YES;
}

/**
 ZipArchive의 Delegate로 설정해 주면 에러시에 호출됨.
 @param (NSString *)msg
	표시되는 에러메시지
 @returns 없음
 @exception 없음
 */
-(void) ErrorMessage:(NSString*) msg
{
    NSLog(@" zip error : %@", msg);
}

/**
 ZipArchive의 Delegate로 설정해 주면 파일 overwrite상황이 발생할때 호출됨.
 @param (NSString *)file
	overwrite 상황이 발생한 파일 상대 경로
 @returns BOOL
	YES면 overwrite실행, NO면 안함
 @exception 없음
 */
-(BOOL) OverWriteOperation:(NSString*) file
{
    NSLog(@" overwriting : %@", file);
    return YES;
}

/**
 ZipArchive의 Delegate로 설정해 주면 압축과정에서 파일 하나 쓸때마다 호출됨. 기본적으로 아래와 같이 현재 파일 index / 총 파일수 의 형식으로 argument를 주기 때문에 비율 계산해서 진행률을 표시하는 데에 사용함. zip 압축해제과정은 main과 별개의 thread에서 일어나기 때문에 Grand Central Dispatch로 main thread를 얻어와서 뿌려줘야 progress 업데이트가 가능. 사실 이 함수는 ZipArchive 오리지널 소스는 아니며, ZipArchive 프로젝트 페이지의 누군가가 제공해준 기능ㅠㅠ
 @param (uLong)myCurrentFileIndex
	현재 파일 index
 @param (uLong)myTotalFileCount
	전체 파일 개수(index라고 해도 될듯)
 @returns 없음
 @exception 없음
 */
-(void) UnzipProgress:(uLong)myCurrentFileIndex total:(uLong)myTotalFileCount
{
	/* progressData라는 임의의 객체를 만들어 spec을 잡아 전달함 이 객체는
		message : javascript로 전달되어 표시될 message(@TODO 변수로 뺄 필요 있음)
		progress : 현재 진행률. [현재 파일 / 총 파일]의 분수값으로 전달함
	 으로 이루어져 있음 */
    [[self progressData] setObject:[NSNumber numberWithDouble:((double)myCurrentFileIndex / (double)myTotalFileCount)] forKey:@"progress"];
    [[self progressData] setObject:@"설치중" forKey:@"message"];    
    [[self progressData] retain];
    
    dispatch_queue_t main = dispatch_get_main_queue();	// main thread 가져옴
    dispatch_retain(main);
    dispatch_async(main, ^{
        [[updateManager javascriptControlManager] setProgress:[[self progressData] JSONRepresentation]]; // javascript에 JSON String으로 전달해야 하므로 Dictionary를 JSON으로 변환하여 setProgress함수를 통해 String전달
		[[self progressData] release];
    });
    dispatch_release(main);
}

/**
 각종 작업 수행시 크기가 없는 PROCESSING, SUCCESS 파일을 dir안에 생성하여 그 파일의 존재 유무를 보고 상태를 판단한다. 이 함수는 그 중 SUCCESS파일을 생성하기 위한 함수로, PROCESSING파일이 있을 경우 해당 파일을 삭제하고 SUCCESS파일을 생성함.
 @param (NSString *)destPath
	SUCCESS파일을 생상헐 경로. Document Directory를 root로 한 상대경로를 받는다
 @returns BOOL
	성공 실패 여부를 BOOL로 리턴
 @exception 
	파일에러 가능	
 */
-(void)copySuccess:(NSString *)destPath
{
    NSString *success = @"SUCCESS";
    NSError *error = nil;
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:destPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/PROCESSING"]]) {
        [fileManager removeItemAtPath:[destination stringByAppendingPathComponent:@"/PROCESSING"] error:&error];
        if(error) {
            NSLog(@"file delete error : %@", [error description]);
            return;
        }
    }
    [success writeToURL:[NSURL fileURLWithPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"filename : %@", [destination stringByAppendingPathComponent:@"/SUCCESS"]);
    if(error) {
        NSLog(@"file create error : %@", [error description]);
        return;
    }
}

/**
 각종 작업 수행시 크기가 없는 PROCESSING, SUCCESS 파일을 dir안에 생성하여 그 파일의 존재 유무를 보고 상태를 판단한다. 이 함수는 그 중 PROCESSING파일을 생성하기 위한 함수임.
 @param (NSString *)destPath
	PROCESSING파일을 생성할 경로. Document Directory를 root로 한 상대경로를 받는다
 @returns BOOL
	성공 실패 여부를 BOOL로 리턴
 @exception 
	파일에러 가능
 */
-(void)copyProcessing:(NSString *)destPath
{
    NSString *processing = @"PROCESSING";
    NSError *error = nil;
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:destPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/PROCESSING"]]) {
        [fileManager removeItemAtPath:[destination stringByAppendingPathComponent:@"/PROCESSING"] error:&error];
        if(error) {
            NSLog(@"file delete error : %@", [error description]);
            return;
        }
    }
    if([fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]]) {
        [fileManager removeItemAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"] error:&error];
        if(error) {
            NSLog(@"file delete error : %@", [error description]);
            return;
        }	
    }
    BOOL isDir = NO;
    if(![fileManager fileExistsAtPath:destination isDirectory:&isDir]) {
        if(![fileManager createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:&error]){
            NSLog(@"creating folder failed %@", destination);
        }
    }
    [processing writeToURL:[NSURL fileURLWithPath:[destination stringByAppendingPathComponent:@"/PROCESSING"]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"filename : %@", [destination stringByAppendingPathComponent:@"/PROCESSING"]);
    if(error) {
        NSLog(@"file create error : %@", [error description]);
        return;
    }
}

/**
 Bundle에 있는 리소스를 App에서 사용하는 Documents 로 복사해오는 기능(엔진 제외). 새로 spec을 정의한 DTR 모드에 따라 다르게 동작한다. D모드일 경우 sd5, sha1 등의 알고리즘을 이용하여 동일파일인지 비교한 뒤 복사하고, TR모드일 경우는 PATCHINFO.mf에서 버전정보를 읽어와 비교한 뒤 복사함.
 @param (BOOL)forced
	강제복사여부. forced가 YES(true)일 경우 버전비교결과 등에 상관없이 복사가 이루어짐
 @returns 없음
 @exception 
	없음(안쪽 함수에서 파일에러 가능)
 */
-(void) resourceCopy:(BOOL)forced
{
    NSString *success = @"SUCCESS";
    NSError *error = nil;
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
    NSString *source = [[NSBundle mainBundle] pathForResource:@"www" ofType:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
	// Bundle과 Local의 버전정보
    NSString *destinationVersionFile = [destination stringByAppendingPathComponent:@"/META_INF/PATCHINFO.mf"];
    NSString *sourceVersionFile = [source stringByAppendingPathComponent:@"/META_INF/PATCHINFO.mf"];

    if([[updateManager DTR] isEqualToString:@"D"]) { // D(Developer) 모드
        NSLog(@"Resource copy mode D");
		// 실제 Copy는 directoryCopyWithoutEngine으로 
        [self directoryCopyWithoutEngine:[[NSBundle mainBundle] pathForResource:@"www" ofType:nil] dest:destination];
        [success writeToURL:[NSURL fileURLWithPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]] atomically:YES encoding:NSUTF8StringEncoding error:&error];        
    } else { // T(Test), R(Release) 모드
        NSLog(@"Resource copy mode T, R");
        if(!sourceVersionFile) { // 소스 버전파일(Bundle)이 없으면 정상적인 App resource가 아니라고 판단하고 복사 로직 안타게 함
            return;
        }
        NSString *destinationVersion = [NSString stringWithContentsOfFile:destinationVersionFile encoding:NSUTF8StringEncoding error:&error];
        NSString *sourceVersion = [NSString stringWithContentsOfFile:sourceVersionFile encoding:NSUTF8StringEncoding error:&error];
		// 경우의 수는 1. local 위치에 SUCCESS파일이 없거나(local에 있는 리소스가 정상이 아니라고 판단) 2. forceCopy이거나 3. 패치버전이 차이날 경우
        if(![fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]] 
		   || forced
           || [destinationVersion compare:sourceVersion] == NSOrderedDescending) {        
			// 실제 Copy는 directoryCopyWithoutEngine으로 
            [self directoryCopyWithoutEngine:[[NSBundle mainBundle] pathForResource:@"www" ofType:nil] dest:destination];
            [success writeToURL:[NSURL fileURLWithPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
        }
    }
}

/**
 Bundle에 있는 엔진 리소스를 App에서 사용하는 Documents 로 복사해오는 기능(엔진만). DTR여부에 상관없이 항상 버전비교 후 더 최신의 버전이 Bundle에 있을 경우 해당 엔진으로 복사함.
 @param (BOOL)forced
	강제복사여부. forced가 YES(true)일 경우 버전비교결과 등에 상관없이 복사가 이루어짐
 @returns 없음
 @exception 
	파일에러 가능
 */
-(void) resourceCopyEngine:(BOOL)forcedCopy
{
    NSString *success = @"SUCCESS";
    NSError *error = nil;
    NSString *destinationWebSq = [self getDirectoryBasedOnDocumentsDirectory:[updateManager websqDirectory]];
    NSString *sourceWebSq = [[[NSBundle mainBundle] pathForResource:@"www" ofType:nil] stringByAppendingPathComponent:@"websquare"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(!sourceWebSq) {		// bundle에 websquare폴더가 없을 경우 복사할 엔진이 없는 것으로 판단하여 그냥 return
        NSLog(@"No websquare engine in the application www resource");
        return;
    }
    NSLog(@"path : %@", sourceWebSq);
    NSString *destinationVersionFile = [destinationWebSq stringByAppendingPathComponent:@"VERSION"];
    NSString *sourceVersionFile = [sourceWebSq stringByAppendingPathComponent:@"VERSION"];
    NSLog(@"destination version : %@", destinationVersionFile);
    NSString *destinationVersion = [NSString stringWithContentsOfFile:destinationVersionFile encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", error);
    NSString *sourceVersion = [NSString stringWithContentsOfFile:sourceVersionFile encoding:NSUTF8StringEncoding error:&error];
    if(!sourceVersion) {	// bundle websquare 폴더에 VERSION 파일이 없을 경우 정상적인 엔진이 아니라고 판단하여 그냥 return
        NSLog(@"No VERSION info in the websquare engine folder");
        return;
    }
    NSLog(@"engine bundle : %@ engine local : %@ comparision : %d", sourceVersion, destinationVersion, [sourceVersion compare:destinationVersion]); // 버전 찍어보기 (양쪽)
	// 경우의 수는 1. local 엔진 위치에 SUCCESS파일이 없거나(local에 있는 엔진이 정상 엔진이 아니라고 판단) 2. forceCopy이거나 3. 버전이 차이날 경우
    if(![fileManager fileExistsAtPath:[destinationWebSq stringByAppendingPathComponent:@"/SUCCESS"]] 
        || forcedCopy
	    || [sourceVersion compare:destinationVersion] == NSOrderedDescending ) {	// String 비교 로직으로 버전 비교(@TODO 버전비교 로직 작성 필요)
        NSLog(@"Copy engine from the bundle");
        [self directoryCopy:sourceWebSq dest:destinationWebSq];
        [success writeToURL:[NSURL fileURLWithPath:[destinationWebSq stringByAppendingPathComponent:@"/SUCCESS"]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
        [updateManager putCommand:@"setEngineVersion"];
	} else {
		NSString *destinationConfig = [destinationWebSq stringByAppendingPathComponent:@"config.xml"];
		NSString *destinationHTML = [destinationWebSq stringByAppendingPathComponent:@"websquare.html"];
		NSString *sourceConfig = [sourceWebSq stringByAppendingPathComponent:@"config.xml"];
		NSString *sourceHTML = [sourceWebSq stringByAppendingPathComponent:@"websquare.html"];
		error = nil;
		if([fileManager fileExistsAtPath:sourceConfig] && [fileManager fileExistsAtPath:destinationConfig] && ([self fileCompare:sourceConfig with:destinationConfig mode:IAUCompareMD5]==IAUCompareResultFileDifferent)) {
			[fileManager removeItemAtPath:destinationConfig error:&error];
			if(error) {
				//@TODO Error
			}
			[fileManager copyItemAtPath:sourceConfig toPath:destinationConfig error:&error];
			if(error) {
				//@TODO Error
			}
			NSLog(@"copied config.xml");
		}
		if([fileManager fileExistsAtPath:sourceConfig] && [fileManager fileExistsAtPath:destinationHTML] && ([self fileCompare:sourceHTML with:destinationHTML mode:IAUCompareMD5]==IAUCompareResultFileDifferent)) {
			[fileManager removeItemAtPath:destinationHTML error:&error];
			if(error) {
				//@TODO Error
			}
			[fileManager copyItemAtPath:sourceHTML toPath:destinationHTML error:&error];
			if(error) {
				//@TODO Error
			}
			NSLog(@"copied websquare.html");
		}
	}
}

/**
 첫번째 실행인지 여부를 판단하는 로직. 원래 process에서는 첫번째 실행인가를 판단하여(documents 폴더가 비어 있는가) 첫번째 실행일 경우에만 resource를 전체복사했으나, DTR 모드를 도입한 이후 사용하지 않음. documents 폴더 확인은 SUCCESS파일의 유무로 판단함(SUCCESS파일이 없으면 파일 몇 개가 존재하더라도 정상 resource가 아니라고 판단하여 resourceCopy를 진행하였었음)
 @param 없음
 @returns 없음
 @exception 없음
 */
-(void) isFirstLaunch
{
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
	// SUCCESS파일 유무로 정상/비정상 판단
    if(![fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]]) {
		// javascriptControlManager를 통해 javascript 영역에 firstLaunch 변수 업데이트
		// setVariableWithoutPluginName은 javascript variable 값 설정용 공통함수임.
        [[updateManager javascriptControlManager] setVariableWithoutPluginName:@"firstLaunch" withContents:@"true" withOption:nil];
    } else {
        [[updateManager javascriptControlManager] setVariableWithoutPluginName:@"firstLaunch" withContents:@"false" withOption:nil];
    }   
}

/**
 엔진이 정상상태인지를 return. 정상상태가 아닐경우 javascript에서 엔진 업데이트가 아닌 복구 로직을 호출. 정상여부 판단은 대부분의 경우와 마찬가지로 엔진 폴더 안에 SUCCESS파일이 있는가 없는가로 판단함
 @param 없음
 @returns NSString 
	정상이면 true, 비정상이면 false 문자열 리턴하여 그대로 javascript에 써줌.(@TODO 좀 이상한데? BOOL로 바꿔야할듯)
 @exception 없음
 */
-(NSString *) getEngineStatus
{
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:[updateManager websqDirectory]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]]) {
        NSLog(@"engine false");
        return @"false";
    } else {
        return @"true";
    }    
}

/**
 App이 정상상태인지를 return. 정상상태가 아닐경우 javascript에서 App업데이트가 아닌 복구 로직을 호출. 정상여부 판단은 대부분의 경우와 마찬가지로 App 폴더 안에 SUCCESS파일이 있는가 없는가로 판단함
 @param 없음
 @returns NSString
	정상이면 true, 비정상이면 false 문자열을 리턴하여 그대로 javascript에 써줌.(@TODO 좀 이상함)
 @exception 없음
 */
-(NSString *) getApplicationStatus
{
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:@"/SUCCESS"]]) {
        return @"false";
    } else {
        return @"true";
    }    
}

/**
 주어진 경로에 위치한 파일 크기를 알려주는 유틸성 함수. attributesOfItemAtPath로 attribute싹 가져온 다음 그 중 size 빼오는 식으로 동작함.
 @param (NSString *)filePath
	크기를 알고 싶은 파일의 경로. AppData 폴더를 root로 하는 상대경로로 지정함(@TODO 뒤죽박죽이네...통일 필요함)
 @returns double
	파일 크기 (bytes 수로 표현)	
 @exception @TODO 에러처리 필요
 */
-(double)getFileSize:(NSString *)filepath
{
    NSString *destination = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if(![fileManager fileExistsAtPath:[destination stringByAppendingPathComponent:filepath]]) {
        NSLog(@"No file exists!");
        return -1;//파일 없을경우 크기는 -1
    } else {
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:[destination stringByAppendingPathComponent:filepath] error:&error];
        return (double)[attrs fileSize] ;
    }    
}

/**
 새 패치 로직에서 패치 파일별로 삭제된 파일목록을 META-INF/DELETE.mf로 읽어와서 해당 파일 삭제함. 
 @param 없음
 @returns 없음
 @exception @TODO 파일에러 가능
 */
-(void)processDeleteManifest
{
    NSString *rootPath = [self getDirectoryBasedOnDocumentsDirectory:[updateManager appdataDirectory]];
    NSString *metaPath = [rootPath stringByAppendingPathComponent:@"META-INF/DELETE.mf"];	//appData 위치에 META-INF로 위치 고정됨
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:metaPath]) {
        NSLog(@"No DELETE.mf");	//없으면 말고
        return;
    } else {
		// String으로 읽어오기. UTF-8 인코딩인 것에 주의할 필요 있음
        NSString *metaData = [NSString stringWithContentsOfFile:metaPath encoding:NSUTF8StringEncoding error:nil];
        NSArray *metaDataArray = [metaData componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n,"]];
        int i = 0;
        while(i < [metaDataArray count]) {
            NSString *metaFileName = [metaDataArray objectAtIndex:i++];	//첫번째는 name
            if(i >= [metaDataArray count]) break;			// 파일당 3가지 속성이 항상 존재해야 함. trim안될 경우를 대비하여 로직 추가
			//            NSString *metaFileModDate = [metaDataArray objectAtIndex:i++]; //두번째는 modification date
            i++;
            if(i >= [metaDataArray count]) break;
			//            NSString *metaFileSize = [metaDataArray objectAtIndex:i++];        //세번째는 파일 크기
            i++;
            if(i >= [metaDataArray count]) break;
            NSString *metaFilePath = [rootPath stringByAppendingPathComponent:metaFileName];	
            NSLog(@"delete : %@", metaFilePath);
            [self fileDelete:metaFilePath];	//파일삭제
        }
        NSLog(@"array : %@ count : %d", metaDataArray, [metaDataArray count]);
    }
    
}

/**
 dealloc 될때 처리해줄 요소들. alloc 한 놈들 거시기 필요
 @param 없음
 @returns 없음
 @exception 없음
 */
-(void) dealloc
{
    //[[self progressData] release];
    
    [super dealloc];
}

@end
