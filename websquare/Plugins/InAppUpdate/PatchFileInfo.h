//
//  PatchFileInfo.h
//  TemplateFinal
//
//  Created by Hoyoon Jun on 11. 8. 9..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PatchFileInfo : NSObject {

}

@property (nonatomic, retain) NSString* name;
@property (nonatomic) NSInteger size;
@property (nonatomic, retain) NSString* version;
@property (nonatomic, retain) NSString* timestamp;
@property (nonatomic) int index;
@property (nonatomic) int patchnumber;
@property (nonatomic) BOOL received;
@property (nonatomic, retain) NSString* filePath;
@property (nonatomic, retain) NSString* savePath;

-(id) initWithJsonData:(NSDictionary *)dictData;
-(id) init;

@end
