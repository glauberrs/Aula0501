//
//  ViewController.h
//  Aula0501
//
//  Created by Aluno on 08/05/15.
//  Copyright (c) 2015 Glauber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property NSMutableArray *cursos;

@end

