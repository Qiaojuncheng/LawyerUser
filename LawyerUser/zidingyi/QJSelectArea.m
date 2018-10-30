//
//  QJSelectArea.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSelectArea.h"

@implementation QJSelectArea{
//   省份
    NSString * provinceStr;
    NSString * provinceId;

//   城市
    NSString * cityStr;
    NSString * cityId;
    
//   区域
    NSString * AreaStr;
    NSString * AreaId;


}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSubView];
        
        
    }
    return self;
}

-(void)makeSubView{
//    self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    self.backgroundColor = [UIColor whiteColor];
    // 创建 确定和取消按钮
    for (int i = 0; i< 2; i++) {
        UIButton * bu =[ UIButton buttonWithType:UIButtonTypeCustom];
        if (i== 0) {
            bu.frame =CGRectMake(10, 10, 50 , 35);
            [bu setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            bu.frame =CGRectMake(self.frame.size.width - 60, 10, 50, 35);
            [bu setTitle:@"确定" forState:UIControlStateNormal];
        }
        [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = 20+i;
        [self addSubview:bu];
    }
    //获取数据源
    
    [self makeData];
    
    
    //  创建pickView；
    self.selectAreaPick = [[ UIPickerView  alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 200)];
    
    self.selectAreaPick.dataSource = self;
    self.selectAreaPick.delegate =self;
    [self addSubview:self.selectAreaPick];
    
    
}

#pragma mark  获取数据源

-(void)makeData{
 
    
    
//    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lot" ofType:@"plist"]];
    
     FirstDataArray =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lot" ofType:@"plist"]];
    
    
    SecondDataArray  =[[NSArray alloc]initWithArray:[FirstDataArray[0] objectForKey:@"next_child"]];
    ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[0] objectForKey:@"last_child"]];

    
    provinceStr  =  [FirstDataArray[0] objectForKey:@"name"];
    provinceId =[FirstDataArray[0] objectForKey:@"id"] ;
    cityStr =  [SecondDataArray[0] objectForKey:@"name"];
     cityId = [SecondDataArray[0] objectForKey:@"id"];
    if (ThirdDataArray.count >  0) {
        AreaStr = [ThirdDataArray[0] objectForKey:@"name"];
        AreaId = [ThirdDataArray[0] objectForKey:@"id"];
        
    }else{
        AreaStr = @"";
    }


}

#pragma mark   pickViewdelegate


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component ==0) {
        return  FirstDataArray.count;
    }else if (component == 1){
        return  SecondDataArray.count;
    }else{
        return  ThirdDataArray.count;
        }
 }

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component ==0) {
        return  [FirstDataArray[row] objectForKey:@"name"];
    }else if (component == 1){
        return  [SecondDataArray[row] objectForKey:@"name"];
    }else{
        return  [ThirdDataArray[row] objectForKey:@"name"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    if (component ==0) {
        
        
       
        
        // 获取 城市  区域 数据  刷新
        SecondDataArray  =[[NSArray alloc]initWithArray:[FirstDataArray[row] objectForKey:@"next_child"]];
        ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[0] objectForKey:@"last_child"]];
        
        
        provinceStr  =  [FirstDataArray[row] objectForKey:@"name"];
        provinceId =[FirstDataArray[row] objectForKey:@"id"] ;

        cityStr =  [SecondDataArray[0] objectForKey:@"name"];
        cityId = [SecondDataArray[0] objectForKey:@"id"];

        if (ThirdDataArray.count >  0) {
            AreaStr = [ThirdDataArray[0] objectForKey:@"name"];
            AreaId = [ThirdDataArray[0] objectForKey:@"id"];

        }else{
        AreaStr = @"";
        }
        
        [self.selectAreaPick reloadComponent:1];
        [self.selectAreaPick reloadComponent:2];

     }else if (component == 1){
         // 获取 区域 数据  刷新
         ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[row] objectForKey:@"last_child"]];

         cityStr =  [SecondDataArray[row] objectForKey:@"name"];
         cityId = [SecondDataArray[row] objectForKey:@"id"];

         if (ThirdDataArray.count >  0) {
             AreaStr = [ThirdDataArray[0] objectForKey:@"name"];
             AreaId = [ThirdDataArray[0] objectForKey:@"id"];

             
         }else{
             AreaStr = @"";
         }
 
         
         [self.selectAreaPick reloadComponent:2];

     }else{
         
         if (ThirdDataArray.count >  0) {
             AreaStr = [ThirdDataArray[row] objectForKey:@"name"];
             AreaId = [ThirdDataArray[row] objectForKey:@"id"];

             
         }else{
             AreaStr = @"";
         }
         

     }









}


-(void)btnAction:(UIButton *)sender{
    if (sender.tag == 20) {
        
        self.CertainBlock(NO, nil, nil, nil, nil);
    }else{
        // 返回选中的地区
        NSString * BactStr;
        if ([AreaStr  isEqualToString: @""]) {
            BactStr = [NSString stringWithFormat:@"%@ %@", provinceStr,cityStr ];
        }else{
          BactStr = [NSString stringWithFormat:@"%@ %@ %@", provinceStr,cityStr,AreaStr];
        }
        self.CertainBlock(YES, BactStr, provinceId, cityId, AreaId);
    }
}

@end
