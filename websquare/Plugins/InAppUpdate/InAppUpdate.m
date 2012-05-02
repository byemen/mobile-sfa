//
//  InAppUpdatePlugin.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 21..
//  Copyright 2011 Inswave. All rights reserved.
//

/*
 이 class는 실제 Cordova Plugin으로써 javascript 영역에서 직접 호출되는 부분이다. 따라서 여기에 정의된 함수들은 모두 Javascript에서 직접 호출할 수 있는 API들이며 구체적인 구현은 InAppUpdateManager를 통한다. InAppUpdate 함수들은 유틸성에 Cordova Plugin과 연계되는 부분이 많이 않으므로 이 영역에 모든 코드를 표현하지 않고 노출되는 부분을 최소화하려 노력하였다. 추후 Static Library로 빌드가 가능해지면 여타 InAppUpdate Util및 다른 함수들은 모두 Static Library로 숨기고 이 파일 하나만을 노출시키는 것을 목표로 한다.
 
 InAppUpdate 플러그인에서는 InAppUpdateManager라는 구현객체를 통해 대부분의 작업을 처리한다. InAppUpdateManager 객체에서는 각각의 API들의 동작을 작은 명령(Command)단위로 분리, 공통화하여 해당 API에서 수행해야 하는 명령을 순차적으로 processQueue에 집어넣고, processQueue에서 하나씩 작업을 꺼내어 수행하고 결과에 따라 다시 작업을 반복하는 구조를 지니고 있다(일반적은 Processer의 순차적 명령 처리 구조를 따른다)
 
 따라서 새로운 API 추가를 위해서는
 
 1. InAppUpdate class에 Cordova spec에 맞는 함수 interface 등록
 2. InAppUpdate.m 구현파일에서 해당 API를 잘게 쪼갠 Command 목록을 만들어 processManager에 집어넣기
 3. InAppUpdateManager에서 해당 command들 구현(필요할 경우)
 4. InAppUpdate.js 에 API interface 등록

 의 과정이 필수적으로 수행되어야 한다.
 */

#import "InAppUpdate.h"
#import "InAppUpdateManager.h"
#import "JavascriptControlManager.h"


@implementation InAppUpdate
@synthesize inAppUpdateManager;

/* STATUS메시지를 처리하는 부분을 javascript 단으로 뺴야 하는 것이 아닐지 의심스럽다 
@TODO Error Code 및 관련 제반 처리하는 부분을 (지금 javascriptControlManager가 있지만) 좀 더 세분화할 필요가 있다 
 */
NSString *STATUS_INIT = @"초기화중...";
NSString *STATUS_ENGINE_RESTORE = @"엔진 복구중...";
NSString *STATUS_ENGINE_UPDATE = @"엔진 업데이트중...";
NSString *STATUS_APP_RESTORE = @"App 복구중...";
NSString *STATUS_APP_UPDATE = @"App 업데이트중...";
NSString *STATUS_REFRESH = @"변경된 파일 갱신중...";
NSString *PROGRESS_FILE_DOWN = @" 다운중";
NSString *PROGRESS_FILE_INSTALL = @" 설치중";

/**
 WebView 설정하고 InAppUpdateManger 객체를 설정하는 초기화 함수. javascript 통신을 Cordova가 아닌 InAppUpdate에서 직접 핸들링하기 위해 사용중
 @param (UIWebVIew *)theWebView
	메인 WebView 객체. 
 @returns InAppUpdate *
	초기화된 InAppUpdate 객체
 @exception 없음
 */
- (InAppUpdate *) initWithWebView:(UIWebView *)theWebView
{
    self = (InAppUpdate *)[super initWithWebView:theWebView];
    inAppUpdateManager = [[[InAppUpdateManager alloc] init] retain];
    [[inAppUpdateManager javascriptControlManager] setWebView:theWebView]; 
    return self;
}

/**
 Ping을 위한 함수. 테스트 / 디버그 용도 외에 직접적으로 Ping API를 호출하는 경우는 사라짐
 @param (NSMubtableArray *)paramArray
	Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
	Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) ping:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"ping"];
    [inAppUpdateManager processManager:paramArray withDict:options];
    //[inAppUpdateManager ping:paramArray withDict:options];
}

/**
 파일 하나를 다운로드받는 함수. 직접 이 API를 호출하는 것은 권장하지 않는다. Cordova에 downloader 및 uploader 기능이 추가되었으므로 그쪽을 사용하는 것이 좋을듯
 @param (NSMubtableArray *)paramArray
	Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
	Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) getFile:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager getFile:paramArray withDict:options];
}	

/**
 패치 파일 리스트를 다운로드받는 함수. 초창기 Command 각각을 모두 API로 뽑는 과정에서 만들어졌다. 사용을 권장하지 않음(내부함수)
 @param (NSMubtableArray *)paramArray
	Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
	Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) getFileList:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager getFileList:paramArray withDict:options];
}

/**
 패치를 진행시키는 함수. applicationUpdateGo로 모든 역할이 넘어감. deprecated
 @param (NSMubtableArray *)paramArray
	Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
	Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) patchGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager patchGo:paramArray withDict:options];
}

/**
 Refresh 파일을 받아오는 패치 모듈. 초창기에 만들어져 거의 그 원형을 유지하고 있다. Patch와 다른 점은 개별 파일들을 다운로드하기 때문에 zip 압축해제 과정이 필요없다는 점 정도.
 @param (NSMubtableArray *)paramArray
	Cordova의 API 호출 Spec에 따른 parameter 배열
 @param (NSMutableDictionary *)options
	Cordova의 API 호출 Spec에 따른 option directory. Javascript 단에서 object로 전달된 parameter는 option으로 간주되어 여기에 들어감
 @returns 없음
 @exception 없음
 */
-(void) refreshGo:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_REFRESH];
    [inAppUpdateManager putCommand:@"initParameter"];		//API parameter들을 파싱하고 callback등을 정의함
    [inAppUpdateManager putCommand:@"ping"];				//ping한번 던져보기. 서버 접속여부 판단
    [inAppUpdateManager putCommand:@"getRefreshFileList"];	//refresh 파일 리스트 가져오기.
    [inAppUpdateManager putCommand:@"getMultipleFiles"];	//리스트를 토대로 파일 다운로드.
    //[inAppUpdateManager putCommand:@"getFileFromPatchFileList"];
    [inAppUpdateManager putCommand:@"onSuccess"];			//성공 calllback
    [inAppUpdateManager processManager:paramArray withDict:options];	//실제 처리함수인 processManager 호출
    //    [inAppUpdateManager patchGo:paramArray withDict:options];
}

-(void) doBackup:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager doBackup:paramArray withDict:options];
}

-(void) doRestore:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [inAppUpdateManager doRestore:paramArray withDict:options]; 
}

-(void) doInstall
{
    [inAppUpdateManager doInstall];
}

-(void) doInitialize:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_INIT];
    [inAppUpdateManager putCommand:@"copyResource"];
    [inAppUpdateManager putCommand:@"updateStatus"];
	[inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) engineUpdateGo:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_ENGINE_UPDATE];
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"ping"];
    //[inAppUpdateManager putCommand:@"compareEngineVersion"];
    [inAppUpdateManager putCommand:@"getEngineUpdate"];
    [inAppUpdateManager putCommand:@"getFile"];
    [inAppUpdateManager putCommand:@"installEngine"];
    [inAppUpdateManager putCommand:@"getEngineJS"];
    [inAppUpdateManager putCommand:@"flush"];
    [inAppUpdateManager putCommand:@"setEngineVersion"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) engineRestoreGo:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_ENGINE_RESTORE];
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"ping"];
    [inAppUpdateManager putCommand:@"getEngineRecovery"];
    [inAppUpdateManager putCommand:@"getFile"];
    [inAppUpdateManager putCommand:@"installEngine"];
    [inAppUpdateManager putCommand:@"getEngineJS"];
    [inAppUpdateManager putCommand:@"flush"];
    [inAppUpdateManager putCommand:@"setEngineVersion"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) applicationUpdateGo:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_APP_UPDATE];
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"ping"];
    [inAppUpdateManager putCommand:@"getFileList"];
    [inAppUpdateManager putCommand:@"getMultipleFiles"];
    [inAppUpdateManager putCommand:@"installMultipleFiles"];
    [inAppUpdateManager putCommand:@"setAppVersion"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) applicationRestoreGo:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_APP_RESTORE];
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"ping"];
    [inAppUpdateManager putCommand:@"getApplicationRecovery"];
    [inAppUpdateManager putCommand:@"getFile"];
    [inAppUpdateManager putCommand:@"installApplication"];
    [inAppUpdateManager putCommand:@"setAppVersion"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) isFirstLaunch:(NSMutableArray*) paramArray withDict:(NSMutableDictionary*)options;
{
    [inAppUpdateManager isFirstLaunch];
}

-(void) initialize:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    NSLog(@"H");
    [[inAppUpdateManager javascriptControlManager] setStatus:STATUS_INIT];
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"readConfig"];
    [inAppUpdateManager putCommand:@"setEngineVersion"];
    [inAppUpdateManager putCommand:@"isFirstLaunch"];
    [inAppUpdateManager putCommand:@"updateConfig"];
    [inAppUpdateManager putCommand:@"updateStatus"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];			
}

-(void) copyResource:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"copyResource"];
    [inAppUpdateManager putCommand:@"updateStatus"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) copyLocalResource:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"copyLocalResource"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) launch:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{		
    [inAppUpdateManager putCommand:@"launch"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) clean:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [[inAppUpdateManager javascriptControlManager] setStatus:@"청소완료"];
    [inAppUpdateManager putCommand:@"clean"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) setLogFunction:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"setLogFunction"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) setStatusFunction:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"setStatusFunction"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) setProgressFunction:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"setProgressFunction"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

-(void) updateFromLocal:(NSMutableArray *)paramArray withDict:(NSMutableDictionary *)options
{
    [inAppUpdateManager putCommand:@"initParameter"];
    [inAppUpdateManager putCommand:@"copyLocalResource"];
    [inAppUpdateManager putCommand:@"onSuccess"];
    [inAppUpdateManager processManager:paramArray withDict:options];
}

@end
