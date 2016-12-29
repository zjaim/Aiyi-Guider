//
//  FirstViewController.m
//  爱易
//
//  Created by 路伟饶 on 2016/7/20.
//  Copyright © 2016年 xiaolu. All rights reserved.
//

#import "FirstViewController.h"
@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *TopSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *MainMap;
@property (weak, nonatomic) IBOutlet UIButton *LocateButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Loading;
@property (nonatomic,retain) CLLocationManager *LocationManager;
@property (nonatomic,strong) CLGeocoder *Geocoder;
@property (nonatomic,strong) MKPointAnnotation *annotation;
@property NSMutableArray *AnnotationsOnMap;
@property MKCoordinateRegion MapCenterLocation;
@property MKCoordinateSpan MapScan;
@property CLLocationCoordinate2D CAUCCoordinate;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [_Loading startAnimating];
    self.TopSearchBar.delegate=self;  //设置搜索栏对象的委托对象
    self.MainMap.delegate=self;  //地图控制器的委托对象
    _MainMap.mapType=MKMapTypeStandard;
    _CAUCCoordinate=CLLocationCoordinate2DMake(39.108, 117.35);   //设置学校中心经纬度
    _MapScan=MKCoordinateSpanMake(0.014, 0.014);   //设置纬度和经度范围
    _MapCenterLocation=MKCoordinateRegionMake(_CAUCCoordinate, _MapScan);   //MKCoordinateRegion中包含一个CLLocationCoordinate2D和一个MKCoordinateSpan
    [_MainMap setRegion:(_MapCenterLocation) animated:(YES)];  //设置地图视野
    [_LocateButton setImage:[UIImage imageNamed:(@"locateactived.png")] forState:(UIControlStateHighlighted)];
    [_Loading stopAnimating];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)ShowUsersLocation:(id)sender {  //点击显示位置按钮触发的方法
    self.LocationManager=[[CLLocationManager alloc]init];
    self.LocationManager.delegate=(id)self;  //设置定位管理器的委托对象
    [_LocationManager requestAlwaysAuthorization];  //申请定位权限
    [_LocationManager startUpdatingLocation];
    [_MainMap showsUserLocation];
    _MainMap.userTrackingMode=MKUserTrackingModeFollow;  //持续跟踪用户位置
}
- (IBAction)BackToCAUC:(id)sender {
    _MapCenterLocation=MKCoordinateRegionMake(_CAUCCoordinate, _MapScan);
    [_MainMap setRegion:(_MapCenterLocation) animated:(YES)];  //设置地图视野
}
- (IBAction)UserTapMap:(id)sender {   //单击地图手势激活
    _TopSearchBar.showsCancelButton=NO;
    [_TopSearchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {   //文本编辑开始
    searchBar.showsCancelButton=YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {   //文本编辑结束
    if(searchBar.text==nil && _AnnotationsOnMap!=nil){
        [self.MainMap removeAnnotations:(_AnnotationsOnMap)];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {   //点击搜索框的取消按钮时调用
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
    if(_AnnotationsOnMap!=nil) {
        [self.MainMap removeAnnotations:(_AnnotationsOnMap)];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {  //搜索框的搜索按钮被按下触发的方法
    [_Loading startAnimating];
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
    if(_Geocoder==nil) {
        _Geocoder=[[CLGeocoder alloc]init];
    }
    NSString *UserInputAddress=self.TopSearchBar.text;  //取搜索框中的字符串
    [self.Geocoder geocodeAddressString:(UserInputAddress) completionHandler:^(NSArray *placemarks, NSError *error) {   //开始地理位置编码（地名->经纬度坐标）
        if(error || placemarks.count==0) {   //如果出现错误或者找到的地址数为0，则弹窗提示未找到
            UIAlertController *NoPlaceFound=[UIAlertController alertControllerWithTitle:(@"未找到结果") message:(@"请更换其它关键词再试") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
            [NoPlaceFound addAction:(OkButton)];
            [self presentViewController:(NoPlaceFound) animated:(YES) completion:(nil)];
        }
        else {   //如果找到了地点
            if(_AnnotationsOnMap==nil) {
                _AnnotationsOnMap=[NSMutableArray array];
            }
            else {
                [self.MainMap removeAnnotations:(_AnnotationsOnMap)];
            }
            for(CLPlacemark *places in placemarks) {   //遍历地点数组
                MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];   //创建大头针对象
                annotation.title=places.name;
                annotation.coordinate=CLLocationCoordinate2DMake(places.location.coordinate.latitude, places.location.coordinate.longitude);   //大头针对象在地图上的位置为地点位置
                [_AnnotationsOnMap addObject:(annotation)];
                [self.MainMap addAnnotation:(annotation)];   //向地图添加大头针
                _MapCenterLocation=MKCoordinateRegionMake(annotation.coordinate, _MapScan);
                [_MainMap setRegion:(_MapCenterLocation) animated:(YES)];
            }
        }
    }];
    [_Loading stopAnimating];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {  //定位失败触发的方法
     UIAlertController *NoLocationPermission=[UIAlertController alertControllerWithTitle:(@"权限请求") message:(@"需要定位服务授权才能显示位置") preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *OkButton=[UIAlertAction actionWithTitle:(@"好") style:UIAlertActionStyleDefault handler:(nil)];
     [NoLocationPermission addAction:(OkButton)];
    [self presentViewController:(NoLocationPermission) animated:(YES) completion:(nil)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
