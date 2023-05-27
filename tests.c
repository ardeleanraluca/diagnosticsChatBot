#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>     /* C exit function */
#include <string.h>
#include <time.h>

char *illness[17][100] = {
        {"cold", "sore throat", "sneeze","sneezed","sneezing", "coughing","cough","coughed", "fever", "headache", "shivering","shivered","shivere", "pain" , "throat"},
        {"measles", "fever", "red rash","red dots", "itchy", "childhood"},
        {"rash", "red spots", "itchy", "uncomfortable"},
        {"sprain" "pain",  "ankle", "twist"},
        {"sunburn", "inflammation", "red skin", "sun"},
        {"allergies", "red eyes", "watery eyes","watery","eyes", "itchy eyes", "itchy","eyes", "nose", "coughing","cough","coughed", "sneeze","sneezed","sneezing"},
        {"broken bones", "fractured","fracture","fracturing", "broken","break","breaking","broke", "fall","bones"},
        {"bruise", "dark area", "painful area", "skin", "hit","pain"},
        {"amnesia", "problem", "remembering", "remember","remembered","forget","forgot", "forgetting"},
        {"gastroenteritis", "loss of appetite","loss","lost", "appetite", "bloating","bloated","nausea","nauseous","vomiting","vomite","vomited","abdominal cramps","abdominal pain","diarrhoea"},
        {"tooth decay", "toothache", "jaw pain","jaw", "pain", "earache", "black tooth","black", "tooth"},
        {"otitis","ear","pain","loss of balance","hearing" ,"difficulties"},
        {"Conjunctivitis", "redness","itching","itchy","tearing","teared","tear","burning","burned","burn", "red eyes", "eyelids","red","eye","eyes","inflammation","inflammated"},
        {"diabetes", "thirsty", "passing urine", "tired", "weight loss", "persistent infections","infections"},
        {"leukaemia", "pale skin","pale", "tiredness", "breathlessness","breathless","breath","bleeding","bleed","bled", "repeated infections","infections"},
        {"alzheimer", "confused", "confusion", "disoriented","disorientation", "lost", "speech", "language", "personality changes", "hallucinations","hallucination", "low mood", "anxiety"},
        {"asthma", "wheezing", "shortness of breath","breath", "tight chest","coughing","cough","coughed", "breathing faster", "drowsy", "exhausted", "dizzy", "rapid heartbeat","heartbeat"}
    };

char simptoms[50][50];

int scores[17]={0};

void getPotentialSimptoms(char *full[], char found[][50], char rez[][50]){
    size_t i = 0,j = 0,k;
    int s3;

    char e[20];
    int ok = 0;
    k = 0;
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
            strcpy(rez[k], e);
            k++;
        }
        i++;
    }


}

void get2Max(int arr[], int arr_size, int* m1, int* m2)
{
    int max1 = 0;
    int max2 = 0;

    *m1=0;
    *m2=0;

    for(int i=0; i<arr_size; i++)
    {
        if(arr[i] > max1)
        {
            max2 = max1;
            *m2 = *m1;
            max1 = arr[i];
            *m1 = i;
        }
        else if(arr[i] > max2 && arr[i] < max1)
        {
            max2 = arr[i];
            *m2 = i;
        }
    }
}


char** getPotentialIlness(char *simptom){
    size_t i = 0,j = 0,k=0;
    int s3;

    char** rez = (char**) malloc(50 * sizeof(char*));
    for (i = 0; i < 50; i++) { 
        rez[i] = (char*) malloc(50 * sizeof(char)); 
    }
    int ok = 0;
    k = 0;
    i=0;

    while(i<17) 
    {
        j=0;
        while(illness[i][j] != 0) {
            
           if(strcmp(illness[i][j], simptom)==0)
           {
               strcpy(rez[k++], illness[i][0]);
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
        for(j=1; illness[i][j]; j++)
        {
            if (strcmp(illness[i][j], word)==0){
                printf("%d ", i);
                pos = j;
                break;
            }
        }
        if (pos!=-1)
            for(j=pos; illness[i][j]; j++)
            {
                illness[i][j] = illness[i][j + 1];
            }
        // illness[i][j] = 0;
    }
}

// void copyData(){
//     int i,j;
//     for(i=0;17;i++)
//         for(j=0;illness[i][j];j++)
//             strcpy(new[i][j], illness[i][j]);
// }


int main(){

    strcpy(simptoms[0], "pain");
    strcpy(simptoms[1], "dede");
    strcpy(simptoms[2], "ceceve");

    char *l1[] = {"ana", "are", "multe", "mere"};
    char *l2[] = {"ana", "mere"};

    size_t s1 = sizeof(l1)/sizeof(l1[0]);
    size_t s2 = sizeof(l2)/sizeof(l2[0]);

    // char l3[50][50];
    // getPotentialSimptoms(illness[0],simptoms,l3);
    // for (int i = 0; i < 10; i++) {
    //     printf("%s ",l3[i]);
    // }

    // int nr[] = {0,10,20,4,5,6};

    // size_t s = sizeof(nr)/sizeof(int);

    // int max1, max2;

    // get2Max(nr, s, &max1, &max2);

    // printf("max1: %d, max2: %d\n",max1,max2);
    // score("pain");

    // for(int i = 0; i<17;i++){
    //     printf("%d ", scores[i]);
    // }

    for (size_t i = 0; i < 17; i++)
    {
        for (size_t j = 0;illness[i][j]; j++)
        {
            if (strcmp(illness[i][j],"pain")==0)
                printf("\033[0;31m%s ", illness[i][j]);
            else
                printf("\033[0;33m%s ", illness[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    printf("\n");
    rm("pain");
    printf("\n");
    printf("\n");

    for (size_t i = 0; i < 17; i++)
    {
        for (size_t j = 0;illness[i][j] ; j++)
        {
            if (strcmp(illness[i][j],"pain")==0)
                printf("\033[0;31m%s ", illness[i][j]);
            else
                printf("\033[0;33m%s ", illness[i][j]);
        }
        printf("\n");
    }

    return 0;
}

