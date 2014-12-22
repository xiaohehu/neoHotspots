//
//  neoHotspotView.m
//  neoHotspots
//
//  Created by Xiaohe Hu on 12/22/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "neoHotspotView.h"

static NSString *kFontName = @"Helvetica";
static float    kFontSize = 17.0;
static float    kGap = 10.0;

@implementation neoHotspotView
@synthesize dict_rawData;
@synthesize labelAlignment;

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
    
    uiiv_hotspotBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dict_rawData objectForKey:@"background"]]];
    labelSize = [[dict_rawData objectForKey:@"caption"] sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:kFontName size:kFontSize]}];
    
    self.frame = CGRectMake(x_Value-kGap-labelSize.width, y_Value-kGap-labelSize.height, labelSize.width*2+kGap*2+uiiv_hotspotBG.frame.size.width, labelSize.height*2+kGap*2+uiiv_hotspotBG.frame.size.height);
    
    uiiv_hotspotBG.frame = CGRectMake(labelSize.width+kGap, labelSize.height+kGap, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
    [self addSubview: uiiv_hotspotBG];
}

- (void)createCaptionLabel
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
