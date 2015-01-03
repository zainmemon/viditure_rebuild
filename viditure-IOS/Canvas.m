//
//  DAScratchpadView.m
//  DAScratchPad
//
//  Created by David Levi on 5/9/13.
//  Copyright 2013 Double Apps Inc. All rights reserved.
//

#import "Canvas.h"
#import <QuartzCore/QuartzCore.h>

@implementation Canvas
{
	CGFloat _drawOpacity;
	CGFloat _airBrushFlow;
	CALayer* drawLayer;
	UIImage* mainImage;
	UIImage* drawImage;
	CGPoint lastPoint;
	CGPoint currentPoint;
	CGPoint airbrushPoint;
	NSTimer* airBrushTimer;
	UIImage* airBrushImage;
}

- (void) initCommon
{
	_toolType = CanvasToolTypePaint;
	_drawColor = [UIColor blackColor];
	_drawWidth = 1.0f;
	_drawOpacity = 1.0f;
	_airBrushFlow = 0.5f;
	drawLayer = [[CALayer alloc] init];
	drawLayer.frame = CGRectMake(0.0f, 0.0f, self.layer.frame.size.width, self.layer.frame.size.height);
	mainImage = nil;
	drawImage = nil;
	airBrushTimer = nil;
	airBrushImage = nil;
	[self.layer addSublayer:drawLayer];
	[self clearToColor:self.backgroundColor];
}

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self initCommon];
	}
    return self;
}

- (id) initWithCoder:(NSCoder *)decoder
{
	if ((self = [super initWithCoder:decoder])) {
		[self initCommon];
	}
	return self;
}

- (void) layoutSubviews
{
	drawLayer.frame = CGRectMake(0.0f, 0.0f, self.layer.frame.size.width, self.layer.frame.size.height);
}


- (void) drawLineFrom:(CGPoint)from to:(CGPoint)to width:(CGFloat)width
{
	UIGraphicsBeginImageContext(self.frame.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(ctx, 1.0f, -1.0f);
	CGContextTranslateCTM(ctx, 0.0f, -self.frame.size.height);
	if (drawImage != nil) {
		CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
		CGContextDrawImage(ctx, rect, drawImage.CGImage);
	}
	CGContextSetLineCap(ctx, kCGLineCapRound);
	CGContextSetLineWidth(ctx, width);
	CGContextSetStrokeColorWithColor(ctx, self.drawColor.CGColor);
	CGContextMoveToPoint(ctx, from.x, from.y);
	CGContextAddLineToPoint(ctx, to.x, to.y);
	CGContextStrokePath(ctx);
	CGContextFlush(ctx);
	drawImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	drawLayer.contents = (id)drawImage.CGImage;
}

- (void) commitDrawingWithOpacity:(CGFloat)opacity
{
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(ctx, 1.0f, -1.0f);
	CGContextTranslateCTM(ctx, 0.0f, -self.frame.size.height);
	CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
	if (mainImage != nil) {
		CGContextDrawImage(ctx, rect, mainImage.CGImage);
	}
	CGContextSetAlpha(ctx, opacity);
	CGContextDrawImage(ctx, rect, drawImage.CGImage);
	mainImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	self.layer.contents = (id)mainImage.CGImage;
    drawLayer.contents = nil;
	drawImage = nil;
}

- (void)paintTouchesBegan
{
	drawLayer.opacity = self.drawOpacity;
	[self drawLineFrom:lastPoint to:lastPoint width:self.drawWidth];
}

- (void)paintTouchesMoved
{
	[self drawLineFrom:lastPoint to:currentPoint width:self.drawWidth];
}

- (void) paintTouchesEnded
{
	[self commitDrawingWithOpacity:self.drawOpacity];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.userInteractionEnabled) {
		[super touchesBegan:touches withEvent:event];
		return;
	}
	
	UITouch *touch = [touches anyObject];
	lastPoint = [touch locationInView:self];
	lastPoint.y = self.frame.size.height - lastPoint.y;
	
	if (self.toolType == CanvasToolTypePaint) {
		[self paintTouchesBegan];
	}

}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.userInteractionEnabled) {
		[super touchesMoved:touches withEvent:event];
		return;
	}

	UITouch *touch = [touches anyObject];	
	currentPoint = [touch locationInView:self];
	currentPoint.y = self.frame.size.height - currentPoint.y;

	if (self.toolType == CanvasToolTypePaint) {
		[self paintTouchesMoved];
	}

	lastPoint = currentPoint;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.userInteractionEnabled) {
		[super touchesEnded:touches withEvent:event];
		return;
	}
	
	if (self.toolType == CanvasToolTypePaint) {
		[self paintTouchesEnded];
	}
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.userInteractionEnabled) {
		[super touchesCancelled:touches withEvent:event];
		return;
	}
	[self touchesEnded:touches withEvent:event];
}

- (void) clearToColor:(UIColor*)color
{
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
	CGContextSetFillColorWithColor(ctx, color.CGColor);
	CGContextFillRect(ctx, rect);
	CGContextFlush(ctx);
	mainImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	self.layer.contents = (id)mainImage.CGImage;
}


@end
