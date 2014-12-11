//
//  RayTracerThread.h
//  RayTracer
//
//  Created by Ao Shiyang on 12/10/14.
//  Copyright (c) 2014 Family. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RayTracerThreadParam : NSObject

@property int threadCount;
@property int threadIndex;
@property NSView* view;

@end

@interface RayTracerThread : NSObject

+ (void)initThread:(int)width canvasHeight:(int)height;
+ (void)ThreadMain:(id)param;
+ (unsigned int*)GetImageData;
+ (void)Lock;
+ (void)Unlock;
+ (int)GetWidth;
+ (int)GetHeight;

@end
