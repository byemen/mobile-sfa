//
//  JavascriptControlManager.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 9. 19..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "JavascriptControlManager.h"

@implementation JavascriptControlManager
@synthesize webView, updateManager;
@synthesize successCallback, failCallback, logCallback, progressCallback;

NSString *pluginName = @"window.plugins.inappupdate";

-(NSString *) boolToString:(BOOL)value
{
    if(value) {
        return @"true";
    } else {
        return @"false";
    }
}

-(NSString *) writeJavascript:(NSString *)javascript
{
    return [self.webView stringByEvaluatingJavaScriptFromString:javascript];
}

-(void) doJavascriptOnMainThread:(NSString *)msg
{
    [self writeJavascript:msg];
}

-(void)setLog:(NSString *)msg 
{
    //NSLog(@"var temp=\'%@\';setLog(temp);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    NSLog(@"%@", msg);
    if([updateManager logFunction]) {
        [self writeJavascript:[NSString stringWithFormat:@"var patch_temp_message=\'%@\';%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [updateManager logFunction]]];
    }
}

-(void)setLogJson:(NSString *)msg
{
    [self writeJavascript:[NSString stringWithFormat:@"var patch_temp_message=%@;setLogJson(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
}

-(void)setProgress:(NSString *)msg
{
    NSLog(@"progress : %@", msg);
    if([updateManager progressFunction]) {
        [self writeJavascript:[NSString stringWithFormat:@"var patch_temp_message=%@;%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [updateManager progressFunction]]];
    }
}

-(void)setProgressThread:(NSString *)msg
{
    [self performSelectorOnMainThread:@selector(writeJavascript:) withObject:[NSString stringWithFormat:@"var patch_temp_message=%@;%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [updateManager progressFunction]] waitUntilDone:NO];
}

-(void)setStatus:(NSString *)msg
{
    if([updateManager statusFunction]) {
        NSLog(@"status : %@", [NSString stringWithFormat:@"var patch_temp_message=\'%@\';%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [updateManager statusFunction]]);
        [self writeJavascript:[NSString stringWithFormat:@"var patch_temp_message=\'%@\';%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [updateManager statusFunction]]];
    }
}

-(void)onSuccess:(NSString *)msg
{
    NSLog(@"onSuccess! : %@(%@)",[self successCallback], msg);
    if(msg) {
     [self writeJavascript:[NSString stringWithFormat:@"var temp=%@;%@(temp);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[self successCallback]]];
    } else {
        [self writeJavascript:[NSString stringWithFormat:@"%@()",[self successCallback]]];   
        NSLog(@"success : %@", [NSString stringWithFormat:@"%@()",[self successCallback]]);
    }
}

-(void)onFail:(NSString *)msg 
{
    if([self failCallback]) {
     [self writeJavascript:[NSString stringWithFormat:@"var patch_temp_message=\'%@\';%@(patch_temp_message);",[msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[self failCallback]]];
    } else {
        [self writeJavascript:[NSString stringWithFormat:@"alert(\'%@)\';", [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
    }
}

-(void)setVariable:(NSString *)name withContents:(NSString *)contents withOption:(NSDictionary *)options
{
    NSString *variableContents = contents;
    NSString *variableName = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([options objectForKey:@"trim"]) {
        variableContents = [variableContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if([options objectForKey:@"string"]) {
        variableContents = [NSString stringWithFormat:@"'%@'", variableContents];
    }
    [self writeJavascript:[NSString stringWithFormat:@"%@ = %@;", variableName, variableContents]];
    NSLog(@"%@ = %@;", variableName, variableContents);
}

-(void)setVariableWithoutPluginName:(NSString *)name withContents:(NSString *)contents withOption:(NSDictionary *)options
{
    [self setVariable:[NSString stringWithFormat:@"%@.%@", pluginName, name] withContents:contents withOption:options];
}

-(void)updateConfig
{
    NSDictionary *stringOption = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"string",nil];
    [self setVariable:[NSString stringWithFormat:@"%@.appdataDirectory", pluginName] withContents:[updateManager appdataDirectory] withOption:stringOption];
    [self setVariable:[NSString stringWithFormat:@"%@.updatePolicy.refreshUpdatePolicy", pluginName] withContents:[self boolToString:[updateManager refreshUpdatePolicy]] withOption:nil];
    [self setVariable:[NSString stringWithFormat:@"%@.updatePolicy.engineUpdatePolicy", pluginName] withContents:[self boolToString:[updateManager engineUpdatePolicy]] withOption:nil];
    [self setVariable:[NSString stringWithFormat:@"%@.updatePolicy.applicationUpdatePolicy", pluginName] withContents:[self boolToString:[updateManager applicationUpdatePolicy]] withOption:nil];
}

-(void)updateStatus:(NSDictionary *)status
{
    NSString *engineStatus = [status objectForKey:@"engineStatus"];
    NSString *applicationStatus = [status objectForKey:@"applicationStatus"];
    if(engineStatus) {
        [self setVariable:[NSString stringWithFormat:@"%@.engineStatus", pluginName] withContents:engineStatus withOption:nil];
    }
    if(applicationStatus) {
        [self setVariable:[NSString stringWithFormat:@"%@.applicationStatus", pluginName] withContents:applicationStatus withOption:nil];
    }
}

@end
