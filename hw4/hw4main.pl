/* TOP LEVEL: QUERY/2

1st argument: a list of words that should make up a question
2nd argument: the answer to that question

Should fail if the question is ungrammatical or outside the range of the assignment (e.g. grammatical English, but not about families). For yes/no questions, it should succeed if the answer is "yes", fail if "no". 

Examples:

?- query([is,it,true,that,homer,is,the,father,of,lisa],_).
true .

?- query([who,is,the,father,of,lisa],Ans).
Ans = homer.

*/

query(Question, _) :-
  yesnoquestion(Question, []).

query(Question, Answer) :-
  whoisquestion(Answer, Question, []).

/* THE GRAMMAR

This is a DCG (Definite Clause Grammar). 

Q =.. [sister, maggie, bart]
Q = sister(maggie, bart)

Q =.. [sister, maggie, _]
Q = sister(maggie, _)

Q =.. [sister, _, bart]
Q = sister(_, bart)

*/

% This calls on evaluate_predicates to evaluate each individual result in the list.
yesnoquestion --> [is,it,true,that], compound_sentence(Q), { evaluate_predicates(Q) }.
whoisquestion(Answer) --> [who, is, the], relation(X, num=sing), [of], person(Y), {=..(Q, [X,Answer,Y]), Q}.

% This defines the base case to parse a singular person.
people([X], num=sing) --> person(X).
% This defines the case to parse multiple people.
% The recursive definition is set to num=_, since it can either be sing or plur.
people([HX|RX], num=plur) --> person(HX), [and], people(RX, num=_).

% This defines the base case, where Q is a single sentence.
compound_sentence(Q) --> sentence(Q), { evaluate_predicates(Q) }.
% This handles sentences of two parts, the question and more compound sentences.
% sentence([Q1]) is wrapped in [] so that it is handled as an element of a list, 
%   otherwise it results in creating a nested list of elements which causes an error.
compound_sentence(Q) --> sentence(Q), [and], compound_sentence(Q2), { evaluate_predicates(Q), evaluate_predicates(Q2)}.

% This handles only singular relations.
sentence(Q) --> people(X, num=sing), [is,the], relation(Y, num=sing), [of], people(Z, num=sing), { is_the(Y, X, Z, Q), evaluate_predicates(Q) }.
sentence(Q) --> people(X, num=sing), [is,a], relation(Y, num=sing), { is_a(Y, X, Q), evaluate_predicates(Q) }.
sentence(Q) --> people(X, num=sing), [has,a], relation(Y, num=sing), { has_a(Y, X, Q), evaluate_predicates(Q) }.

% This handles only plural relations.
sentence(Q) --> people(X, num=plur), [are], relation(Y, num=plur), { is_a(Y, X, Q), evaluate_predicates(Q) }.
sentence(Q) --> people(X, num=plur), [have], relation(Y, num=plur), { has_a(Y, X, Q), evaluate_predicates(Q) }.

is_a(_, [], []).
% Rel, PersonList, QueryList
% Interpretation: HeadP is a Rel.
is_a(Rel, [HeadP|RestP], [HeadQ|RestQ]) :-
  HeadQ =.. [Rel, HeadP, _],
  is_a(Rel, RestP, RestQ).

has_a(_, [], []).
% Rel, PersonList, QueryList
% Interpretation: HeadP has a Rel.
has_a(Rel, [HeadP|RestP], [HeadQ|RestQ]) :-
  HeadQ =.. [Rel, _, HeadP],
  has_a(Rel, RestP, RestQ).

is_the(_, [], [], []).
% Rel, PersonList1, PersonList2, QueryList
% Interpretation: HeadP1 has a Rel to HeadP2.
is_the(Rel, [HeadP1|RestP1], [HeadP2|RestP2], [HeadQ|RestQ]) :-
  HeadQ =.. [Rel, HeadP1, HeadP2],
  is_the(Rel, RestP1, RestP2, RestQ).

% Used to evaluate the predicate list from is_a/3, has_a/3.
evaluate_predicates([]).
evaluate_predicates([H|Rest]) :-
  H, evaluate_predicates(Rest).

person(abe) --> [abe].
person(mona) --> [mona].
person(clancy) --> [clancy].
person(jacqueline) --> [jacqueline].
person(herb) --> [herb].
person(homer) --> [homer].
person(marge) --> [marge].
person(patty) --> [patty].
person(selma) --> [selma].
person(bart) --> [bart].
person(lisa) --> [lisa].
person(maggie) --> [maggie].
person(ling) --> [ling].

relation(parent, num=sing) --> [parent].
relation(parent, num=plur) --> [parents].
relation(father, num=sing) --> [father].
relation(father, num=plur) --> [fathers].
relation(father, num=sing) --> [dad]. % Father
relation(father, num=plur) --> [dads]. % Father
relation(father, num=sing) --> [papa]. % Father
relation(father, num=plur) --> [papas]. % Father
relation(mother, num=sing) --> [mother].
relation(mother, num=plur) --> [mothers].
relation(mother, num=sing) --> [mom]. % Mother
relation(mother, num=plur) --> [moms]. % Mother
relation(mother, num=sing) --> [mama]. % Mother
relation(mother, num=plur) --> [mamas]. % Mother
relation(sister, num=sing) --> [sister].
relation(sister, num=plur) --> [sisters].
relation(sister, num=sing) --> [sis]. % Sister
relation(sister, num=plur) --> [sisses]. % Sister
relation(brother, num=sing) --> [brother].
relation(brother, num=plur) --> [brothers].
relation(brother, num=sing) --> [bro]. % Brother
relation(brother, num=plur) --> [bros]. % Brother
relation(sibling, num=sing) --> [sibling].
relation(sibling, num=plur) --> [siblings].
relation(son, num=sing) --> [son].
relation(son, num=plur) --> [sons].
relation(daughter, num=sing) --> [daughter].
relation(daughter, num=plur) --> [daughters].
relation(child, num=sing) --> [child].
relation(child, num=plur) --> [children].
relation(aunt, num=sing) --> [aunt].
relation(aunt, num=plur) --> [aunts].
relation(aunt, num=sing) --> [aunty]. % Aunt
relation(aunt, num=plur) --> [aunties]. % Aunt
relation(uncle, num=sing) --> [uncle].
relation(uncle, num=plur) --> [uncles].
relation(niece, num=sing) --> [niece].
relation(niece, num=plur) --> [nieces].
relation(nephew, num=sing) --> [nephew].
relation(nephew, num=plur) --> [nephews].
relation(nibling, num=sing) --> [nibling].
relation(nibling, num=plur) --> [niblings].
relation(grandparent, num=sing) --> [grandparent].
relation(grandparent, num=plur) --> [grandparents].
relation(grandfather, num=sing) --> [grandfather].
relation(grandfather, num=plur) --> [grandfathers].
relation(grandfather, num=sing) --> [grandpa]. % Grandfather
relation(grandfather, num=plur) --> [grandpas]. % Grandfather
relation(grandmother, num=sing) --> [grandmother].
relation(grandmother, num=plur) --> [grandmothers].
relation(grandmother, num=sing) --> [grandma]. % Grandmother
relation(grandmother, num=plur) --> [grandmas]. % Grandmother
relation(grandchild, num=sing) --> [grandchild].
relation(grandchild, num=plur) --> [grandchildren].
relation(granddaughter, num=sing) --> [granddaughter].
relation(granddaughter, num=plur) --> [granddaughters].
relation(grandson, num=sing) --> [grandson].
relation(grandson, num=plur) --> [grandsons].
relation(husband, num=sing) --> [husband].
relation(husband, num=plur) --> [husbands].
relation(husband, num=sing) --> [hubby]. % Husband
relation(husband, num=plur) --> [hubbies]. % Husband
relation(wife, num=sing) --> [wife].
relation(wife, num=plur) --> [wives].
relation(wife, num=sing) --> [wifey]. % Wife
relation(wife, num=plur) --> [wifies]. % Wife
relation(cousin, num=sing) --> [cousin].
relation(cousin, num=plur) --> [cousins].
relation(cousin, num=sing) --> [cuz]. % Cousin
relation(cousin, num=plur) --> [cuzs]. % Cousin
relation(ancestor, num=sing) --> [ancestor].
relation(ancestor, num=plur) --> [ancestors].
relation(descendant, num=sing) --> [descendant].
relation(descendant, num=plur) --> [descendants].

/* THE DEFINITIONS

For example: X is Y's father if X is the parent of Y and X is male.

*/

% A grandparent is the parent of the child's parent.
grandparent(Grand, X) :-
  parent(Grand, Parent),
  child(X, Parent).

% A male grandparent.
grandfather(Grand, X) :-
  grandparent(Grand, X),
  gender(Grand, male).

% A female grandparent.
grandmother(Grand, X) :-
  grandparent(Grand, X),
  gender(Grand, female).

% A father is the parent of a child.
father(Father, X) :-
  parent(Father, X),
  gender(Father, male).

% A mother is the parent of a child.
mother(Mother, X) :-
  parent(Mother, X),
  gender(Mother, female).

% A husband is male and has a spouse
husband(X, Y) :-
  spouse(X, Y),
  gender(X, male).

% A wife is female and has a spouse
wife(X, Y) :-
  spouse(X, Y),
  gender(X, female).

% A child is the child of a parent.
child(X, Parent) :-
  parent(Parent, X).

% A child that is male.
son(X, Parent) :-
  child(X, Parent),
  gender(X, male).

% A child that is female.
daughter(X, Parent) :-
  child(X, Parent),
  gender(X, female).

% A grandchild is the child of the grandparent's child.
grandchild(X, Grand) :-
  grandparent(Grand, X).

% A grandson is a male grandchild.
grandson(X, Grand) :-
  grandchild(X, Grand),
  gender(X, male).

% A granddaughter is a female grandchild.
granddaughter(X, Grand) :-
  grandchild(X, Grand),
  gender(X, female).

% Siblings share the same parent
sibling(X, Y) :-
  parent(Parent, X),
  parent(Parent, Y).

% A brother is a sibling that is male.
brother(X, Y) :-
  sibling(X, Y),
  gender(X, male).

% A sister is a sibling that is female.
sister(X, Y) :-
  sibling(X, Y),
  gender(X, female).

% Siblings have one parent that is the sibling of the other.
cousin(X, Y) :-
  parent(ParentA, X),
  parent(ParentB, Y),
  sibling(ParentA, ParentB).

% An aunt is a female sibling of either parent.
aunt(Aunt, X) :-
  parent(Parent, X),
  sibling(Parent, Aunt),
  gender(Aunt, female),
  \+ parent(Aunt, X).

% An aunt is also the wife of the siblings of either parent.
aunt(Aunt, X) :-
  parent(Parent, X),
  sibling(Parent, Spouse),
  spouse(Spouse, Aunt),
  gender(Aunt, female),
  \+ parent(Aunt, X).

% An uncle is a male sibling of either parent.
uncle(Uncle, X) :-
  parent(Parent, X),
  sibling(Parent, Uncle),
  gender(Uncle, male),
  \+ parent(Uncle, X).

% An uncle is also the husband of the siblings of either parent.
uncle(Uncle, X) :-
  parent(Parent, X),
  sibling(Parent, Spouse),
  spouse(Spouse, Uncle),
  gender(Uncle, male),
  \+ parent(Uncle, X).

% A niece is the daughter of a sibling.
niece(Niece, X) :-
  sibling(Sibling, X),
  daughter(Niece, Sibling),
  \+ parent(X, Niece).

% A nephew is the son of a sibling.
nephew(Nephew, X) :-
  sibling(Sibling, X),
  son(Nephew, Sibling),
  \+ parent(X, Nephew).
  
% A nibling refers to either niece or nephew.
nibling(Nibling, X) :-
  niece(Nibling, X).

nibling(Nibling, X) :-
  nephew(Nibling, X).

% An ancestor is a parent or an ancestor of a parent.
ancestor(Ancestor, X) :-
  parent(Ancestor, X).

ancestor(Ancestor, X) :-
  parent(Parent, X),
  ancestor(Ancestor, Parent).

% A descendent is a child or a descendant of a child.
descendant(Descendant, X) :-
  child(Descendant, X).

descendant(Descendant, X) :-
  child(Child, X),
  descendant(Descendant, Child).

/* THE FACTS

These are all the true statements about basic relationships.
https://relatednesscalculator.nolanlawson.com/

*/

parent(homer, lisa).
parent(homer, maggie).
parent(homer, bart).
parent(marge, lisa).
parent(marge, maggie).
parent(marge, bart).
parent(abe, herb).
parent(abe, homer).
parent(mona, herb).
parent(mona, homer).
parent(selma, ling).
parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jacqueline, marge).
parent(jacqueline, patty).
parent(jacqueline, selma).

spouse(abe, moana).
spouse(moana, abe).
spouse(homer, marge).
spouse(marge, homer).
spouse(clancy, jacqueline).
spouse(jacqueline, clancy).

gender(abe, male).
gender(clancy, male).
gender(herb, male).
gender(homer, male).
gender(bart, male).
gender(mona, female).
gender(jacqueline, female).
gender(marge, female).
gender(patty, female).
gender(selma, female).
gender(lisa, female).
gender(maggie, female).
gender(ling, female).
