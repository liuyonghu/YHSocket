//
//  ViewController.m
//  SocketDemo
//
//  Created by victorLiu on 2018/3/9.
//  Copyright © 2018年 刘勇虎. All rights reserved.
//

#import "ViewController.h"
#import "YHSocket.h"

@interface ViewController ()<YHSocketDelegate>

@property (weak, nonatomic) IBOutlet UILabel *acceptLabel;
@property (weak, nonatomic) IBOutlet UITextView *editFiled;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [YHSocket shareYHSocket].delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}
- (IBAction)sendAction:(id)sender {
    NSString *value = self.editFiled.text;
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    [[YHSocket shareYHSocket] sendData:data];
}

//MARK: YHSocketDelegate
-(void)YHSorcktReadData:(NSData *)data{
    NSString *valueString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    self.acceptLabel.text = [NSString stringWithFormat:@"接收: %@",valueString];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
