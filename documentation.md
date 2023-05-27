## Dr. Rufus Medical Diagnosis ChatBot

Dr. Rufus is a **medical diagnosis tool** implemented using Lex and Yacc. Based on different types of discomforts specified by the client, Dr. Rufus will try to give a diagnosis as close to reality as possible.
### Conversation flow:
- Dr. Rufus will start by asking you different questions about the client's health.
- After asking 5 questions and receiving the additional answers, a review of the specified symptoms will show. 
- Afterwards, if the client wants the diagnosis displayed, it should type "Yes.", otherwise it should type "No.".
- In case the client typed "Yes", the most accurate disease will be displayed.
- Otherwise, the conversation will reset, allowing the client to chat once more, from the beginning.

#### Interaction with Dr. Rufus:
- the chatbot analyzes the inputted text and matches the text with predefined data called intents
which are categorized to manage the conversation
- we established **patterns** for different types of inputs so that we can manipulate different sympoms or keywords that we may encounter.
- in case the compiler doesn't recognize anything (so no relevant information is provided), the message ***"I am not sure I understand you fully. Can you repeat?"*** will be displayed, allowing the conversation to continue.
- in case the chatbot encounters any inputs that contain questions or sentances about itself it will give the next answer ***"We were discussing you, not me."***
- if the client asks too early what desease it might have, the chatbot won't have the anwer to that question, so it will display the following output ***"I can not tell for sure. Let's see more symptoms."***   
- if the client asks ant other irrelevant question, as the chatbot is not developed to answer to questions, it will display the following message ***"I cannot answer that."***
- If Dr. Rufus encounters any rude behaviour, he will discourage it (**"Let's not be rude."**).
- Also, if Dr. Rufus encounters vague answers, not a specific affection, he will persuade the client to give more specific information (e.g. ***"What makes you feel [ADVERB]. Does something hurt?"***).

#### Keywords 
In the **lex** part of the project we chose relevant **tokens** from the *medical area* such as:
1. **ACTIONS** - sneeze, cough, sleep, suffer etc.
2. **BODYPARTS** - back, neck, arm etc.
3. **NOUNS** - difficulty, pain, problem
4. **ADVERBS** - sick, well, dizzy, 
5. **Composite structures** - loss of appetite, sore throat, shortness of breath etc.


#### Dr. Rufus's answer choosing

I. Dr. Rufus has suite of **default questions**, regarding the client's well being

II. Dr. Rufus has suite of **custom questions**, based on the previous client's answers:
    - we calculate the first two diseases whose symptoms were found most often in the answers given by the client  
    - we choose random between those two and then we choose random between its other symptoms, one that hasn't occured yet, and it is specific for the desease, to guide the conversation towards one of the two diseases (e.g. **"Do you also have [SYMPTOM]?"**).
    - in case the client has an **affirmative** answer, the symptom will be taken into consideration
    - otherwise, it will be **removed** from the potential symptoms, the deases in which is included, being less likely to be the chosen.

III. Based on a given symptom, Dr. Rufus will say in which deseases the symptoms are most often encountered.
IV. Sometimes, Dr. Rufus will show his regrets regarding the client's pain, by appending the symptom to a default answer (e.g. **"I'm sorry to hear that you have [SYMPTOM]."**).


Between those types of questions, Dr. Rufus will choose randomly.

#### Desease choosing

- we have a large dataset composed of most common illnesses and their most significant symptoms
- every time a symtom is encountered, a score will be calculated, based on how many of the provided symptoms are encountered in a specific desease
- the final desease output is represented by the illness with the biggest score (the disease with the most symptoms found in the answers given by the interlocutor).


 