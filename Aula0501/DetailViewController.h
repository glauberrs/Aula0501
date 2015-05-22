//
//  DetailViewController.h
//  Aula0501
//
//  Created by Aluno on 08/05/15.
//  Copyright (c) 2015 Glauber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelNome;
@property (weak, nonatomic) IBOutlet UILabel *labelDescricao;
@property (weak) NSDictionary *curso;
@end
