//
//  ViewController.m
//  Aula0501
//
//  Created by Aluno on 08/05/15.
//  Copyright (c) 2015 Glauber. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


#define BGQUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define API_URL [NSURL URLWithString: @"http://targettrust.com.br/api/v1/course"]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cursos = [[NSMutableArray alloc] init];
    
    dispatch_async(BGQUEUE, ^{
        NSData* data = [NSData dataWithContentsOfURL:API_URL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
    /*NSDictionary* curso = [_cursos objectAtIndex:0];
    
    NSString* cour_id = [curso objectForKey:@"cour_id"];
    NSString* name = [curso objectForKey:@"name"];
     */
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    _cursos = [json objectForKey:@"courses"];
    
    NSLog(@"courses: %@", _cursos);
    [_tabela reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cursos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cursoItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[_cursos objectAtIndex:indexPath.row] objectForKey:@"name"] ;
    cell.detailTextLabel.text = [[_cursos objectAtIndex:indexPath.row] objectForKey:@"description"] ;
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Linha Selecionada"
     message:@"tocou" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [messageAlert show];*/
    
    /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
     message:@"This is an alert."
     preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action) {}];
     
     [alert addAction:defaultAction];
     [self presentViewController:alert animated:YES completion:nil];*/
    /*
     Tela02 *tela = [[Tela02 alloc] initWithNibName:@"Tela02" bundle:nil];
     tela.secaoValor = [NSString stringWithFormat:@"New S %d", (int) indexPath.section];
     [self.navigationController pushViewController:tela animated:YES];
     */
    [self performSegueWithIdentifier:@"linha" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"linha"]) {
        NSIndexPath *indexPath = [self.tabela indexPathForSelectedRow];
        //NSString *mensagem = [[_cursos objectAtIndex:indexPath.row] objectForKey:@"name"] ;
        
        //[[segue destinationViewController] setTextoDetalhe:mensagem];
        DetailViewController * tela = [segue destinationViewController];
        [tela setCurso:[_cursos objectAtIndex:indexPath.row]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
