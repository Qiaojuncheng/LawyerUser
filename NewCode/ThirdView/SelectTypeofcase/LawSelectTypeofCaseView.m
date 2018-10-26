//
//  LawSelectTypeofCaseView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSelectTypeofCaseView.h"
#import "LawSelectLeftCaseCell.h"
#import "LawzSekectRightCell.h"
#import "LawConsultTypeModel.h"
@implementation LawSelectTypeofCaseView

-(void)setDataArray:(NSMutableArray *)dataArray{
    rightselectIDArray = [[NSMutableArray alloc]initWithArray:dataArray];
    leftDataArray =[[NSMutableArray alloc]init];
    self.backgroundColor =  [UIColor colorWithHex:0x000000 alpha:0.5];
    
    [self addcenterView];
    [self makeSubView];
    [self makeData];
    
    
}
-(void)addcenterView{
    centerView =[[UIView alloc]initWithFrame:CGRectMake(44, 0, SCREENWIDTH - 88, self.height/2)];
    centerView.center = self.center;
    centerView.backgroundColor = [UIColor whiteColor];
    [Utile makeCorner:10 view:centerView ];
    
    UILabel * typeLB =[[UILabel alloc]initWithFrame:CGRectMake(64, 0, centerView.width - 64 *2 , 46)];
    typeLB.textColor = DEEPTintColor;
    typeLB.text = @"请选择类型";
    typeLB.textAlignment =  NSTextAlignmentCenter;
    [centerView addSubview:typeLB];
    
    UIView * linview = [[UIView alloc]initWithFrame:CGRectMake(typeLB.right, 0, 1, 64)];
    linview.backgroundColor  = LINECOLOR;
    [centerView addSubview:linview];
    
  
    
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame  = CGRectMake(typeLB.right +1, 0, 64, 46);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHex:0x3181FE] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.adjustsImageWhenHighlighted = NO;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:sureBtn ];
    UIView * linviews = [[UIView alloc]initWithFrame:CGRectMake(0, 45, centerView.width, 1)];
    linviews.backgroundColor  = MainBackColor;
    [centerView addSubview:linviews];
    
    
    
    [self addSubview:centerView];
}
-(void)makeSubView{
    leftselect = -1;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddaction:)];
    tap.delegate= self;
    [self addGestureRecognizer:tap];
    _leftTv = [self makeLeftOrRight:YES];
    _rightTv =[self makeLeftOrRight:NO];
    
    [centerView addSubview:_leftTv];
    [centerView addSubview:_rightTv];
}
-(void)hiddaction:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }else{
        return NO;
    }
    
}


-(UITableView *)makeLeftOrRight:(BOOL) left{
    UITableView * tablev =[[UITableView alloc]initWithFrame:CGRectMake(  left? 0:centerView.width/5*2,46  ,left?centerView.width/5*2:centerView.width/5*3, centerView.height - 46 ) style:UITableViewStylePlain];
    if (left){
        tablev.backgroundColor =[UIColor whiteColor];
    }else{
        tablev.backgroundColor =[UIColor colorWithHex:0xF7F7F7];
    }
    tablev.separatorColor = [UIColor colorWithHex:0xEBEBEB];
    
    
    tablev.delegate=  self;
    tablev.dataSource = self;
    tablev.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    tablev.backgroundColor =[UIColor whiteColor];
    tablev.tableFooterView = [[UIView alloc]init];
    
    return tablev;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTv) {
        return  leftDataArray.count;
    }else{
        return  rightDataArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    if (tableView == _leftTv) {
        
        LawSelectLeftCaseCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSelectLeftCaseCell" owner:self options:nil]lastObject];
        }
        //    cell.model = dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        LawConsultTypeModel  * TypeModel = leftDataArray[indexPath.row];

        cell.typeLabel.text =TypeModel.name ;
        if (indexPath.row == leftselect) {
            cell.typeLabel.textColor= [UIColor colorWithHex:0x3181FE];
            cell.backgroundColor = MainBackColor;
        }else{
            cell.typeLabel.textColor = DEEPTintColor;
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell ;
    }else{
      
        
        
        LawzSekectRightCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawzSekectRightCell" owner:self options:nil]lastObject];
        }
        //    cell.model = dataArrray[indexPath.row];
        cell.backgroundColor = MainBackColor;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        LawConsultTypeModel  * TypeModel = rightDataArray[indexPath.row];
        cell.CaseTypeLB.text =TypeModel.name ;
        
        cell.CaseTypeLB.textColor =DEEPTintColor;
        cell.SelectImage.image =[UIImage imageNamed:@"pay_select"];
 
        for (LawConsultTypeModel * model  in rightselectIDArray) {
           
            if( [TypeModel.id isEqualToString:model.id]){
                cell.CaseTypeLB.textColor= [UIColor colorWithHex:0x3181FE];
                cell.SelectImage.image =[UIImage imageNamed:@"icon_paysuccess"];

            }
            
        }
      
        return  cell ;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTv) {
        leftselect = indexPath.row;
       
        LawConsultTypeModel  * TypeModel = leftDataArray[indexPath.row];
        rightDataArray = TypeModel.second_child;
        [_rightTv  reloadData];
        [_leftTv reloadData];
    }else{
        BOOL containModel;
        containModel  = YES ; // YES 添加，NO不添加
        LawConsultTypeModel * Selectmodel = rightDataArray[indexPath.row];
       
        for (LawConsultTypeModel * model  in rightselectIDArray.reverseObjectEnumerator) {
            if( [Selectmodel.id isEqualToString:model.id]){
                [rightselectIDArray removeObject:model];
                containModel = NO;
             }else{
                
            }
        }
        if (containModel) {
            if(rightselectIDArray.count > self.MaxNumber -1 && self.MaxNumber != 1){
                [self.belongViewController showHint:[NSString stringWithFormat:@"最可以选%ld条！",_MaxNumber]];
            }else{
                if( self.MaxNumber ==1){
                    [rightselectIDArray removeAllObjects];
                    [rightselectIDArray addObject:Selectmodel];

                    }else{
                        
                    [rightselectIDArray addObject:Selectmodel];

                }
            }
            
        }
        
         [_rightTv  reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}

-(void)makeData{
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultGetType
    //    获取分类
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
           if ([responseObjeck[@"status"] integerValue] == 0) {
            for (NSDictionary * proDic in responseObjeck[@"data"]) {
                
                LawConsultTypeModel * TypeModel =[LawConsultTypeModel yy_modelWithJSON:proDic];
                [leftDataArray addObject:TypeModel];
                
            }
               if (leftDataArray.count > 0) {
                   LawConsultTypeModel  * TypeModel = leftDataArray[0];
                   rightDataArray = TypeModel.second_child;
               }
               [_leftTv reloadData];
               [_rightTv reloadData];
           }else{
        
        }
    } failure:^(NSError *error) {
     }];
    
}
-(void)sureAction{
    [self hiddaction:nil];
    if (self.selectBlock) {
        self.selectBlock(rightselectIDArray);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
