//
//  NSMutableArray+QueueAdditions.h
//  InAppUpdateTemplate
//
//  Created by Hoyoon Jun on 11. 9. 29..
//  Copyright 2011 Inswave. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
- (void) enqueueOnFront:(id)obj;
- (void) clearQueue;
@end