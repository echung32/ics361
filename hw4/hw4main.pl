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

yesnoquestion --> [is,it,true,that], compound_sentence(Q), {Q}.
whoisquestion(Answer) --> [who, is, the], relation(X), [of], person(Y), {=..(Q, [X,Answer,Y]), Q}.

compound_sentence(Q) --> sentence(Q).
compound_sentence((Q1, Q2)) --> sentence(Q1), [and], compound_sentence(Q2).

sentence(Q) --> person(X), [is,the], relation(Y), [of], person(Z), {=..(Q, [Y,X,Z])}.
sentence(Q) --> person(X), [is,a], relation(Y), {=..(Q, [Y,X,_])}.
sentence(Q) --> person(X), [has,a], relation(Y), {=..(Q, [Y,_,X])}.

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

relation(parent) --> [parent].
relation(father) --> [father].
relation(father) --> [dad]. % Father
relation(father) --> [papa]. % Father
relation(mother) --> [mother].
relation(mother) --> [mom]. % Mother
relation(mother) --> [mama]. % Mother
relation(sister) --> [sister].
relation(sister) --> [sis]. % Sister
relation(brother) --> [brother].
relation(brother) --> [bro]. % Brother
relation(sibling) --> [sibling].
relation(son) --> [son].
relation(daughter) --> [daughter].
relation(child) --> [child].
relation(aunt) --> [aunt].
relation(aunt) --> [aunty]. % Aunt
relation(uncle) --> [uncle].
relation(niece) --> [niece].
relation(nephew) --> [nephew].
relation(nibling) --> [nibling].
relation(grandparent) --> [grandparent].
relation(grandfather) --> [grandfather].
relation(grandfather) --> [grandpa]. % Grandfather
relation(grandmother) --> [grandmother].
relation(grandmother) --> [grandma]. % Grandmother
relation(grandchild) --> [grandchild].
relation(granddaughter) --> [granddaughter].
relation(grandson) --> [grandson].
relation(husband) --> [husband].
relation(husband) --> [hubby]. % Husband
relation(wife) --> [wife].
relation(wife) --> [wifey]. % Wife
relation(cousin) --> [cousin].
relation(cousin) --> [cuz]. % Cousin
relation(ancestor) --> [ancestor].
relation(descendant) --> [descendant].

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

/* #5

Handling is-a has-a DCG.

*/

is_a(_, [], []).
% Rel, PersonList, QueryList
% Interpretation: HeadP is a Rel.
is_a(Rel, [HeadP|RestP], [HeadQ|RestQ]) :-
  HeadQ =.. [Rel, HeadP, _],
  is_a(Rel, RestP, RestQ).

has_a(_, [], []).
% Rel, PerosnList, QueryList
% Interpretation: HeadP has a Rel.
has_a(Rel, [HeadP|RestP], [HeadQ, RestQ]) :-
  HeadQ =.. [Rel, _, HeadP],
  has_a(Rel, RestP, RestQ).

% Used to evaluate the predicate list from is_a/3, has_a/3.
evaluate_predicates([]).
evaluate_predicates([H|Rest]) :-
    H, evaluate_predicates(Rest).