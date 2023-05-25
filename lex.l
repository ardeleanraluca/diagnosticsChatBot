%{
#include "y.tab.h"
%}
%%


I                                       {yylval.text = strdup(yytext); return I;}
MY                                      {yylval.text = strdup(yytext); return MY;}

HAVE |
IS |
"HAS A" |
"HAS BEEN" |
"HAS AN" |
"HAS BEEN HAVING" |
FEEL |
AM |
"HAVE A" |
"HAVE AN" |
"HAVE BEEN"                               {yylval.text = strdup(yytext); return POSVB;}


head | 
leg | 
legs | 
arm | 
arms | 
tooth | 
teeth | 
foot | 
feet | 
ankle | 
back | 
wrist |
stomach | 
belly |
heart | 
abdomen | 
ears | 
throat |
pelvis | 
"pelvic area" |
nose |
eye |
eyes                                  {yylval.text = strdup(yytext); return BODYPART;}

hurt | 
hurts | 
hurting |
sting |
stings | 
stinging |
burn |
burns |
burning |
feels |
feeling |
suffer |
suffers | 
suffering |
perceive |
perceived | 
perceiving |
sense |
sensed | 
sensing |
detect | 
detected | 
detecting |
notice | 
noticed | 
noticing |
observe | 
observed | 
observing |
identify | 
identified |
identifying |
experience | 
experienced |
experiencing |
endure | 
endured |
enduring |
sneeze |
sneezed |
sneezing |
breath |
breathing |
swell | 
swelling |
remember |
remembering |
forget | 
forgot | 
forgetting |
bleed |
bleeding |
bled |
wheezing |
wheeze |
shivering |
shivered |
shivere          {yylval.text = strdup(yytext); return ACTION;}




headache |
disorientation |
confusion |
inflammation |
stomachache | 
bellyache |
heartache |
backache |
soreness |
"sore shoulder" |
"red rash" |
"red dots" |
"sore throat" |
"personality changes" |
"low mood" |
"shortness of breath" |
"tight chest" |
anxiety |
hallucinations |
sinus |
earache |
pressure |
"stuffed up nose" |
 "black tooth" |
"stuffy nose" |
"passing urine" |
"weight loss" |
"persistent infections" |
"repeated infections" |
"infections" |
"pale skin" |
temperature |
fever                {yylval.text = strdup(yytext); return KEYWORD;}



good |
drowsy |
exhausted |
confused |
bad |
tiredness |
sick | 
fine |
breathless |
thirsty |
thirst |
dizzy |
nauseous |
Uncomfortable | 
tired                {yylval.text = strdup(yytext); return ADVERB;}




discomfort | 
breathlessness |
pain | 
difficulty | 
difficult | 
problem | 
trouble             {yylval.text = strdup(yytext); return NOUN;}


"in the" |
"in my" |
"in"     |
"with"               {yylval.text = strdup(yytext); return LINK;}  

yes                  {return YES;}
no                   {return NO;}


[\r\n]                          { return *yytext; }

[a-z]+                          ;

.                               ;   

                     

%%


