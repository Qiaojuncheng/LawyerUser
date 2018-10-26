//
//  lawCompanyImageVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/22.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawCompanyImageVC.h"
#import "LawJCImageSelect.h"
@interface lawCompanyImageVC ()<selectImagedelegate>

@end

@implementation lawCompanyImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCenterLabelWithTitle:@"企业营业执照" titleColor:nil];
    [Utile makeCorner:4 view:self.addBtn];
    [Utile makeCorner:4 view:self.ShiliImage];
    [Utile makeCorner:23 view:self.EnsureBtn];
    
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AddImageAction:(UIButton *)sender {
    
    
    LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
    selectImage.delegate = self;
    [selectImage showInViewController:self];
    
}

#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    
    
    [self.addBtn setImage:selectImage forState:UIControlStateNormal];
//    NSData   * imageData  = UIImageJPEGRepresentation(selectImage, 0.01);
//
//    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
//    [valuedic setValue:UserId forKey:@"lawyer_id"];
//
//    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
//
//    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
//    //    NewAddInfor ;
//    [dic setValue:base64String forKey:@"value"];
//    [AFManagerHelp   asyncUploadFileWithData:imageData name:@"avatar" fileName:@"PersonHeadPic.jpg" mimeType:@"image/jpeg" parameters:dic success:^(id responseObject) {
//
//        if ([responseObject[@"status"] integerValue] == 0) {
//
//
//        }else{
//            [ShowHUD showWYBTextOnly:responseObject[@"msg"] duration:2 inView:self.view];
//        }
//
//        [self hideHud];
//    } failture:^(NSError *error) {
//        [self hideHud];
//
//    }];
//
    
}
-(void)cancelSelecImage{
    
    
}

- (IBAction)EnSureAction:(UIButton *)sender {
    NSLog(@"提交");
}
@end
