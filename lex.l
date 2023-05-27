%{
#include "y.tab.h"
%}
%%

YOU |
"YOU'RE" |
"YOU'VE"                                {yylval.text = strdup(yytext); return YOU;}
WHY |
WHAT                                    {yylval.text = strdup(yytext); return WHY;}
"Do I have"                             {yylval.text = strdup(yytext); return DOIHAVE;}
I                                       {yylval.text = strdup(yytext); return I;}
MY                                      {yylval.text = strdup(yytext); return MY;}
WORSE                                   {yylval.text = strdup(yytext); return WORSE;}
BETTER                                  {yylval.text = strdup(yytext); return BETTER;}

HAVE |
IS |
CANNOT |
"A" |
"DON'T" |
"CAN'T" |
"AM NOT ABLE TO" |
"HAS A" |
"HAS BEEN" |
"HAS AN" |
"KEEP" |
"HAS BEEN HAVING" |
FEEL |
AM |
"HAVE A" |
"HAVE AN" |
"HAVE BEEN"                               {yylval.text = strdup(yytext); return POSVB;}


head | 
leg | 
bones |
bone |
legs | 
arm | 
arms |
knee |
knees | 
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
heartbeat |
nose |
eyelid |
eyelids |
eye |
eyes                                  {yylval.text = strdup(yytext); return BODYPART;}

hurt | 
hurts | 
hurting |
break |
broke |
breaking |

cough |
coughed |
coughing |
loose |
lost |
loosing |
tear |
tearing |
teared |
fractured |
fracturing |
hit |
twist |
twisted |
twisting |
walk |
walked |
walking |
talk |
talked |
talking |
hear |
heard |
hearing |
see |
saw |
seeing |
sleep |
slept |
sleeping |
eat |
eatting |
ate |
sting |
stings | 
stinging |
burn |
burns |
burning |
vomiting |
vomite |
vomited |
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
bloate |
bloated |
bloating |
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
"dont't remember" |
"can't remember" | 
shivering |
shivered |
shivere          {yylval.text = strdup(yytext); return ACTION;}




headache |
dizziness |
drowsiness |
disorientation |
confusion |
inflammation |
stomachache | 
bellyache |
heartache |
backache |
soreness |
bruise |
anxiety |
hallucinations |
hallucination |
sinus |
earache |
pressure |
temperature |
fever |
infections |
"dark area" |
"painful area" |
"sore shoulder" |
"red rash" |
"red dots" |
"sore throat" |
"personality changes" |
"low mood" |
"loss of appetite" |
"shortness of breath" |
"tight chest" |
"red eyes" |
"red eye" |
"redness" |
"abdominal pain" |
"abdominal cramps" |
"loss of balance" |
"itchy eyes" |
"watery eyes" |
"teary eyes" |
"stuffed up nose" |
"black tooth" |
"stuffy nose" |
"passing urine" |
"weight loss" |
"persistent infections" |
"repeated infections" |
"problem remembering" |
"forgetting moments" |
"hearing difficulties" |
"pale skin"                    {yylval.text = strdup(yytext); return KEYWORD;}



good |
well |
drowsy |
exhausted |
inflammated |
painful |
confused |
bad |
broken |
fracture |
tiredness |
sick | 
fine |
breathless |
thirsty |
dizzy |
nauseous |
pale |
awful |
disoriented |
terrible |
miserable |
Uncomfortable | 
tired                {yylval.text = strdup(yytext); return ADVERB;}




discomfort | 
exhaustion |
breathlessness |
speech |
thirst |
language |
nausea |
diarrhoea |
amnesia |
pain | 
cramps |
cramp |
loss |
appetite |
difficulty | 
difficulties |
difficult | 
problem | 
problems | 
trouble             {yylval.text = strdup(yytext); return NOUN;}


"in the" |
"in my" |
"in"     |
"with"               {yylval.text = strdup(yytext); return LINK;}  

yes                  {return YES;}
no                   {return NO;}

stupid |
fuck |
dick |
dumb |
idiot |
imbecil |
bitch |
whore               {return RUDE;}


[\r\n]                          { return *yytext; }

[a-z0-9]+                          ;

.                                   ;   

                     

%%




