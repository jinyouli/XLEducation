//
//  XLEHeadPortraitViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/2/1.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEHeadPortraitViewController.h"
#import "UIViewController+XLESemiModalView.h"
//#import "XLEImgPickerViewController.h"
#import "GKImagePicker.h"

@interface XLEHeadPortraitViewController ()<GKImagePickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) GKImagePicker *imagePicker;
@end

@implementation XLEHeadPortraitViewController

@synthesize imgView;
@synthesize popoverController;
@synthesize imagePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    self.coverView = [[UIView alloc]
                      initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.coverView.backgroundColor  = UIColor.blackColor;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 204, self.view.frame.size.width, 204)];
    backgroundView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self.view addSubview:backgroundView];
    
//    NSArray *btns = [NSArray alloc ] initWithObjects:<#(id), ...#>, nil
    CGSize size = backgroundView.frame.size;
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, size.height - 20 - 44 , size.width - 40, 44)];
    [cancelBtn setTitle:@"取    消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor grayColor] ];
    cancelBtn.tag = 3;
    [backgroundView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(backToPrevousView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pickImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, size.height - 20 * 2 - 44 * 2, size.width - 40, 44)];
    [pickImgBtn setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [pickImgBtn setBackgroundColor:[UIColor whiteColor] ];
    [pickImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pickImgBtn.tag = 2;
    [backgroundView addSubview:pickImgBtn];
    [pickImgBtn addTarget:self action:@selector(PickeImg:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photographBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, size.width - 40, 44)];
    [photographBtn setTitle:@"拍    照" forState:UIControlStateNormal];
    [photographBtn setBackgroundColor:[UIColor whiteColor] ];
    [photographBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    photographBtn.tag = 3;
    [backgroundView addSubview:photographBtn];
    
    DBG(@"navigationController: %p %s",self.navigationController,__FUNCTION__);
}

-(void)backToPrevousView:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setHeadImg:)]) {
        [self.delegate setHeadImg:nil];
    }
}

-(void)PickeImg:(id)sender
{
//    [self dismissSemiModalViewController:self];
//    XLEImgPickerViewController *pickImgVC = [[XLEImgPickerViewController alloc] init];
//    if ([self.delegate respondsToSelector:@selector(imgPickerVC:)]) {
//        [self.delegate imgPickerVC:pickImgVC];
//    }
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
    
    self.imagePicker = [[GKImagePicker alloc] init];
    self.imagePicker.cropSize = CGSizeMake(280, 280);
    self.imagePicker.delegate = self;
    self.imagePicker.resizeableCropArea = YES;
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker.imagePickerController];
    //        [self.popoverController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //
    //    } else {
    //
    //        [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
    //
    //    }
    [self presentModalViewController:self.imagePicker.imagePickerController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - UIImagePickerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
//    self.imgView.image = image;
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}

# pragma mark - GKImagePicker Delegate Methods

- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
//    self.imgView.image = image;
    if ([self.delegate respondsToSelector:@selector(setHeadImg:)]) {
        [self.delegate setHeadImg:image];
    }
    [self hideImagePicker];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideImagePicker{
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else {
        
        [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
        
    }
}


@end
