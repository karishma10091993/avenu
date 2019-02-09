//
//  ViewController.m
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],NSForegroundColorAttributeName, nil]];
    
    
}

-(float)viewWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

-(float)viewHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}
-(void)setcolourofbutton:(UIButton *)button stringtitle:(NSString *)titlebtn {
    [button setTitle:titlebtn forState:UIControlStateNormal];
    button.backgroundColor = APPREDCOLOR;
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

