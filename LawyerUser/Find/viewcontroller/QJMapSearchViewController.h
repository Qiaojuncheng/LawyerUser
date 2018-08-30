//
//  QJMapSearchViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/14.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "TLCityPickerController.h"

@interface QJMapSearchViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,TLCityPickerDelegate>{
    
    UITableView * _tv ;
    NSMutableArray * DataArray;
    
    BMKMapView * _mapView ;
    
    BMKLocationService * _locServiece;
    
}


@end
