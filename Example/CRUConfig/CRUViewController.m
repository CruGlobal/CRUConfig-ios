//
//  CRUViewController.m
//  CRUConfig
//
//  Created by Harro on 04/25/2016.
//  Copyright (c) 2016 Harro. All rights reserved.
//

#import "CRUViewController.h"
#import "MYAPI.h"

@interface CRUViewController ()

@property (nonatomic, strong) MYAPI *myAPI;

- (IBAction)login:(id)sender;

@end

@implementation CRUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.myAPI = [[MYAPI alloc] initWithConfig:[CRUConfig sharedConfig]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
	
	UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:[@"Login for configuration: " stringByAppendingString:[CRUConfig sharedConfig].configurationName]
																		message:[NSString stringWithFormat:@"logged into %@", self.myAPI.baseURL.absoluteString]
																 preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
													   style:UIAlertActionStyleDefault
													 handler:^(UIAlertAction * action) {}];
	[loginAlert addAction:okAction];
	[self presentViewController:loginAlert animated:YES completion:nil];
	
}

@end
