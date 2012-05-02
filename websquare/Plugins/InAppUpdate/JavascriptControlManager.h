//
//  JavascriptControlManager.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InAppUpdateManager.h"

@interface JavascriptControlManager : NSObject {
    
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) InAppUpdateManager *updateManager;

@property (nonatomic, copy) NSString* successCallback;
@property (nonatomic, copy) NSString* failCallback;
@property (nonatomic, copy) NSString* progressCallback;
@property (nonatomic, copy) NSString* logCallback;

-(NSString *) writeJavascript:(NSString *)javascript;
-(void)setVariable:(NSString *)name withContents:(NSString *)contents withOption:(NSDictionary *)options;
-(void)setVariableWithoutPluginName:(NSString *)name withContents:(NSString *)contents withOption:(NSDictionary *)options;
-(void) doJavascriptOnMainThread:(NSString *)msg;
-(void)setLog:(NSString *)msg; 
-(void)setProgress:(NSString *)msg; 
-(void)setProgressThread:(NSString *)msg; 
-(void)setStatus:(NSString *)msg; 
-(void)setLogJson:(NSString *)msg;
-(void)onSuccess:(NSString *)msg;
-(void)onFail:(NSString *)msg;
-(void)updateConfig;
-(void)updateStatus:(NSDictionary *)status;
-(NSString *) boolToString:(BOOL)value;
@end
