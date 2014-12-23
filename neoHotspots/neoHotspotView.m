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
@synthesize delegate;
@synthesize contentType;
@synthesize contentFileName;

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
    labelSize = [[dict_rawData objectForKey:@"caption"] sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:kFontName size:kFontSize]}];
    
    [self createCaptionLabel];
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
            self.frame = CGRectMake(x_Value - offsetX, y_Value, labelSize.width, uiiv_hotspotBG.frame.size.height + kGap + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, 0.0, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, uiiv_hotspotBG.frame.size.height + kGap, labelSize.width, labelSize.height)];
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
            self.frame = CGRectMake(x_Value - offsetX, y_Value - offsetY, labelSize.width, uiiv_hotspotBG.frame.size.height + kGap + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, labelSize.width, labelSize.height)];
            break;
        }
        case 2:
        {
            offsetX = labelSize.width + kGap;
            self.frame = CGRectMake(x_Value - offsetX, y_Value, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, (uiiv_hotspotBG.frame.size.height - labelSize.height)/2, labelSize.width, labelSize.height)];
            break;
        }
        case 3:
        {
            self.frame = CGRectMake(x_Value, y_Value, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(uiiv_hotspotBG.frame.size.width + kGap, (uiiv_hotspotBG.frame.size.height - labelSize.height)/2, labelSize.width, labelSize.height)];
            break;
        }
        case 4:
        {
            offsetX = labelSize.width + kGap;
            offsetY = labelSize.height;
            self.frame = CGRectMake(x_Value - offsetX, y_Value - offsetY, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, labelSize.width, labelSize.height)];
            break;
        }
        case 5:
        {
            offsetY = labelSize.height;
            self.frame = CGRectMake(x_Value - offsetX, y_Value - offsetY, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(uiiv_hotspotBG.frame.size.width + kGap, 0.0, labelSize.width, labelSize.height)];
            break;
        }
        case 6:
        {
            offsetX = labelSize.width + kGap;
            self.frame = CGRectMake(x_Value - offsetX, y_Value, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
            uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(0.0, uiiv_hotspotBG.frame.size.height, labelSize.width, labelSize.height)];
            break;
        }
        case 7:
        {
            self.frame = CGRectMake(x_Value, y_Value, labelSize.width + kGap + uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height + labelSize.height);
            uiiv_hotspotBG.frame = CGRectMake(offsetX, offsetY, uiiv_hotspotBG.frame.size.width, uiiv_hotspotBG.frame.size.height);
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
    [self addGestureToView];
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

- (void)tapHotspot:(UIGestureRecognizer *)gesture
{
    [self.delegate didSelectecHotspot:self atIndex:self.tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
