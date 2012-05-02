//
//  NSMutableArray+QueueAdditions.m
//  InAppUpdateTemplate
//
//  Created by Hoyoon Jun on 11. 9. 29..
//  Copyright 2011 Inswave. All rights reserved.
//

#import "NSMutableArray+QueueAdditions.h"


@implementation NSMutableArray (QueueAdditions)

- (id) dequeue 
{
    if([self count] == 0) {
        return nil;
    }
    id queueObject = [[[self objectAtIndex:0] retain] autorelease];
    [self removeObjectAtIndex:0];
    return queueObject;
}

- (void) enqueue:(id)anObject 
{
    [self addObject:anObject];
}

-(void) enqueueOnFront:(id)anObject
{
    [self insertObject:anObject atIndex:0];
}

-(void) clearQueue
{
    [self removeAllObjects];
}

@end
