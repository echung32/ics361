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

yesnoquestion --> [is,it,true,that], sentence(Q), {Q}.

sentence(Q) --> person(X), [is,the], relation(Y), [of], person(Z), {=..(Q, [Y,X,Z])}.

whoisquestion(Answer) --> [who, is, the], relation(X), [of], person(Y), {=..(Q, [X,Answer,Y]), Q}.


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

% relation(parent) --> [parent].
relation(father) --> [father].
relation(mother) --> [mother].
relation(sister) --> [sister].
relation(brother) --> [brother].
relation(sibling) --> [sibling].
relation(son) --> [son].
relation(daughter) --> [daughter].
relation(child) --> [child].
relation(aunt) --> [aunt].
relation(uncle) --> [uncle].
relation(niece) --> [niece].
relation(nephew) --> [nephew].
relation(nibling) --> [nibling].
relation(grandparent) --> [grandparent].
relation(grandfather) --> [grandfather].
relation(grandmother) --> [grandmother].
relation(grandchild) --> [grandchild].
relation(granddaughter) --> [granddaughter].
relation(grandson) --> [grandson].
relation(husband) --> [husband].
relation(wife) --> [wife].
relation(cousin) --> [cousin].

/* THE DEFINITIONS

For example: X is Y's father if X is the parent of Y and X is male.

*/

grandparent(Grand, X) :-
  parent(Grand, Parent),
  child(X, Parent).

grandfather(Grand, X) :-
  grandparent(Grand, X),
  gender(Grand, male).

grandmother(Grand, X) :-
  grandparent(Grand, X),
  gender(Grand, female).

father(Father, X) :-
  parent(Father, X),
  gender(Father, male).

mother(Mother, X) :-
  parent(Mother, X),
  gender(Mother, female).

husband(X, Y) :-
  spouse(X, Y),
  gender(X, male).

wife(X, Y) :-
  spouse(X, Y),
  gender(X, female).

child(X, Parent) :-
  parent(Parent, X).

son(X, Parent) :-
  child(X, Parent),
  gender(X, male).

daughter(X, Parent) :-
  child(X, Parent),
  gender(X, female).

grandchild(X, Grand) :-
  grandparent(Grand, X).

grandson(X, Grand) :-
  grandchild(X, Grand),
  gender(X, male).

granddaughter(X, Grand) :-
  grandchild(X, Grand),
  gender(X, female).

% Siblings share the same parent
sibling(X, Y) :-
  parent(Parent, X),
  parent(Parent, Y).

brother(X, Y) :-
  sibling(X, Y),
  gender(X, male).

sister(X, Y) :-
  sibling(X, Y),
  gender(X, female).

% Siblings have one parent that is the sibling of the other.
cousin(X, Y) :-
  parent(ParentA, X),
  parent(ParentB, Y),
  sibling(ParentA, ParentB).

% An aunt is a female sibling of their parent.
aunt(Aunt, X) :-
  parent(Parent, X),
  sibling(Parent, Aunt),
  gender(Aunt, female),
  \+ parent(Aunt, X).

uncle(Uncle, X) :-
  parent(Parent, X),
  sibling(Parent, Uncle),
  gender(Uncle, male),
  \+ parent(Uncle, X).

niece(Niece, X) :-
  sibling(Sibling, X),
  daughter(Niece, Sibling),
  \+ parent(X, Niece).

nephew(Nephew, X) :-
  sibling(Sibling, X),
  son(Nephew, Sibling),
  \+ parent(X, Nephew).

nibling(Nibling, X) :-
  niece(Nibling, X).

nibling(Nibling, X) :-
  nephew(Nibling, X).

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

isA(_, [], []).
% Rel, PersonList, QueryList
% Interpretation: HeadP is a Rel.
isA(Rel, [HeadP|RestP], [HeadQ|RestQ]) :-
  HeadQ =.. [Rel, HeadP, _],
  isA(Rel, RestP, RestQ).

hasA(_, [], []).
% Rel, PerosnList, QueryList
% Interpretation: HeadP has a Rel.
hasA(Rel, [HeadP|RestP], [HeadQ, RestQ]) :-
  HeadQ =.. [Rel, _, HeadP],
  hasA(Rel, RestP, RestQ).

% Used to evaluate the predicate list from isA/3, hasA/3.
evaluate_predicates([]).
evaluate_predicates([H|Rest]) :-
    H, evaluate_predicates(Rest).