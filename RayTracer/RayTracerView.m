//
//  RayTracerView.m
//  RayTracer
//
//  Created by Ao Shiyang on 12/10/14.
//  Copyright (c) 2014 Family. All rights reserved.
//

#import "RayTracerView.h"

@implementation RayTracerView

//#define WIDTH 400
//#define HEIGHT 400
//#define SIZE (WIDTH*HEIGHT)
#define BYTES_PER_PIXEL 4
#define BITS_PER_COMPONENT 8
#define BITS_PER_PIXEL 32

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        
        int threadCount = 4;
        [RayTracerThread initThread:self.bounds.size.width canvasHeight:self.bounds.size.height];
        
        for (int i=0; i<threadCount; i++)
        {
            RayTracerThreadParam *param = [RayTracerThreadParam alloc];
            param.threadCount = threadCount;
            param.threadIndex = i;
            param.view = self;
            
            NSThread *thread = [[NSThread alloc] initWithTarget:[RayTracerThread class] selector:@selector(ThreadMain:) object:param];
            [thread setStackSize:1024 * 1024 * 16];
            [thread start];
        }
        
        //[RayTracerThread ThreadMain:nil];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    

    // Drawing code here.
    
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned int* pixels = [RayTracerThread GetImageData];
    
    int WIDTH = [RayTracerThread GetWidth];
    int HEIGHT = [RayTracerThread GetHeight];
    int SIZE = WIDTH * HEIGHT;
    
    [RayTracerThread Lock];
    CGDataProviderRef provider = CGDataProviderCreateWithData(nil, pixels, SIZE, nil);
    [RayTracerThread Unlock];
    
    CGImageRef image = CGImageCreate(WIDTH,
                                     HEIGHT,
                                     BITS_PER_COMPONENT,
                                     BITS_PER_PIXEL,
                                     BYTES_PER_PIXEL * WIDTH,
                                     colorSpace,
                                     kCGImageAlphaNoneSkipFirst,
                                     provider,
                                     nil,
                                     NO,
                                     kCGRenderingIntentDefault);
    CGContextDrawImage(context, self.bounds, image);
                        
    CGImageRelease(image);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
                        
}
@end
