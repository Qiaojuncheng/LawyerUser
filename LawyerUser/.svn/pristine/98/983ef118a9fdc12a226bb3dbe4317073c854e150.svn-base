//
//  QJPersonInforViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJPersonInforViewController.h"
#import "QJPersonCell.h"
#import "QJPersonImageCell.h"
#import "QJChangPersonInfoViewController.h"
#import "QJSelectDatePickView.h"
#import "QJSelectArea.h"
#import "QJPersonModel.h"

@interface QJPersonInforViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{

    QJSelectDatePickView * selectPick;
    QJSelectArea * selectAreaPick;
    UIImagePickerController *_picker;
    UIImage *selcetedImage;
    NSString *imageString;
    NSString *AreaStr;
    NSString * detailedddress;
    NSMutableDictionary * valueDic  ;

    QJPersonModel * PersonModel;
 
}

@end

@implementation QJPersonInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    valueDic = [[NSMutableDictionary alloc]init];
    self.title = @"账号信息";
    //[self makeBackItem];
    [self makeUI];

    [self makeSaveIteam];
    [self makeData];
    
    
    // Do any additional setup after loading the view.
}

-(void)makeSaveIteam{


    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(0, 0, 40, 40);
    [backBtn setTitle:@"保存" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * BackItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = BackItem;



}
-(void)saveAction
{

    [self.view endEditing:YES];
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        QJDOUser
    
    [valueDic setValue:UserId forKey:@"id"];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"-- %@",valueDic);
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {

            
            [self showHint:@"修改成功"];
        
            [self.navigationController popViewControllerAnimated:YES];
        
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)makeData{


    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJeditUser
    NSDictionary * valueDicss  = @{@"user_id":UserId};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDicss];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            PersonModel  =[QJPersonModel yy_modelWithJSON:data[@"data"]];
            AreaStr = PersonModel.address;
            detailedddress  =[NSString changeNullString: data[@"data"][@"detailedAddress"]];
            [_tv reloadData];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}


-(void)makeUI{
    
    DataArray =[[NSMutableArray alloc]initWithObjects:@"头像",@"姓名",@"公司名称",@"Email",@"地区" ,@"详细地址",nil];
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.delegate= self;
    _tv.dataSource= self;
    
    _tv.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_tv];


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        QJPersonImageCell * cell =[[[NSBundle mainBundle]loadNibNamed:@"QJPersonImageCell" owner:self options:nil]lastObject];
        
        cell.textLabel.text = DataArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        if (selcetedImage) {
            cell.perImage.image = selcetedImage;
        }else{
            [cell.perImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,PersonModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像.png"] completed:nil];
            
        }
        return cell;
        
    }else{
    
        QJPersonCell * cel =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cel == nil) {
        
            cel  = [[[NSBundle mainBundle]loadNibNamed:@"QJPersonCell" owner:self options:nil]lastObject];
        }
        cel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cel.selectionStyle =UITableViewCellSelectionStyleNone;

        cel.textLabel.text = DataArray[indexPath.row];
        if (indexPath.row == 4) {
            cel.textField.userInteractionEnabled = NO;
        }else{
            cel.textField.userInteractionEnabled = YES;
            cel.textField.delegate = self;
            cel.textField.tag = 20 + indexPath.row;
        }
        
        
        if (indexPath.row == 1) {
            cel.textField.text = PersonModel.name;
        }else if (indexPath.row == 2){
            cel.textField.text = PersonModel.unit;

     }else if (indexPath.row == 3){
         cel.textField.text = PersonModel.email;

     }else if (indexPath.row == 4){
         cel.textField.text = AreaStr;

     }else if (indexPath.row == 5){
         cel.textField.text = detailedddress;
      }
    
         return cel;
    
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    QJChangPersonInfoViewController * pvc =[[QJChangPersonInfoViewController alloc]init];
//    pvc.title = [NSString stringWithFormat:@"更改%@",DataArray[indexPath.row]];
//    pvc.hidesBottomBarWhenPushed = YES;
//    
//    
//    pvc.changBlock = ^(NSString *showStr) {
//        NSLog(@"确认修改 %@",showStr);
//    };
    if (indexPath.row == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!_picker) {
                _picker = [[UIImagePickerController alloc]init];
            }
            _picker.delegate = self;
            _picker.allowsEditing = YES;
            //        _picker.videoQuality = UIImagePickerControllerQualityTypeLow;
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_picker animated:YES completion:^{
                
            }];
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
        }];
        UIAlertAction *thiredAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:firstAction];
        [alertC addAction:secondAction];
        [alertC addAction:thiredAction];
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
 
        
//        
//    }else if (indexPath.row  == 1){
//        [self.navigationController pushViewController:pvc animated:YES];
//        
//    }else if (indexPath.row  == 2){
//        [self.navigationController pushViewController:pvc animated:YES];
//        
//    }else if (indexPath.row  == 3){
//        [self.navigationController pushViewController:pvc animated:YES];
//        
//    }else if (indexPath.row  == 4){
//        [self.navigationController pushViewController:pvc animated:YES];
//        
    }else if (indexPath.row == 4){
    
        if (!selectPick) {
         
  
        
            UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
            [backBtn addTarget:self action:@selector(RemoveVIew:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backBtn];
            selectAreaPick =[[QJSelectArea alloc]initWithFrame:CGRectMake(0, ConentViewHeight, ConentViewWidth, 250)];
            
            [self.view addSubview:selectAreaPick];
            
            __block  QJSelectArea *BlockselectAreaPick = selectAreaPick;
            __block  UITableView * WeakTv = _tv;

            selectAreaPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
                    [backBtn removeFromSuperview];

                if (IsCertain) {
                    NSLog(@"区域 %@",dateString);
                    
                    AreaStr = dateString;
                    
                    
            [valueDic setObject:prvId forKey:@"province"];
            [valueDic setObject:cityId forKey:@"city"];
            [valueDic setObject:AreaId forKey:@"area"];
                    [WeakTv reloadData];
                    
                }else{
                    
                    
                }
                [UIView animateWithDuration:0.5 animations:^{
                    BlockselectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
                } completion:^(BOOL finished) {
                    
                    [BlockselectAreaPick removeFromSuperview];
                }];
             };
            
            [UIView animateWithDuration:0.5 animations:^{
                selectAreaPick.frame = CGRectMake(0, ConentViewHeight - 250, ConentViewWidth, 250);
            }];

            
        }
        
     }else if (indexPath.row  == 6){//
        
        if (!selectPick) {
                 selectPick =[[QJSelectDatePickView alloc]init];

        }

         [selectPick showUI];
         __block  QJSelectDatePickView *BlockselectPick = selectPick;
         
         selectPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString) {
            if (IsCertain) {
                NSLog(@"日期 %@",dateString);
                
            }else{
                
            
            }
        
         [BlockselectPick Dismissself];
            
        };
        
         
    }

}
-(void)RemoveVIew:(UIButton *)sender{

    [UIView animateWithDuration:0.5 animations:^{
        selectAreaPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 250);
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        [selectAreaPick removeFromSuperview];
    }];

 }
-(void)viewWillDisappear:(BOOL)animated{
    if (selectPick) {
        selectPick.frame = CGRectMake(0, ConentViewHeight - 250, ConentViewWidth, 250);
     }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        selcetedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageOrientation imageOrientation=selcetedImage.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(selcetedImage.size);
            [selcetedImage drawInRect:CGRectMake(0, 0, selcetedImage.size.width, selcetedImage.size.height)];
            selcetedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    }else
    {
        selcetedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageOrientation imageOrientation=selcetedImage.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(selcetedImage.size);
            [selcetedImage drawInRect:CGRectMake(0, 0, selcetedImage.size.width, selcetedImage.size.height)];
            selcetedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    }
    NSData *data = UIImageJPEGRepresentation(selcetedImage, 0.001);
    [_tv reloadData];
    
    imageString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    [valueDic setValue:imageString forKey:@"avatar"];
//    self.perImg.image = selcetedImage;
    NSLog(@"选中的图片！在这里");
    [self dismissViewControllerAnimated:NO completion:^{
        //        [self requestDataZiLiao];
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

 if (textField.tag == 21){// 名字
        
     [valueDic setValue:textField.text forKey:@"name"];
     PersonModel.name = textField.text;
    }
    else if (textField.tag == 22){ // 公司名称
        [valueDic setValue:textField.text forKey:@"unit"];
         PersonModel.unit =textField.text;

    }
    else if (textField.tag == 23){ // email
        [valueDic setValue:textField.text forKey:@"email"];
         PersonModel.email =textField.text;
    }
    else if (textField.tag == 25){ // 详细地址
        [valueDic setValue:textField.text forKey:@"detailedAddress"];
         PersonModel.address =textField.text;
    }




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
