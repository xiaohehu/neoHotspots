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
    CaptionAlignmentBottom1,     //0
    
    CaptionAlignmentTop1,        //1
    
    CaptionAlignmentLeft1,       //2
    
    CaptionAlignmentRight1,      //3
    
    CaptionAlignmentTopLeft1,    //4
    
    CaptionAlignmentTopRight1,   //5
    
    CaptionAlignmentBottomLeft1, //6
    
    CaptionAlignmentBottomRight1 //7
    
} HotspotCaptionAlignment1;
@optional
- (void)didSelectecHotspot:(neoHotspotView *)hotspotView atIndex:(NSInteger)index;
@end

@interface neoHotspotView : UIView
{
    float               x_Value;
    float               y_Value;
    CGSize              labelSize;
    UIImageView         *uiiv_hotspotBG;
    UIImageView         *uiiv_arrowImg;
    UILabel             *uil_caption;
    float               arrowAngle;
}

@property (nonatomic, readwrite) BOOL                       showArrow;
@property (nonatomic, strong) id                            delegate;
@property (nonatomic, strong) NSDictionary                  *dict_rawData;
@property (nonatomic, assign) HotspotCaptionAlignment1      labelAlignment;
@property (nonatomic, strong) NSString                      *contentType;
@property (nonatomic, strong) NSString                      *contentFileName;


- (id)initWithHotspotInfo:(NSDictionary *)hotspotInfo;
@end
