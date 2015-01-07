//
//  neoHotspotView.m
//  neoHotspots
//
//  Created by Xiaohe Hu on 12/22/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "neoHotspotsView.h"

static NSString *kFontName = @"Helvetica";
static float    kFontSize = 17.0;
static float    kGap = 10.0;

@implementation neoHotspotsView
@synthesize dict_rawData;
@synthesize labelAlignment;
@synthesize delegate;
@synthesize contentType;
@synthesize contentFileName;
@synthesize showArrow;

- (id)initWithHotspotInfo:(NSDictionary *)hotspotInfo
{
    self = [super init];
    if (self) {
        dict_rawData = [[NSDictionary alloc] initWithDictionary:hotspotInfo];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self prepareData];
}

- (void)prepareData
{
    //Get the position of Hs
    NSString *str_position = [[NSString alloc] initWithString:[dict_rawData objectForKey:@"xy"]];
    NSRange range = [str_position rangeOfString:@","];
    NSString *str_x = [str_position substringWithRange:NSMakeRange(0, range.location)];
    NSString *str_y = [str_position substringFromIndex:(range.location + 1)];
    x_Value = [str_x floatValue];
    y_Value = [str_y floatValue];
    
    contentType = [[NSString alloc] initWithString:[dict_rawData objectForKey:@"type"]];
    contentFileName = [[NSString alloc] initWithString:[dict_rawData objectForKey:@"fileName"]];
    
    uiiv_hotspotBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dict_rawData objectForKey:@"background"]]];
    
    self.frame = CGRectMake(x_Value, y_Value, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
    uiiv_hotspotBG.frame = self.bounds;
    
    if ([dict_rawData objectForKey:@"caption"]) {
        labelSize = [[dict_rawData objectForKey:@"caption"] sizeWithAttributes:
                     @{NSFontAttributeName:
                           [UIFont fontWithName:kFontName size:kFontSize]}];
        
        [self createCaptionLabel];
    }
    else {
        uiiv_hotspotBG.frame = self.bounds;
        [self addSubview: uiiv_hotspotBG];
        if (showArrow) {
            [self createArrow];
        }
    }
    
    [self addGestureToView];
}

- (void)createCaptionLabel
{
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    switch (labelAlignment) {
        case 0:
        {
            if (labelSize.width > uiiv_hotspotBG.frame.size.width)
            {
                offsetX = (labelSize.width - uiiv_hotspotBG.frame.size.width)/2;
            }
            else
            {
                offsetX = 0.0;
            }
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(-offsetX, uiiv_hotspotBG.frame.size.height + kGap, labelSize.width, labelSize.height)];
            break;
        }
        case 1:
        {
            offsetY = labelSize.height + kGap;
            if (labelSize.width > uiiv_hotspotBG.frame.size.width)
            {
                offsetX = (labelSize.width - uiiv_hotspotBG.frame.size.width)/2;
            }
            else
            {
                offsetX = 0.0;
            }
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(-offsetX, -offsetY, labelSize.width, labelSize.height)];
            break;
        }
        case 2:
        {
            offsetX = labelSize.width + kGap;
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(-offsetX, (uiiv_hotspotBG.frame.size.height - labelSize.height)/2, labelSize.width, labelSize.height)];
            break;
        }
        case 3:
        {
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(uiiv_hotspotBG.frame.size.width + kGap, (uiiv_hotspotBG.frame.size.height - labelSize.height)/2, labelSize.width, labelSize.height)];
            break;
        }
        case 4:
        {
            offsetX = labelSize.width + kGap;
            offsetY = labelSize.height;
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(-offsetX, -offsetY, labelSize.width, labelSize.height)];
            break;
        }
        case 5:
        {
            offsetY = labelSize.height;
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(uiiv_hotspotBG.frame.size.width + kGap, -offsetY, labelSize.width, labelSize.height)];
            break;
        }
        case 6:
        {
            offsetX = labelSize.width + kGap;
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(-offsetX, uiiv_hotspotBG.frame.size.height, labelSize.width, labelSize.height)];
            break;
        }
        case 7:
        {
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(uiiv_hotspotBG.frame.size.width + kGap, uiiv_hotspotBG.frame.size.height, labelSize.width, labelSize.height)];
            break;
        }
        default:
            break;
    }
    
    uil_caption.text = [dict_rawData objectForKey:@"caption"];
    uil_caption.font = [UIFont fontWithName:kFontName size:kFontSize];
    self.backgroundColor = [UIColor redColor];
    uil_caption.backgroundColor = [UIColor whiteColor];
    uiiv_hotspotBG.backgroundColor = [UIColor greenColor];
    [self addSubview: uiiv_hotspotBG];
    [self addSubview: uil_caption];
    if (showArrow) {
        [self createArrow];
    }
}

- (void)addGestureToView
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHotspot:)];
    tapOnView.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapOnView];
//    UITapGestureRecognizer *tapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHotspot:)];
//    tapOnImage.numberOfTapsRequired = 1;
//    uiiv_hotspotBG.userInteractionEnabled = YES;
//    [uiiv_hotspotBG addGestureRecognizer:tapOnImage];
//    
//    UITapGestureRecognizer *tapOnLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHotspot:)];
//    tapOnLabel.numberOfTapsRequired = 1;
//    uil_caption.userInteractionEnabled = YES;
//    [uil_caption addGestureRecognizer: tapOnLabel];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
    {
    if ( CGRectContainsPoint(uiiv_arrowImg.frame, point) || CGRectContainsPoint(uil_caption.frame, point) )
        return YES;

    return [super pointInside:point withEvent:event];
    }


- (void)tapHotspot:(UIGestureRecognizer *)gesture
{
    [self.delegate neoHotspotsView:self didSelectItemAtIndex:self.tag];
}

- (void)createArrow
{
    float width = uiiv_hotspotBG.frame.size.width;
    float height = uiiv_hotspotBG.frame.size.height;
    float radius = sqrtf(width*width + height*height);
    
    uiiv_arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_avail_view.png"]];
    uiiv_arrowImg.frame = CGRectMake((uiiv_hotspotBG.frame.size.width - uiiv_arrowImg.frame.size.width)/2 + uiiv_hotspotBG.frame.origin.x, uiiv_hotspotBG.frame.origin.y - (radius-uiiv_hotspotBG.frame.size.height) - uiiv_arrowImg.frame.size.height, uiiv_arrowImg.frame.size.width, uiiv_arrowImg.frame.size.height);
    [self addSubview: uiiv_arrowImg];
    
    if ([dict_rawData objectForKey:@"angle"]) {
        arrowAngle = [[dict_rawData objectForKey:@"angle"] floatValue];
    }
    else {
        [uiiv_arrowImg removeFromSuperview];
        return;
//        arrowAngle = 0.0;
    }
    
    CGRect oldFrame = uiiv_arrowImg.frame;
    uiiv_arrowImg.layer.anchorPoint = CGPointMake(0.5, radius/2/uiiv_arrowImg.frame.size.height+1);
    uiiv_arrowImg.frame = oldFrame;
    
    uiiv_arrowImg.transform = CGAffineTransformMakeRotation((arrowAngle/180)*M_PI);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
