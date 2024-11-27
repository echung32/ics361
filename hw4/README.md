For this assignment, I'd like you to grapple with the the DCG (Definite Clause Grammar) notation in Prolog. You should have most of what you need in the ass5_start.pl file attached to this assignment. PROVIDE DESCRIPTIVE IN-CODE COMMENTS FOR EVERYTHING YOU DO.

Your transcript should show that your code works on each type of query and relationship - not on every single possible relationship in the family tree! 

If there are multiple answers, they should be generated, e.g. "who is the child of Homer?" should, on backtracking, generate all of his children.

It's OK if there are several "yes/true" responses on backtracking. However, there shouldn't be any falling off the DFS cliff.

I have provided the Simpsons and Modern Family family trees to use for this assignment - use either one. If you would prefer to use another family, you are very welcome, but please provide a graphic of the tree when you submit!

## A. (40 points)

Expand the facts to include spouse relationships. Fill out the facts for the family tree. 

Expand the definitions to include these relationships: sibling, brother, sister, son, daughter, child, mother, aunt, uncle, niece, nephew, nibling (either niece or nephew), grandparent, grandmother, grandfather, grandchild, granddaughter, grandson, husband, wife, cousin. Make sure that relationships like sibling work both ways if appropriate (i.e. if Bart is the sibling of Lisa, then Lisa is the sibling of Bart). 

Provide a script or screenshot showing that query/2 works for all of these relationships, for both types of sentences in the sample file. 

## B. (20 points each)

Note that each of these is worth 20 points, so it is possible to exceed 100% for this assignment. For each one you attempt, include well-commented code and a transcript showing the desired behavior.

1. Define ancestor and descendant relationships, and show that query/2 works with these.

2. Adapt the DCG to handle queries like "Is it true that Homer is the father of Lisa and Patty is the sister of Selma and..." It should be able to handle questions like this of any length. If you do #4, it should also handle queries like "Is it true that Homer is a father and Patty is a sister and Marge is the mother of Lisa..." etc. 

3. Adapt the DCG (do not add new facts or definitions) so that it can handle other terms for relationships (e.g. "dad" or "papa" for "father"). Add whatever terms you like to use for family.

4. Adapt the DCG to handle queries like "Is it true that Homer is a father?" and "Is it true that Lisa has a cousin?". This should work for all the defined relationships, and not produce any incorrect answers.

5. Adapt the DCG to handle queries like "Is it true that Homer and Marge are parents?" and "Is it true that Bart and Lisa and Maggie have parents?" These sentences should allow an unlimited number of people to be asked about. Agreement (i.e. between the subject and the verb) should be enforced using features, so that questions like "Is it true that Homer and Marge is a parent" and "Is it true that Bart have parents" do not parse. For this question, note that "Is it true that X and Y are siblings" should succeed if X is a sibling and Y is a sibling, even if X and Y are not siblings with each other. In normal use, this is an example of how natural language is ambiguous!