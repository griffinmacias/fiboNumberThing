//
//  ViewController.m
//  Fibonacci
//
//  Created by Matsumoto Taichi on 4/7/15.
//  Copyright (c) 2015 iHeartMedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *numberTableView;
@property (strong, nonatomic) NSMutableArray *numbers;
@property (nonatomic) long long counter;
@property (nonatomic) long long limiter;
@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.numberTableView.delegate = self;
    self.numberTableView.dataSource = self;
    self.numbers = [@[@0, @1] mutableCopy];
    self.counter = 0;
    self.limiter = 100;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startInfiniteLoop];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)startInfiniteLoop {
    while (self.counter < self.limiter) {
        [self fiboNumber];
        self.counter++;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.numberTableView reloadData];
    });
    self.limiter = self.counter + 100;
}

-(void)fiboNumber {
        NSNumber *mostRecentNumber = self.numbers[self.numbers.count -1];
        NSNumber *secondMostRecentFiboNumber = self.numbers[self.numbers.count -2];
        NSUInteger thisFiboNumber = mostRecentNumber.unsignedLongLongValue + secondMostRecentFiboNumber.unsignedLongLongValue;
        NSNumber *theFiboNumber = @(thisFiboNumber);
        NSLog(@"fibo number being added %@", theFiboNumber);
        [self.numbers addObject:theFiboNumber];
}

//-(NSNumber *)fibonacciNumberAtIndex:(long long)index {
//    NSMutableArray *fibonacciNumbers = [@[@0, @1]mutableCopy];
//    if (index == 0) {
//        return @0;
//    }
//    if (index == 1) {
//        return @1;
//    }
//    for (NSInteger i = 0; i < index - 1; i++) {
//        NSNumber *mostRecentNumber = fibonacciNumbers[fibonacciNumbers.count -1];
//        NSNumber *secondMostRecentFiboNumber = fibonacciNumbers[fibonacciNumbers.count -2];
//        NSUInteger thisFiboNumber = mostRecentNumber.unsignedLongLongValue + secondMostRecentFiboNumber.unsignedLongLongValue;
//        NSNumber *theFiboNumber = @(thisFiboNumber);
//        [fibonacciNumbers addObject:theFiboNumber];
//    }
//    NSNumber *theNextFiboNumber = fibonacciNumbers.lastObject;
//    return theNextFiboNumber;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"objects in the array %lu", self.numbers.count);
    return self.numbers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BasicCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.numbers[indexPath.row]];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self startInfiniteLoop];
}
@end
