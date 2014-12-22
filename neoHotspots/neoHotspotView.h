//
//  neoHotspotView.h
//  neoHotspots
//
//  Created by Xiaohe Hu on 12/22/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class neoHotspotView;
@protocol neoHotspotViewDelegate
typedef enum {
    CaptionAlignmentBottom,     //0
    
    CaptionAlignmentTop,        //1
    
    CaptionAlignmentLeft,       //2
    
    CaptionAlignmentRight,      //3
    
    CaptionAlignmentTopLeft,    //4
    
    CaptionAlignmentTopRight,   //5
    
    CaptionAlignmentBottomLeft, //6
    
    CaptionAlignmentBottomRight //7
    
} HotspotCaptionAlignment;
@end

@interface neoHotspotView : UIView
{
    float               x_Value;
    float               y_Value;
    CGSize              labelSize;
    UIImageView         *uiiv_hotspotBG;
    UILabel             *uil_caption;
}

@property (nonatomic, strong) NSDictionary                  *dict_rawData;
@property (nonatomic, assign) HotspotCaptionAlignment       labelAlignment;


- (id)initWithHotspotInfo:(NSDictionary *)hotspotInfo;
@end
