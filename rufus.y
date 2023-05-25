    %{
    void yyerror (char *s);
    #include <stdio.h>     /* C declarations used in actions */
    #include <stdlib.h>     /* C exit function */
    #include <string.h>
    #include <time.h>


    int ind=0;
    char simptoms[50][50];

    int scores[14]={0};

    char firstQuestions[5][50] ={
    "What's the matter?",
    "What's wrong?",
    "How do you feel (today)?",
    "What can I do for you?",
    "How can I help you today?"   
    };


    char *illness[14][100] = {
        {"cold", "sore throat", "sneeze", "cough", "fever", "headache", "shivering", "pain in the throat"},
        {"measles", "fever", "red rash","red dots", "itchy", "childhood"},
        {"rash", "red spots", "itchy", "uncomfortable"},
        {"sprain" "pain in ankle", "twist"},
        {"sunburn", "inflammation", "red skin", "sun"},
        {"allergies", "red eyes", "watery eyes", "itchy eyes", "nose", "coughing", "sneezing", "summer", "spring"},
        {"broken bones", "fractured", "broken", "fall"},
        {"bruise", "dark area", "painful area", "skin", "hit"},
        {"amnesia", "problem remembering", "forget"},
        {"tooth decay", "toothache", "jaw pain", "earache", "black tooth"},
        {"diabetes", "thirsty", "passing urine", "tired", "weight loss", "persistent infections"},
        {"leukaemia", "pale skin", "tiredness", "breathlessness",  "bleeding", "repeated infections"},
        {"alzheimer", "confused", "confusion", "disoriented", "lost", "speech", "language", "personality changes", "hallucinations", "low mood", "anxiety"},
        {"asthma", "wheezing", "shortness of breath", "tight chest", "cough", "coughing", "breathing faster", "drowsy", "exhausted", "dizzy", "rapid heartbeat"}
    };


    void pr(int index);
    void score();
    void printStrings(char strings[][50]);
    int getIllness();
    void restartSimptoms();


    %}

    %union {
        char* text;
    }      

    /* Yacc definitions */
    %token<text> I
    %token YES
    %token NO
    %token<text> MY
    %token<text> POSVB
    %token<text> PAINVB
    %token<text> BODYPART
    %token<text> KEYWORD
    %token<text> ACTION
    %token<text> ADVERB
    %token<text> NOUN
    %token<text> LINK
    %token ANYTHING
    %type<text> program
    %type<text> line
    /* %type<text> any_words */

    %nonassoc LINK

    

    %%


    program :  program line  {

                if(ind<2){                       
                    printStrings(simptoms);
                    printf("%d\n",scores[0]);
                }
                else{
                    printf("DR: %s","Let's recap. You said you have: ");
                    printStrings(simptoms);
                    printf("\nAm I right?\nME: ");
                }
                        
            }

            |           {
                            srand(time(0));
                            printf("\n");
                            // printf("\t\t\t\t\t\t\t\t\t\t");
                            printf("DR: %s\n","Hello, I'm Dr. Rufus!");
                            // printf("\t\t\t\t\t\t\t\t\t\t");
                            printf("DR: %s\n\n",firstQuestions[rand()%5]);
                            printf("ME: ");
                        }
            
            ;


    line	: I POSVB KEYWORD  '\n' { 
                
                strcpy(simptoms[ind++], $3);
                score($3);
            }

            | I POSVB NOUN '\n' {  

                strcpy(simptoms[ind++], $3);
                score($3);
                
            } 

            | I POSVB NOUN LINK BODYPART '\n'  {

                strcpy(simptoms[ind++], $3);
                score($3);
            }

            | I POSVB ACTION '\n'   {

                strcpy(simptoms[ind++], $3);
                score($3);
            }
                                        
            | I POSVB ACTION ACTION '\n'  {

            }
            
            | I ACTION '\n' {

                strcpy(simptoms[ind++], $2);
                score($2);
            }
            
            | I POSVB ACTION KEYWORD '\n'  {

                strcpy(simptoms[ind++], $4);
                score($4);
            } 
            | I POSVB  ADVERB '\n'  {

                strcpy(simptoms[ind++], $3);
                score($3);
            } 

            | MY BODYPART POSVB ACTION '\n'  {

                strcpy(simptoms[ind++], $2);
                strcpy(simptoms[ind++], $4);
                score($2);
            } 
            | MY BODYPART ACTION '\n'  {

                strcpy(simptoms[ind++], $2);
                strcpy(simptoms[ind++], $3);
                score($2);
            } 


            | YES '\n'{
                printf("DR: You might have %s.\n",illness[getIllness()][0] );
                exit(0);
            }

            | NO '\n'{
                printf("DR: I am sorry. Let's start over.");
                restartSimptoms();
            }


            ;



                                        


    %%                     /* C code */

    void pr(int index){
        printf("Illness: %s\n", illness[index][0]);
        int x = 1;
        while(illness[index][x]){
            printf("%s ", illness[index][x]);
            x++;
        }
    }

    void score(char* simptom){
        /* for(int i=0;simptoms[i];i++){ */
        for(int j=0;j<14;j++)
        {
            for(int k=1;illness[j][k];k++){
                if(strcmp(illness[j][k],simptoms[j])==0)
                    scores[j]++;
            }
        }
        /* } */
    }

    void printStrings(char strings[][50]){
        int len = sizeof(strings)/sizeof(char*);
        for(int i=0;i<ind;i++){
            printf("%s, ",strings[i]);
        }
    }

    int getIllness(){
        int max = 0, maxi = 0;
        for(int i=0;i<14;i++){
            if (max<scores[i]){
                max = scores[i];
                maxi = i;
            }
        }
        return maxi;
    }

    void restartSimptoms(){
        for(int i=0;i<ind;i++){
            strcpy(simptoms[i],"");
        }
        ind = 0;

        for(int i=0;i<14;i++){
            scores[i]=0;
        }
    }