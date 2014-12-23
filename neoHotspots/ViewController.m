//
//  ViewController.m
//  neoHotspots
//
//  Created by Xiaohe Hu on 9/26/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "neoHotspotsView.h"
@interface ViewController ()<neoHotspotViewDelegate>

@property (nonatomic, strong) NSMutableArray *arr_hotspots;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	_arr_hotspots = [[NSMutableArray alloc] init];
//    [self getDataForomPlist];
    [self loadHotspotView];
    
}


- (void)loadHotspotView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"hotspotsData" ofType:@"plist"];
    NSMutableArray *totalDataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    for (int i = 0; i < [totalDataArray count]; i++)
    {
        NSDictionary *hotspot_raw = [[NSDictionary alloc] initWithDictionary:totalDataArray[i]];
        neoHotspotsView *hotspot2 = [[neoHotspotsView alloc] initWithHotspotInfo:hotspot_raw];
        hotspot2.labelAlignment = i;
        hotspot2.tag = i;
        hotspot2.delegate = self;
        hotspot2.showArrow = YES;
        [self.view addSubview: hotspot2];
    }
}


- (void)neoHotspotsView:(neoHotspotsView *)hotspot didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"The hotspot type is %@", hotspot.contentType);
}

//=================================BELOW THIS LINE IS OLD CODE========================================================


//-(void)getDataForomPlist
//{
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:
//					  @"hotspotsData" ofType:@"plist"];
//    NSMutableArray *totalDataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
//    for (int i = 0; i < [totalDataArray count]; i++) {
//        NSDictionary *hotspotItem = totalDataArray [i];
//        
//        //Get the position of Hs
//        NSString *str_position = [[NSString alloc] initWithString:[hotspotItem objectForKey:@"xy"]];
//        NSRange range = [str_position rangeOfString:@","];
//        NSString *str_x = [str_position substringWithRange:NSMakeRange(0, range.location)];
//        NSString *str_y = [str_position substringFromIndex:(range.location + 1)];
//        float hs_x = [str_x floatValue];
//        float hs_y = [str_y floatValue];
//        _myHotspots = [[neoHotspotsView alloc] initWithFrame:CGRectMake(hs_x, hs_y, 40, 40)];
//        _myHotspots.delegate=self;
//		[_arr_hotspots addObject:_myHotspots];
//		
//        //Get the angle of arrow
//        NSString *str_angle = [[NSString alloc] initWithString:[hotspotItem objectForKey:@"angle"]];
//        if ([str_angle isEqualToString:@""]) {
//        }
//        else
//        {
//            float hsAngle = [str_angle floatValue];
//            _myHotspots.arwAngle = hsAngle;
//        }
//        
//        //Get the name of BG img name
//        NSString *str_bgName = [[NSString alloc] initWithString:[hotspotItem objectForKey:@"background"]];
//        _myHotspots.hotspotBgName = str_bgName;
//        
//        //Get the caption of hotspot
//        NSString *str_caption = [[NSString alloc] initWithString:[hotspotItem objectForKey:@"caption"]];
//        _myHotspots.str_labelText = str_caption;
//        _myHotspots.labelAlignment = CaptionAlignmentBottom;
//        
//        //Get the type of hotspot
//        NSString *str_type = [[NSString alloc] initWithString:[hotspotItem objectForKey:@"type"]];
//        _myHotspots.str_typeOfHs = str_type;
////        NSLog(@"Hotspot No.%i's type is: %@ \n\n",i ,str_type);
//        
//        //Animation time can be set
//        //_myHotspots.timeRotate = 5.0;
//        _myHotspots.tagOfHs = i;
/*
 Chang the label's alignment according to the tag of hotspot
 
        if (_myHotspots.tagOfHs == 0)
        {
            _myHotspots.labelAlignment = CaptionAlignmentBottom;
         }
        if (_myHotspots.tagOfHs == 1)
        {
            _myHotspots.labelAlignment = CaptionAlignmentBottomLeft;
        }
        if (_myHotspots.tagOfHs == 2)
        {
            _myHotspots.labelAlignment = CaptionAlignmentLeft;
        }
        if (_myHotspots.tagOfHs == 3)
        {
            _myHotspots.labelAlignment = CaptionAlignmentTopLeft;
        }
        if (_myHotspots.tagOfHs == 4)
        {
            _myHotspots.labelAlignment = CaptionAlignmentTop;
        }
        if (_myHotspots.tagOfHs == 5)
        {
            _myHotspots.labelAlignment = CaptionAlignmentTopRight;
        }
        if (_myHotspots.tagOfHs == 6)
        {
            _myHotspots.labelAlignment = CaptionAlignmentRight;
        }
        if (_myHotspots.tagOfHs == 7)
        {
            _myHotspots.labelAlignment = CaptionAlignmentBottomRight;
        }
*/
//        [self.view addSubview:_myHotspots];
//    }
//}

//#pragma -mark Delegate Method
//-(void)neoHotspotsView:(neoHotspotsView *)hotspot didSelectItemAtIndex:(NSInteger)index
//{
//	neoHotspotsView *tmp = _arr_hotspots[index];
//	NSString *fileType = [NSString stringWithFormat:@"Hotspot index is %i and is a type of %@",tmp.tagOfHs, tmp.str_typeOfHs];
//	
//	UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hotspot Tapped!"
//                                                      message:fileType
//                                                     delegate:nil
//                                            cancelButtonTitle:@"OK"
//                                            otherButtonTitles:nil];
//    [message show];
//}



-(void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
