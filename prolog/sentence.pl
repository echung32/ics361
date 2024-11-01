% fruit flies like a banana

% noun - fruit
% verb - flies
% prep - like
% np - fruit flies
% v - like

% sentence(Parse, X, [])
% sentence(Parse, [fruit, flies, like, a, banana], [])

sentence(s(X,Y)) --> noun_phrase(X), verb_phrase(Y).

noun_phrase(np(N)) --> noun(N).
noun_phrase(np(Det,N)) --> det(Det), noun(N).
noun_phrase(np(N,N)) --> noun(N), noun(N).

prep_phrase(pp(P, NP)) --> prep(P), noun_phrase(NP).

verb_phrase(vp(V)) --> verb(V).
verb_phrase(vp(V, NP)) --> verb(V), noun_phrase(NP).
verb_phrase(vp(V, PP)) --> verb(V), prep_phrase(PP).

noun(n(fruit)) --> [fruit].
noun(n(banana)) --> [banana].
noun(n(flies)) --> [flies].

verb(v(flies)) --> [flies].
verb(v(like)) --> [like].

prep(p(like)) --> [like].

det(d(a)) --> [a].