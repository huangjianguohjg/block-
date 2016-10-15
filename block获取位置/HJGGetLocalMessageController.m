//
//  HJGGetLocalMessageController.m
//  block获取位置
//
//  Created by 黄建国 on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HJGGetLocalMessageController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface HJGGetLocalMessageController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) UIButton *but;
@property(nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *localMessage;
@end

@implementation HJGGetLocalMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationStart];
    self.but = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 50, 30)];
    self.but.backgroundColor = [UIColor redColor];
    [self.but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.but];
}

- (void)butClick{
    if (_block) {
        self.block(self.localMessage);
    }
    [self dismissViewControllerAnimated:self completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}


//开始定位
-(void)locationStart{
    //判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [self.locationManager requestWhenInUseAuthorization];
        }
        // 开始定位
        [self.locationManager startUpdatingLocation];
    }else {
        //提示用户无法进行定位操作
        NSLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
        
    }
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.locationManager stopUpdatingLocation];
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    CLLocation *loaction = [[CLLocation alloc] initWithLatitude:[self.latitudeLabel.text doubleValue] longitude:[self.longitudeLabel.text doubleValue]];
    NSLog(@"%@",currentLocation);
    self.localMessage = (NSString *)currentLocation;
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count >0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *currCity = placemark.locality;
             if (!currCity) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
             }
             
         } else if (error ==nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error !=nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
         
     }];
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code ==kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    
}

@end
