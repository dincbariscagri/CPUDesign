
/*


BAD Basic Assembler for Kintel
Created by: Barış Dinç
Instructions Supported : 16

Compiled on GCC 8.1.0
Written on Visial Studio Code



*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countoccurrences(char *filename, char c);
int getPos(char *token);
int getInt(char *token);
int assembler(char *line, int programCounter, int labelcount, char **labelname, int *labeladdress);
int* decToBinary(int n) ;
int* decToHexa(int n); 

//Register table 
char registerTable[8][2]={"$0","$1",
                            "$2","$3",
                            "$4","$5","$6","$7",
                            };

//Instruction lookup table
char nameofinst[15][5]={"add","sub","mult","div","beq","bneq","jmp","sb","lb","movi","addi","subi","slt","lbu","sbu"};
int number[15]={0,4096,8192,12288,16384,20480,24576,28672,32768,40960,45056,49152,53248,57344,61440};
int type[15]={1,1,2,2,8,8,5,4,4,6,3,3,7,4,4}; 

int main(){
    int option;
    int labelcount;

    while(option!=3){
        int labelcount,programCounter=0,labelCounter=0;
        int assembledline=0;
        
        int* labeladdress;
        char **labelname;
        fflush(stdin);
        int* binary;
        int* hexadd;
        char line [ 256 ];
        char line2 [ 256 ];
        printf("\nPlease select program mode:\n1:Interactive Mode\n2:Batch Mode\n3:Exit Program\n\n");
        scanf("%d",&option);
        
        if(option==1){
            //Reading user entered instruction
            printf("\nPlease enter line to assembly: ");
            scanf("%s %s",line,line2);
            strcat(line, " ");
            strcat(line,line2);

            //Assembler function does binary conversion
            assembledline = assembler(line,programCounter,labelcount,labelname,labeladdress);
            
            //If wrong instruction sent or instruction does not exist sends error with line with problem
            if(assembledline==0){
                printf("\nError in instruction\n"); 
            }
            //assembler function does assembly as integer, dectobinary changes it to binary 
            binary = decToHexa(assembledline);
            int j;
            for(j=3;j>-1;j--)
                printf("%c",binary[j]);
            printf("\n"); 
            
        }
        else if (option==2){
            char *fileName = (char*)malloc(sizeof(char)*50);
            printf("\nPlease enter file name: ");
            scanf("%s",fileName);

            //Opens user defined file
            FILE *file = fopen ( fileName, "r" );

            if ( file != NULL ){
                // Counts how many labels exist in so it can create a table for their addresses
                labelcount = countoccurrences(fileName,':');
                
                labelname=(char**)malloc(sizeof(char*)*labelcount);

                for(int i =0; i<labelcount; i++)
                    *(labelname+i)=(char*)malloc(sizeof(char)*50);
                labeladdress = (int*)malloc(sizeof(int)*labelcount);
                
                //reads file line by line and counts programcounter to save labels to array for later branch and jump calculations
                while ( fgets ( line, sizeof line, file ) != NULL ){
                    if (strpbrk(line, ":") != NULL){
                        char *t = strtok(line,":");
                        strcpy(labelname[labelCounter],t);                
                        labeladdress[labelCounter]=programCounter;
                        labelCounter++;
                    }         
                    programCounter+=1;
                }
            }
            else{
                printf("\nFile does not exist!\n");
                continue;
            }
            programCounter=0;

            rewind(file);
            FILE *fout = fopen("out.txt","w");

            //Starts reading file again for assembly process
            if ( file != NULL ) {    
                //does conversion line by line with assembler function        
                while ( fgets ( line, sizeof line, file ) != NULL ){  
                    printf("%s",line);
                    assembledline = assembler(line,programCounter,labelcount,labelname,labeladdress);
                    
                    if(assembledline==0){
                        printf("\nError in line: %d\n",(programCounter/4)+1);
                    }
                    
                    binary = decToHexa(assembledline);
                    hexadd = decToHexa(programCounter);
                    int j;
                    for(j=3;j>-1;j--){
                        
                        fprintf(fout,"%c",hexadd[j]);

                    }
                    fprintf(fout,":");
                    for(j=3;j>-1;j--){
                        
                        fprintf(fout,"%c",binary[j]);
                    }
                    fprintf(fout,";\n");  
                    programCounter+=1;    
                }    
                printf("\nOutput written in out.obj!\n"); 
                fclose(file);
                fclose(fout);
            }   
        }
        else if(option==3)
            exit(1);     
        else
            printf("\nOption does not exist!\n");   
    }
    return 0;
}

int assembler(char *line,int programCounter, int labelcount, char **labelname, int *labeladdress){
    char *token;
    int reg, assembledline=0;
    int types;
    char instName[5], rd[50], rs[50], rt[50], rdt[50];
    int i,k;
    int status=0;

    /*This function takes instruction and divides it into parts with comma,space between register names and instruction name etc.
    Then copies these parts into 3 different strings
    Depending on op code it does corresponding allocations to 32 bit assembly line output function works with extra spaces,tab move
    */ 

    if ((token=strpbrk(line, ":")) != NULL){
        for(i=0;i<strlen(token);i++)
            token[i]=token[i+1];   
        token = strtok(token, " \t\n");                 
    }
    else
        token = strtok(line, " \t\n");
    
    strcpy(instName,token);
    int c=1;
    while( token != NULL ) {
        token = strtok(NULL, ", )(\n");
        if(c==1){
            strcpy(rd,token); 
        }       
        else if(c==2 && token!=NULL){
            strcpy(rs,token);
        }
        else if(c==3 && token!=NULL){   
            strcpy(rt,token);    
        }
        else if(c==4 && token!=NULL){   
            strcpy(rdt,token);
            break;    
        }
        c++;
    }
    for(k=0;k<16;k++){
        //Function detects inst name and compares with table defined before depending on function it allocates corresponding bits and enters register cases
        if(strcmp(instName,nameofinst[k])==0){
            assembledline = number[k];
            types = type[k];
            
            int lAddress;
            //types here are for different register,label allocations on 32 bit (ex. add and sll are R type but requires different bitwise operations)
            switch(types){
                case 1:
                    //gets registers and after shifts puts them on their places getPos returns register number
                    //add,sub,slt
                    reg = getPos(rd);
                    reg = reg<<3;
                    assembledline=assembledline|reg;

                    reg = getPos(rs);  
                    reg = reg<<9;
                    assembledline=assembledline|reg;

                    reg = getPos(rt);
                    reg = reg<<6;
                    assembledline=assembledline|reg;

                    break;   
                case 2: 
                    // for mult and div operations
                    reg = getPos(rd);
                    reg = reg<<3;
                    assembledline=assembledline|reg;
                    
                    reg = getPos(rs);
                    assembledline=assembledline|reg;

                    reg = getPos(rt);
                    reg = reg<<9;                            
                    assembledline=assembledline|reg;

                    reg = getPos(rdt);
                    reg = reg<<6;
                    assembledline=assembledline|reg;

                    break;  
                case 3:   
                    //for Immediate                      
                    reg = getPos(rd);
                    reg = reg<<6;
                    assembledline=assembledline|reg;
                    
                    reg = getPos(rs);
                    reg = reg<<9;
                    assembledline=assembledline|reg;

                    reg = getInt(rt);
                    reg = reg&63;                           
                    assembledline=assembledline|reg;

                    break;  
                case 4:        
                    //for Sb and Lb operations                                          
                    reg = getPos(rd);
                    reg = reg<<6;
                    assembledline=assembledline|reg;
                    
                    reg = getInt(rs);
                    reg = reg&63;
                    assembledline=assembledline|reg;

                    reg = getPos(rt);
                    reg = reg<<9;
                    assembledline=assembledline|reg;
                    
                    break;  
                case 5:  
                //gets label data from previous array, and makes corresponding calculations and bitwise operations
                
                
                    for(i=0;i<labelcount;i++){  
                        if(strcmp(labelname[i],rd)==0){   
                            
                            lAddress = labeladdress[i];                                                  
                            reg = lAddress;
                            reg = reg & 4095;
                            status=1;
                            assembledline = assembledline|reg;
                            break;
                        }                        
                    }              
                    if(status==0){
                        printf("\nNo Label found!\n");
                        assembledline = 0;
                    }
                
                    break;  
                case 6:     
                    //for Movi
                    reg = getPos(rd);
                    reg = reg<<9;
                    assembledline=assembledline|reg;

                    reg = getInt(rs);
                    reg = reg<<1;
                    reg = reg & 510;
                    assembledline = assembledline | reg;

                    break;
                case 7:
                    //gets registers and after shifts puts them on their places getPos returns register number
                    //add,sub,slt
                    reg = getPos(rd);
                    reg = reg << 9;
                    assembledline = assembledline | reg;

                    reg = getPos(rs);
                    reg = reg << 6;
                    assembledline = assembledline | reg;

                    reg = getPos(rt);
                    reg = reg << 3;
                    assembledline = assembledline | reg;

                    break;
                case 8:  
                 /* gets label data from previous label array, and makes corresponding calculations and bitwise operations if no label found, 
                 checks if it is a number and writes that number to 32 bit, if case is not any of them gives no label error                    
                */
                    reg = getPos(rd);
                    reg = reg<<9;
                    assembledline=assembledline|reg;
                    
                    reg = getPos(rs);
                    reg = reg<<6;
                    assembledline=assembledline|reg;

                    for(i=0;i<labelcount;i++){                          
                        if(strcmp(labelname[i],rt)==0){  
                            lAddress = labeladdress[i];
                            reg = (lAddress-(programCounter+1));
                            reg = reg & 63;
                            status=1;
                            break;
                        }
                    }                 

                    char *t;
                    int val = strtol(rt,&t,10);                   

                    if(val !=0 && status==0){                             
                        reg = getInt(rt);                             
                    }
                    else if (status==0){
                        printf("\nError in line %d\nNo Label found!\n",(programCounter/4)+1);
                        return 0;
                    }
                    
                    assembledline = assembledline|reg;
                    break;  
            }  
        }     
    } 
    return assembledline;
}
// this functions gets register number 
int getPos(char *token){
    int i;
    for(i = 0;i<32;i++)
      if(strncmp(token,registerTable[i],2)==0)
        return (long)i;
    return 0;        
}
// this function changes char number to integer for instruction
int getInt(char *token){
    char *a;
    int signednumber=0;
    signednumber = strtol(token,&a,10) & 255;
    return signednumber;
}
//counts ':' to find how many labels are exist in the code
int countoccurrences(char *filename, char c){
    int count=0;
    FILE *fp = fopen(filename,"r");
    if (fp){
        int ch;
        while ((ch = fgetc(fp)) != EOF)
            if (ch == c) count++;

        fclose(fp);
    }
    else
        printf("Failed to open");

    return count;   
}

int* decToBinary(int n) 
{ 
    // array to store binary number 
    int *binaryNum;
    binaryNum=(int*)malloc(sizeof(int)*32); 
  
    // counter for binary array 
    int i = 0; 

    for(i=0;i<32;i++)
        binaryNum[i]=0;
    
    i=0;
    if(n<0)
        n=4294967296+n;
    while (n > 0) {   
        // storing remainder in binary array 
        binaryNum[i] = n % 2; 
        n = n / 2; 
        i++; 
    } 
        
    return binaryNum;
}

// function to convert decimal to hexadecimal 
int* decToHexa(int n) 
{    
    // char array to store hexadecimal number 
    int *hexaDeciNum;
    hexaDeciNum=(int*)malloc(sizeof(int)*32); 
      
    // counter for hexadecimal number array 
    int i = 0; 
    while(n!=0) 
    {    
        // temporary variable to store remainder 
        int temp  = 0; 
          
        // storing remainder in temp variable. 
        temp = n % 16; 
          
        // check if temp < 10 
        if(temp < 10) 
        { 
            hexaDeciNum[i] = temp + 48; 
            i++; 
        } 
        else
        { 
            hexaDeciNum[i] = temp + 55; 
            i++; 
        } 
          
        n = n/16; 
    } 
       
    
    return hexaDeciNum;
} 
