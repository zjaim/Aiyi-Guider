//
//  FirstViewController.h
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <UISearchBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
  //遵循搜索框控件，定位管理器，地图视图，大头针对象协议

@end
