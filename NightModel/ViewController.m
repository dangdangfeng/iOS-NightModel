
#import "ViewController.h"
#import "DTNightVersion.h"
#import "ViewController1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dt_backgroundColorPicker = DTColorPickerWithColors([UIColor redColor],[UIColor grayColor]);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    btn.dt_backgroundColorPicker = DTColorPickerWithColors([UIColor greenColor],[UIColor orangeColor]);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click{
    ViewController1 *newVC = [ViewController1 new];
    [self.navigationController pushViewController:newVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.dt_manager.themeVersion isEqualToString:DTThemeVersionNormal]) {
        self.dt_manager.themeVersion = DTThemeVersionNight;
    }else{
        self.dt_manager.themeVersion = DTThemeVersionNormal;
    }
}

- (void)dealloc{
    NSLog(@"XXX");
}

@end
