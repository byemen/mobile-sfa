//
//  PatchFileInfo.m
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 9..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "PatchFileInfo.h"

@implementation PatchFileInfo
 
@synthesize name, size, version, timestamp, index, received, filePath, savePath, patchnumber;

-(id) initWithJsonData:(NSDictionary *)dictData
{
    if(!dictData) {
        return [self init];
    }
    
    self = [super init];
    
    [self setName:[dictData objectForKey:@"filename"]];
    [self setSize:[[dictData objectForKey:@"size"] doubleValue]];
    NSLog(@"size : %@", [dictData objectForKey:@"size"]);
    [self setVersion:[dictData objectForKey:@"version"]];
    [self setTimestamp:[dictData objectForKey:@"timestamp"]];
    [self setFilePath:[dictData objectForKey:@"path"]];
    [self setSavePath:[dictData objectForKey:@"savepath"]];
    patchnumber = [[dictData objectForKey:@"patchnumber"] intValue];
    [self setReceived:NO];
    /*
    size = [[dictData objectForKey:@"size"] doubleValue];
    version = [dictData objectForKey:@"version"];
    timestamp = [dictData objectForKey:@"timestamp"];
    */
    return self;
}

-(id) init
{
    self = [super init];
    
    [self setName:@"ImsiName"];
    [self setSize:1];
    [self setVersion:@"1.0.0"];
    [self setTimestamp:@"201108081234"];
    [self setReceived:NO];
    /*
    name = @"ImsiName";
    size = 1;
    version = @"1.0.0";
    timestamp = @"201108081234";
    */
    return self;
}

@end
