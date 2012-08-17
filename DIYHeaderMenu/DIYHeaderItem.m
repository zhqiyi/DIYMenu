//
//  DIYHeaderItem.m
//  DIYHeaderMenu
//
//  Created by Jonathan Beilin on 8/13/12.
//  Copyright (c) 2012 DIY. All rights reserved.
//

#import "DIYHeaderItem.h"
#import "DIYHeaderOptions.h"

#import "UIView+Noise.h"

@interface DIYHeaderItem ()

@end

@implementation DIYHeaderItem

@synthesize delegate = _delegate;
@synthesize noise = _noise;

@synthesize name = _name;
@synthesize icon = _icon;
@synthesize isSelected = _isSelected;

#pragma mark - Init & Setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate = nil;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.autoresizesSubviews = true;
        _noise = nil;
    }
    return self;
}

- (void)setName:(NSString *)name withIcon:(UIImage *)image withColor:(UIColor *)color
{    
    CGRect labelFrame = CGRectMake(2*ICONPADDING + ICONSIZE, ICONPADDING, self.frame.size.width, ICONSIZE);
    _name = [[UILabel alloc] initWithFrame:labelFrame];
    self.name.backgroundColor = [UIColor clearColor];
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont fontWithName:FONT_FAMILY size:FONT_SIZE];
    self.name.text = name;
    [self addSubview:self.name];
    
    _icon = [[UIImageView alloc] initWithImage:image];
    self.icon.frame = CGRectMake(ICONPADDING, ICONPADDING, ICONSIZE, ICONSIZE);
    [self addSubview:self.icon];
    
    self.backgroundColor = color;
    [self refreshNoise];
}

#pragma mark - Drawing

- (void)refreshNoise
{
    if (self.noise != nil) {
        [self.noise removeFromSuperlayer];
    }
    self.noise = [self applyNoise];
}

#pragma mark - Touching

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    // Make look selected
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    // Make look unselected if move out?
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    // Make look unselected
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    // Make look unselected
    
    // Call delegate if touch ended in view
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        [self.delegate diyMenuAction:self.name.text];
    }
}

- (void)depictSelected
{
    // transform a few pixels x,y
    // add shading view
}

- (void)depictUnselected
{
    // return to normal place
    // remove shading view
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    _delegate = nil;
    [_name release]; _name = nil;
    [_icon release]; _icon = nil;
}

- (void)dealloc
{
    [self releaseObjects];
    [super dealloc];
}

@end
