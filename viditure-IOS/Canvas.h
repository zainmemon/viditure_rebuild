//
//  DAScratchpadView.h
//  DAScratchPad
//
//  Created by David Levi on 5/9/13.
//  Copyright 2013 Double Apps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
	CanvasToolTypePaint = 0,
	CanvasToolTypeAirBrush
}
CanvasToolType;

@interface Canvas : UIControl

@property (assign) CanvasToolType toolType;
@property (strong,nonatomic) UIColor* drawColor;
@property (assign) CGFloat drawWidth;
@property (assign) CGFloat drawOpacity;
@property (assign) CGFloat airBrushFlow;

- (void) clearToColor:(UIColor*)color;

@end