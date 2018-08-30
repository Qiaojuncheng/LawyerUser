//
//  WYChoseFileQJViewController.m
//  Lawyer
//
//  Created by yu on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYChoseFileQJViewController.h"
#import "WYFileTableViewCell.h"
@interface WYChoseFileQJViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *fileTable;
    NSArray *FileArr;
    NSString *filePath;
    NSDictionary *fileDic;
    NSString *fileMingzi;//文件名字
    NSString *FileType;//文件类型
}
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic, copy) NSString *selectedRoomStr;

@end

@implementation WYChoseFileQJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文件列表";
    // FileArr = [NSMutableArray array];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedView)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self makeTableview];
    [self makeFileArray];

}
- (void)onClickedView{
    if (FileType.length == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    fileDic = @{@"WenType":FileType,@"WenMingzi":fileMingzi,@"WenPath":_selectedRoomStr};
     if (self.selectedRoomStr) {
        self.selectedRoomBlock(fileDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark  获取所有文件
- (void)makeFileArray{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"wangFile"];
    NSLog(@"%@",filePath);
    FileArr  = [NSArray array];
    FileArr = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
    NSLog(@"%@",FileArr);
    
    if (FileArr.count == 0) {

        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"请在手机中找到需要上传的文件选择本应用打开" preferredStyle:UIAlertControllerStyleAlert];
         [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
     
 }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    [fileTable reloadData];
    
}
- (void)makeTableview{
    fileTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    fileTable.delegate = self;
    fileTable.dataSource = self;
    fileTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:fileTable];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return FileArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYFileTableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"WYFileTableViewCell" owner:self options:nil]lastObject];
    }
    cell.fileNameLab.text = FileArr[indexPath.row];
    [cell.choseBtn addTarget:self action:@selector(didChoseFile:) forControlEvents:UIControlEventTouchUpInside];
    cell.choseBtn.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didChoseFile:(UIButton *)sender{
    if (sender!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }else{
        self.selectedBtn.selected = YES;
    }
    
    
    if (sender.selected == YES) {
        fileMingzi = FileArr[sender.tag];
        NSLog(@"%@",
              // _selectedRoomStr  = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@",FileArr[sender.tag]]];
              _selectedRoomStr  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"wangFile/%@",fileMingzi]]);;
        [self filePathWithUrl:_selectedRoomStr];
        
        NSLog(@"%@",_selectedRoomStr);
    }
    
}
- (void)filePathWithUrl:(NSString *)path{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSMutableURLRequest *requestpath = [NSMutableURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:requestpath returningResponse:&response error:nil];
    FileType = response.MIMEType;
    NSLog(@"%@",response.MIMEType);
}
- (void)returnRoomName:(SelectedRoomBlock)block{
    self.selectedRoomBlock = block;
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
