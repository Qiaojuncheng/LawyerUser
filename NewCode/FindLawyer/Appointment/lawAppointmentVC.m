//
//  lawAppointmentVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/18.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawAppointmentVC.h"
#import "LYSDatePicker.h"
#import "LawSelectTypeofCaseView.h"
#import "LawConsultTypeModel.h"
@interface lawAppointmentVC ()<UITextFieldDelegate,LYSDatePickerDelegate,LYSDatePickerDataSource>{
    
    LYSDatePicker *pickerView ;
    
    NSDate *  Selectdate ;// 选中的时间；
    NSDate * tempdate ;// 中间的参数；

}
@property (strong , nonatomic) LawSelectTypeofCaseView * selectCaseTypeView;
@property (strong , nonatomic) LawConsultTypeModel * casetypeModel;
@property (strong , nonatomic) UIView * TimeView;

@end

@implementation lawAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.selectCaseTypeView];
    [self.view addSubview:self.TimeView];
    self.TimeTopView.hidden = !self.IsPhoneMeeting;
    self.ViewTopHeight.constant = NavStatusBarHeight;
    if(self.IsPhoneMeeting){
        [self addCenterLabelWithTitle:@"电话咨询" titleColor:nil];
    }else{
        [self addCenterLabelWithTitle:@"预约面谈" titleColor:nil];
     }
    self.NameField.delegate = self ;
    self.PhoneTextField.delegate = self ;
    
    [self.TypeLb  whenTouchedUp:^{
        [self showTypeVIew];
    }];
    
    [self.TimeLb whenTouchedUp:^{
        [self showTimeView];

    }];
   
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 
-(void)showTypeVIew{
    
    self.selectCaseTypeView.hidden = NO;

}
-(UIView *)TimeView{
    if (!_TimeView) {
        _TimeView  = [[UIView alloc]initWithFrame:self.view.bounds];
        pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 256, SCREENWIDTH, 256) type:(LYSDatePickerTypeCustom)];
        pickerView.datePickerMode = LYSDatePickerModeYearAndDateAndTime;
        pickerView.weekDayType = LYSDatePickerWeekDayTypeWeekdaySymbols;
        pickerView.hourStandard = LYSDatePickerStandard12Hour;
        pickerView.date = [NSDate date];
        pickerView.labelFont = [UIFont systemFontOfSize:14];
        LYSDateHeaderBarItem *cancelItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"取消" target:self action:@selector(cancelAction:)];
        
        cancelItem.tintColor = [UIColor colorWithHex:0x999999];
        
        LYSDateHeaderBarItem *commitItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"确定" target:self action:@selector(commitAction:)];
        
        commitItem.tintColor = MAINCOLOR;
        LYSDateHeaderBar * headerBar = [[LYSDateHeaderBar alloc] init];
        headerBar.titleView.backgroundColor = [UIColor whiteColor];
        headerBar.leftBarItem = cancelItem;
        headerBar.rightBarItem = commitItem;
        headerBar.title = @"请选择预约时间";
        headerBar.titleColor = [UIColor colorWithHex:0x333333];;
        
        pickerView.headerView.headerBar = headerBar;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.headerView.backgroundHexColor =@"#FFFFFF";
        [_TimeView addSubview:pickerView];
        _TimeView.hidden = YES ;
        [_TimeView whenTouchedUp:^{
            self->_TimeView.hidden = YES ;
        }];
    }
    return _TimeView;
}
-(void)showTimeView{
    
    self.TimeView.hidden = NO ;
}
- (void)cancelAction:(LYSDateHeaderBarItem *)sender
{
    self.TimeView.hidden = YES ;
    tempdate = nil;
    NSLog(@"取消");
  }
 - (void)commitAction:(LYSDateHeaderBarItem *)sender
{
    self.TimeView.hidden = YES ;
    
    Selectdate = tempdate;
     NSInteger timeSp = [[NSNumber numberWithDouble:[Selectdate timeIntervalSince1970]] integerValue];
      NSString * dateStr = [NSString timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",(long)timeSp]];
    self.TimeLb.text = dateStr;
    NSLog(@"确定");
}
-(void)datePicker:(LYSDatePicker *)pickerView didSelectDate:(NSDate *)date{
    tempdate  =  date   ;

 }

-(LawSelectTypeofCaseView *)selectCaseTypeView{
    if (!_selectCaseTypeView) {
        _selectCaseTypeView  =[[LawSelectTypeofCaseView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        LawSelectTypeofCaseView *extractedExpr = _selectCaseTypeView;
        
        extractedExpr.dataArray = [[NSMutableArray alloc]initWithObjects:self.casetypeModel, nil];
        MJWeakSelf
        _selectCaseTypeView.hidden = YES;
        _selectCaseTypeView.MaxNumber = 1;
          _selectCaseTypeView.selectBlock = ^(NSArray *seleArray) {
 
              if(seleArray.count  > 0){
                  weakSelf.casetypeModel = seleArray[0];
                 weakSelf.TypeLb.text  = weakSelf.casetypeModel.name;
              }
 
            
         };
    }
    return _selectCaseTypeView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
