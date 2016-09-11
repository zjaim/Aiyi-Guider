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

@interface FirstViewController : UIViewController <UISearchBarDelegate,CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation>
  //遵循搜索框控件委托，定位管理器委托声明，地图视图委托，大头针对象委托协议

@end
