    %{
    void yyerror (char *s);
    #include <stdio.h>     /* C declarations used in actions */
    #include <stdlib.h>     /* C exit function */
    #include <string.h>
    #include <time.h>

    #define QUESTIONS 5

    int err=0;
    int okMessage=0;
    int ind=0;
    int questions=0;
    char **simptoms;

    char remember[50];
    char notrepeat;

    int scores[17]={0};

    char firstQuestions[5][50] ={
    "What's the matter?",
    "What's wrong?",
    "How do you feel (today)?",
    "What can I do for you?",
    "How can I help you today?" 
    };

    char defaultQuestions[7][100]={
        "What else bothers you?",
        "What else hurts?",
        "What else seems to be the problem?",
        "Has the pain been getting better or worse?",
        "Do you have any other pain?",
        "Can you tell me more about your symptoms? ",
        "Are you experiencing any other specific pains or discomforts? " 
    };


    char *illnessSymptoms[17][100] = {
    /*1 */    {"cold", "sore throat", "fever", "headache",  "pain"},
    /*2 */    {"measles", "fever", "red rash","red dots"},
    /*3 */    {"rash", "red spots"},
    /*4 */    {"sprain", "pain", "a twist"},
    /*5 */    {"sunburn", "an inflammation", "red skin"},
    /*6 */    {"allergies", "red eyes", "watery eyes", "itchy eyes"},
    /*7 */    {"broken bones", "pain","an inflammation"},
    /*8 */    {"bruise", "a dark area", "a painful area", "pain"},
    /*9 */    {"amnesia", "a problem remembering things", "a problem forgetting things"},
    /*10*/    {"gastroenteritis", "loss of appetite","vomiting","nausea","abdominal cramps","abdominal pain","diarrhoea"},
    /*11*/    {"tooth decay", "toothache", "jaw pain", "earache", "a black tooth"},
    /*12*/    {"otitis","earache","pain","loss of balance","hearing difficulties"},
    /*13*/    {"Conjunctivitis", "redness","a tearing sensation","a burning sensation", "red eyes", " an inflammation"},
    /*14*/    {"diabetes", "thirst", "passing urine", "tiredness", "weight loss", "persistent infections","infections"},
    /*15*/    {"leukaemia", "pale skin", "tiredness", "breathlessness", "repeated infections","infections"},
    /*16*/    {"alzheimer",  "confusion", "disorientation", "personality changes", "hallucinations", "low mood", "anxiety"},
    /*17*/    {"asthma",  "shortness of breath", "a tight chest", "faster breathing", "drowsiness", "exhaustion", "dizziness", "rapid heartbeat"}
    };

    char *illnessAux[17][100] = {
    /*1 */    {"sneeze","sneezed","cough","coughed", "shivered","shivere", "throat","neck", "sneezing", "coughing","shivering",},
    /*2 */    {"itchy", "childhood","skin"},
    /*3 */    {"itchy", "uncomfortable","skin", "itchying"},
    /*4 */    {"pain",  "ankle", "twist"},
    /*5 */    {"sun", "skin","inflammation"},
    /*6 */    {"watery","eyes", "itchy","eyes", "nose","cough","coughed", "sneeze","sneezed", "coughing","sneezing"},
    /*7 */    {"broken bones", "fracturing","fracture","pain","inflammation","fractured", "broken","break","breaking","broke", "fall","bones","arm","leg"},
    /*8 */    {"skin", "hit","dark area", "painful area"},
    /*9*/     {"problem", "remembering", "remember","remembered","forget","forgot", "forgetting","forgetting moments","problem remembering"},
    /*10*/    {"loss","lost", "appetite", "bloated","nauseous","vomite","vomited", "bloating"},
    /*11*/    {"jaw", "pain", "black", "tooth","black tooth"},
    /*12*/    {"ear","hearing" ,"difficulties"},
    /*13*/    {"itchy","teared","tear","burned","burn", "eyelids","red","eye","eyes","inflammated","inflammation","tearing","burning","itching"},
    /*14*/    {"thirsty",  "tired"},
    /*15*/    {"pale", "breathless","breath","bleed","bled","bleeding"},
    /*16*/    {"confused", "confusion", "disoriented","lost", "speech", "language","hallucination"},
    /*17*/    {"breath", "wheezing","cough","coughed","coughing",  "drowsy", "exhausted", "dizzy", "heartbeat","tight chest","breathing faster","exhausted"}
    };


    void pr(int index);
    void score();
    void printSimptoms();
    int getIllness();
    void restartSimptoms();
    char** getPotentialSimptoms(char *full[], char *found[], int *k);
    void get2Max(int arr[], int arr_size, int* m1, int* m2);
    char** getPotentialIlness(char *simptom, int *k);
    const char** aloc();
    void addSymptom(char * simptom);
    void rm(char* word);


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
    %token<text> BODYPART
    %token<text> KEYWORD
    %token<text> ACTION
    %token<text> ADVERB
    %token<text> NOUN
    %token<text> LINK
    %token<text> BETTER 
    %token<text> WORSE
    %token<text> RUDE
    %token<text> YOU
    %token<text> WHY
    %token<text> DOIHAVE
    %type<text> program
    %type<text> line
    
    /* %type<text> any_words */

    %nonassoc LINK

    %{
        int yyerrstatus  = 0;
    %}

    %%


    program :  program line  { 
                
             
                if(questions<QUESTIONS){      
                    questions++;
                    /* printf("%d CONTOR INTREBARI",questions); */
                    
                    if(!err){          

                        char defaultMessage[100];
                        strcpy(defaultMessage,"There are many potential causes for this type of symptom, including ");
                        char ** causes = aloc();
                        int size_causes;
                        causes = getPotentialIlness($2,&size_causes);

                        for(int i=0;i<size_causes-1;i++){
                            strcat(defaultMessage,causes[i]);
                            strcat(defaultMessage,", ");
                        }

                        strcat(defaultMessage,causes[size_causes-1]);
                        strcat(defaultMessage,". "); 


                        /* printSimptoms();     */
                        int randomTypeQuestion = rand()%3;
                        /* printf("random :%d \n",randomTypeQuestion); */

                        int randomSorry = -1;
                        if(okMessage==1){        
                            okMessage=0;                
                            randomSorry = rand()%2;
                        }
                        
                        if(randomTypeQuestion == 0){
                            if(randomSorry==1){
                                printf("DR: I'm sorry to hear that you're experiencing %s.\n",remember);
                            }
                            else if(random==0){
                                printf("DR: %s",defaultMessage);
                            }
                            printf("DR: %s\n", defaultQuestions[rand()%7]);
                            printf("ME: ");
                        }
                        else{
                            int m1=-1,m2=-1;
                            int size_scores = sizeof(scores)/sizeof(scores[0]);
                            
                            /* printf("SCORES: \n");
                            for(int i=0;i<size_scores;i++){
                                printf("%d, ",scores[i]);
                            }
                            printf("MAXIME: \n"); */
                            get2Max(scores, size_scores, &m1, &m2);
                            /* printf("%d %d",m1,m2); */
                            int randomForMaxims = rand()%2;
                            if(randomForMaxims){

                                /* printf("%s",illnessSymptoms[m1][0]);
                                for(int i=1;illnessSymptoms[m1][i];i++){
                                    printf("%s ", illnessSymptoms[m1][i]);
                                } */
                                int size_pontentialSymptoms;                              
                                char **pontentialSymptoms = getPotentialSimptoms(illnessSymptoms[m1], simptoms,&size_pontentialSymptoms);

//                                printf("AICIII %d\n",size_pontentialSymptoms);

                                if(size_pontentialSymptoms>1){

                                int randomSymptoms = rand() % (size_pontentialSymptoms-1) + 1;
                            

                                /* for(int i=0;i<size_pontentialSymptoms;i++){
                                    printf("%s ", pontentialSymptoms[i]);
                                }  */

                                
                                if(randomSorry==1){
                                    printf("DR: I'm sorry to hear that you're experiencing  %s.\n",remember);
                                }
                                else if(random==0){
                                    printf("DR: %s",defaultMessage);
                                }

                               // printf("INDEX: %d\n",randomSymptoms);
                                printf("DR: %s Do you also have %s?\nME: ",defaultMessage,pontentialSymptoms[randomSymptoms]);
                                strcpy(remember,pontentialSymptoms[randomSymptoms]);


                                }  else {
                                    questions=QUESTIONS;
                                    printf("DR: %s","Let's recap. You said you have: ");
                                    printSimptoms();
                                    printf("\nAm I right?\nME: ");
                                }


                            } else{
                                /* printf("%s",illnessSymptoms[m2][0]);
                                for(int i=1;illnessSymptoms[m2][i];i++){
                                    printf("%s ", illnessSymptoms[m2][i]);
                                } */


                                int size_pontentialSymptoms;                              
                                char **pontentialSymptoms = getPotentialSimptoms(illnessSymptoms[m2], simptoms,&size_pontentialSymptoms);

                                /* printf("AICIII %d\n",size_pontentialSymptoms); */

                               if(size_pontentialSymptoms>1){

    
                                int randomSymptoms = rand() % (size_pontentialSymptoms-1) + 1;
                                
                               
                                /* for(int i=0;i<size_pontentialSymptoms;i++){
                                    printf("%s ", pontentialSymptoms[i]);
                                }  */
                               

                                if(randomSorry==1){
                                    printf("DR: I'm sorry to hear that you're experiencing %s.\n",remember);
                                    
                                }
                                else if(random==0){
                                    printf("DR: %s",defaultMessage);
                                }
                                //printf("INDEX: %d\n",randomSymptoms);
                                
                                printf("DR: %s Do you also have %s?\nME: ",defaultMessage,pontentialSymptoms[randomSymptoms]);
                                strcpy(remember,pontentialSymptoms[randomSymptoms]);


                               } else {
                                questions=QUESTIONS;
                                 printf("DR: %s","Let's recap. You said you have: ");
                                 printSimptoms();
                                 printf("\nAm I right?\nME: ");
                               }

                               


                            }
                            
                        }
                    }
                }
                else{
                    printf("DR: %s","Let's recap. You said you have: ");
                    printSimptoms();
                    printf("\nAm I right?\nME: ");
                }
                        
            }

            | {
                srand(time(0));
                printf("\n");
                // printf("\t\t\t\t\t\t\t\t\t\t");
                printf("DR: %s\n","Hello, I'm Dr. Rufus!");
                // printf("\t\t\t\t\t\t\t\t\t\t");
                printf("DR: %s\n\n",firstQuestions[rand()%5]);
                printf("ME: ");
                
            }
            
            ;


    line	: I POSVB KEYWORD '\n' { 
                
                err=0;
                addSymptom($3);
                score($3);

                strcpy($$,$3);
                strcpy(remember,$3);
                okMessage = 1;
                
            }

            | RUDE '\n'{
                printf("DR: Let's not be rude. \n");
            }

            | BETTER '\n'{ printf("DR: That's good! \n");
               
            }
            
            | WORSE '\n'{
               printf("DR: Let's try to fix that! \n");
            }

            | I POSVB NOUN '\n' {  

                err=0;
                addSymptom($3);
                score($3);

                strcpy($$ , $3);
                strcpy(remember,$3);
                okMessage=1;
                
            } 
            
            | I POSVB NOUN ACTION '\n' {  

                err=0;
                addSymptom($3);
                addSymptom($4);
                score($3);
                score($4);
                
                strcpy($$,$3);
                strcpy(remember,$3);
                okMessage=1;
                
                
            } 

            | I POSVB NOUN NOUN '\n' {  

                err=0;
                addSymptom($3);
                addSymptom($4);
                score($3);
                score($4);

                strcpy($$ , $4);
                strcpy(remember,$4);
                okMessage=1;
                
                
            } 

            
            | I POSVB BODYPART NOUN '\n' {  

                err=0;
                addSymptom($3);
                addSymptom($4);
                score($3);
                score($4);

                strcpy($$,$4);
                strcpy(remember,$4); 
                okMessage=1;
                
            } 


            | I POSVB NOUN LINK BODYPART '\n'  {

                err=0;
                addSymptom($3);
                score($3);
                
                strcpy($$,$3);
                strcpy(remember,$3);
                okMessage=1;
            }

            | I POSVB ACTION '\n'   {

                err=0;
                addSymptom($3);
                score($3);

                strcpy($$ , $3);
                strcpy(remember,$3);
                okMessage=1;
            }
                                        
            | I POSVB ACTION ACTION '\n'  {
                err=0;

                strcpy($$,$3);
                strcpy(remember,$3);
                okMessage=1;

            }
            
            | I ACTION '\n' {

                err=0;
                addSymptom($2);
                score($2);

                strcpy($$,$2);
                strcpy(remember,$2);
                okMessage=1;
            }
            
            | I POSVB ACTION KEYWORD '\n'  {

                err=0;
                addSymptom($4);
                score($4);

                strcpy($$,$4);
                strcpy(remember,$4);
                okMessage=1;
            } 
            
            | I POSVB ADVERB '\n'  {
                err = 0;

                if(strcmp($2,"feel")==0){
                    err=1;
                    char message[50];
                    strcpy(message,"What makes you feel ");
                    strcat(message,$3);
                    strcat(message,"? Does something hurt?");

                    printf("DR: %s\n",message);
                    printf("ME: ");
                }

                if(strcmp($2,"am")==0){
                    err=1;
                    char message[50];
                    strcpy(message,"Why are you ");
                    strcat(message,$3);
                    strcat(message,"? Does something hurt?");

                    printf("DR: %s\n",message);
                    printf("ME: ");
                }

                addSymptom($3);
                score($3);
            } 
            
            | I POSVB  ADVERB  BODYPART '\n'  {

                err=0;
                addSymptom($4);
                addSymptom($3);;
                score($3);
                score($4);
            }

            | MY BODYPART POSVB ACTION '\n'  {

                err=0;
                addSymptom($2);
                addSymptom($4);
                score($2);
                score($4);

                strcpy($$,$4);
                strcpy(remember,$4);
                okMessage=1;
            } 

            | MY BODYPART ACTION '\n'  {

                err=0;
                addSymptom($2);
                addSymptom($3);
                score($2);
                score($3);
                
                strcpy($$,$3);
                strcpy(remember,$3);
                okMessage=1;
            } 

            | MY BODYPART ADVERB '\n'  {

                err=0;
                addSymptom($2);
                addSymptom($3);
                score($2);
                score($3);
            }

            | BODYPART '\n' {
                addSymptom($1);
                score($1);
            }

            | MY BODYPART '\n' {
                addSymptom($2);
                score($1);
            }


            | YES '\n'{
                if(questions<QUESTIONS){
                    okMessage=1;
                    addSymptom(remember);
                   
                }
                else if(questions>QUESTIONS){
                    printf("DR: You might have %s.\n",illnessSymptoms[getIllness()][0] );
                    exit(0);   
                } 
                else if(questions == QUESTIONS){
                    addSymptom(remember);
                    questions++;
                }
            }

            | NO '\n'{
                if(!(questions<QUESTIONS)){
                    err=0;
                    printf("DR: I am sorry. Let's start over.\n");
                    restartSimptoms();
                    questions=0;
                } else {
                    rm(remember);
                }
            }

            | DOIHAVE '\n' {
                printf("DR: I can not tell for sure. Let's see more symptoms.");
            }

            | WHY '\n' {
                printf("DR: I cannot answer that.");
            }

            | WHY BODYPART '\n'{
                addSymptom($2);
            }

            | WHY KEYWORD '\n'{
                addSymptom($2);
            }

            | YOU '\n' {
                printf("DR:We were discussing you, not me. \n");
            }

            | error '\n' {
                yyclearin;
                printf("DR: I am not sure I understand you fully. Can you repeat?\n");
                printf("ME: ");
                err=1;
                yyclearin;
               
            }

            ;



                                        


    %%                     /* C code */

    int main(){
        simptoms = aloc();
        yyparse();
    }

    void addSymptom(char *s) {
        int exists=0;
        for(int i=0;i<ind;i++){
            if(strcmp(simptoms[i],s)==0){
                exists = 1;
                break;
            }
        }
        if(exists==0){
            strcpy(simptoms[ind++], s);
        }
        
    }

    /* void pr(int index){
        printf("Illness: %s\n", illness[index][0]);
        int x = 1;
        while(illness[index][x]){
            printf("%s ", illness[index][x]);
            x++;
        }
    } */

    void score(char* simptom){
        int i=0, j=0;
        while(i<17){
            j=0;
            while (illnessSymptoms[i][j]!=0)
            {
                if(strcmp(illnessSymptoms[i][j],simptom)==0)
                    scores[i]++;
                j++;
            }
            i++;
        }

        i=0;

        while(i<17){
            j=0;
            while (illnessAux[i][j]!=0)
            {
                if(strcmp(illnessAux[i][j],simptom)==0)
                    scores[i]++;
                j++;
            }
            i++;
        }
    }

    void printSimptoms(){
        for(int i=0;i<ind;i++){
            printf("%s, ",simptoms[i]);
        }
    }

    int getIllness(){
        int max = 0, maxi = 0;
        for(int i=0;i<17;i++){
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

        for(int i=0;i<17;i++){
            scores[i]=0;
        }
    }

    char** getPotentialSimptoms(char *full[], char *found[], int *k){
        size_t i = 1,j = 0;
        *k = 0;
        int s3;

        char e[50];
        int ok = 0;

        char** rez = (char**) malloc(50 * sizeof(char*));
        for (i = 0; i < 50; i++) { 
            rez[i] = (char*) malloc(50 * sizeof(char)); 
        }
        i=0;

        while(full[i]!=0) 
        {
            j=0;
            strcpy(e, full[i]); 
            ok = 0;

            while(found[j] != 0) {
                
            if(strcmp(e, found[j])==0)
            {
                ok = 1;
                break;
            }
            j++;
            }

            if(ok == 0){
                strcpy(rez[*k], e);
                (*k)++;
            }
            i++;
        }

        return rez;

    }

    void get2Max(int arr[], int arr_size, int* m1, int* m2)
    {
        int max1 = 0;
        int max2 = 0;

        *m1=0;
        *m2=0;

        for(int i=0; i<arr_size; i++)
        {
            if(arr[i] >= max1)
            {
                max2 = max1;
                *m2 = *m1;
                max1 = arr[i];
                *m1 = i;
            }
            else if(arr[i] >= max2 && arr[i] < max1)
            {
                max2 = arr[i];
                *m2 = i;
            }
        }
    }


    void yyerror( char *msg) {
        if(yyerrstatus==1)
            {
                printf("Custom error message: %s\n", msg);
                yyerrstatus=0;
                
            }


    }

    const char** aloc(){
        char** rez = (char**) malloc(50 * sizeof(char*));
        for (int i = 0; i < 50; i++) { 
            rez[i] = (char*) malloc(50 * sizeof(char)); 
        }
        return rez;
    }

    char** getPotentialIlness(char *simptom, int *k){
        size_t i = 0,j = 0;
        int s3;
        *k=0;

        char** rez = (char**) malloc(50 * sizeof(char*));
        for (i = 0; i < 50; i++) { 
            rez[i] = (char*) malloc(100 * sizeof(char)); 
        }
        int ok = 0;
        *k = 0;
        i=0;

        while(i<17) 
        {
            j=0;
            while(illnessSymptoms[i][j] != 0) {
                
                if(strcmp(illnessSymptoms[i][j], simptom)==0)
                {
                    strcpy(rez[(*k)++], illnessSymptoms[i][0]);
                    break;
                }
                j++;
            }

            j=0;
            while(illnessAux[i][j] != 0) {
                
                if(strcmp(illnessAux[i][j], simptom)==0)
                {
                    
                    strcpy(rez[(*k)++], illnessSymptoms[i][0]);
                    break;
                }
                j++;
            }

            i++;
        }

        return rez;
    }

    void rm(char* word){
        int pos;
        int j;
        for (int i=0; i<17; i++){
            pos = -1;
            for(j=1; illnessSymptoms[i][j]; j++)
            {
                if (strcmp(illnessSymptoms[i][j], word)==0){
                    printf("%d ", i);
                    pos = j;
                    break;
                }
            }
            if (pos!=-1)
                for(j=pos; illnessSymptoms[i][j]; j++)
                {
                    illnessSymptoms[i][j] = illnessSymptoms[i][j + 1];
                }
            // illness[i][j] = 0;
        }
    }