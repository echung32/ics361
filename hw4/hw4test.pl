/**
 * 
 * This test file was generated by ChatGPT with manual modifications.
 * After loading file with `swipl -s hw4/hw4test.pl`, execute `run_tests.`
 * 
 */

:- include("hw4main.pl").
:- begin_tests(relationships).

% Tests for 'father' relationship
test(father_yesno_true) :-
    query([is,it,true,that,homer,is,the,father,of,lisa], _).
test(father_yesno_false) :-
    \+ query([is,it,true,that,abe,is,the,father,of,bart], _).
test(father_whois) :-
    query([who,is,the,father,of,lisa], homer).

% Tests for 'mother' relationship
test(mother_yesno_true) :-
    query([is,it,true,that,marge,is,the,mother,of,lisa], _).
test(mother_yesno_false) :-
    \+ query([is,it,true,that,jacqueline,is,the,mother,of,bart], _).
test(mother_whois) :-
    query([who,is,the,mother,of,ling], selma).

% Tests for 'sibling' relationship
test(sibling_yesno_true) :-
    query([is,it,true,that,lisa,is,the,sibling,of,bart], _).
test(sibling_yesno_false) :-
    \+ query([is,it,true,that,ling,is,the,sibling,of,lisa], _).
test(sibling_whois_multiple) :-
    query([who,is,the,sibling,of,bart], lisa).
test(sibling_whois_multiple) :-
    query([who,is,the,sibling,of,bart], maggie).

% Tests for 'sister'
test(sister_yesno) :-
    query([is,it,true,that,lisa,is,the,sister,of,bart], _).
test(sister_whois) :-
    query([who,is,the,sister,of,bart], lisa).

% Tests for 'brother'
test(brother_yesno) :-
    query([is,it,true,that,bart,is,the,brother,of,lisa], _).
test(brother_whois) :-
    query([who,is,the,brother,of,lisa], bart).

% Tests for 'grandfather' relationship
test(grandfather_yesno_true) :-
    query([is,it,true,that,abe,is,the,grandfather,of,lisa], _).
test(grandfather_yesno_false) :-
    \+ query([is,it,true,that,abe,is,the,grandfather,of,ling], _).
test(grandfather_whois_multiple) :-
    query([who,is,the,grandfather,of,lisa], abe).
test(grandfather_whois_multiple) :-
    query([who,is,the,grandfather,of,lisa], clancy).

% Tests for 'grandmother' relationship
test(grandmother_yesno_true) :-
    query([is,it,true,that,mona,is,the,grandmother,of,lisa], _).
test(grandmother_yesno_false) :-
    \+ query([is,it,true,that,patty,is,the,grandmother,of,ling], _).
test(grandmother_whois_multiple) :-
    query([who,is,the,grandmother,of,lisa], mona).
test(grandmother_whois_multiple) :-
    query([who,is,the,grandmother,of,lisa], jacqueline).

% Tests for 'husband' relationship
test(husband_yesno_true) :-
    query([is,it,true,that,homer,is,the,husband,of,marge], _).
test(husband_yesno_false) :-
    \+ query([is,it,true,that,abe,is,the,husband,of,selma], _).
test(husband_whois) :-
    query([who,is,the,husband,of,marge], homer).

% Tests for 'wife' relationship
test(wife_yesno_true) :-
    query([is,it,true,that,marge,is,the,wife,of,homer], _).
test(wife_yesno_false) :-
    \+ query([is,it,true,that,homer,is,the,wife,of,marge], _).
test(wife_whois) :-
    query([who,is,the,wife,of,homer], marge).

% Tests for 'aunt' relationship
test(aunt_yesno_true) :-
    query([is,it,true,that,patty,is,the,aunt,of,lisa], _).
test(aunt_yesno_false) :-
    \+ query([is,it,true,that,marge,is,the,aunt,of,maggie], _).
test(aunt_whois_multiple) :-
    query([who,is,the,aunt,of,lisa], patty).
test(aunt_whois_multiple) :-
    query([who,is,the,aunt,of,lisa], selma).

% Tests for 'uncle' relationship
test(uncle_yesno_true) :-
    query([is,it,true,that,herb,is,the,uncle,of,bart], _).
test(uncle_yesno_true) :-
    query([is,it,true,that,homer,is,the,uncle,of,ling], _).
test(uncle_yesno_false) :-
    \+ query([is,it,true,that,abe,is,the,uncle,of,lisa], _).
test(uncle_yesno_false) :-
    \+ query([is,it,true,that,herb,is,the,uncle,of,ling], _).
test(uncle_whois) :-
    query([who,is,the,uncle,of,lisa], herb).

% Tests for 'cousin' relationship
test(cousin_yesno_true) :-
    query([is,it,true,that,ling,is,the,cousin,of,bart], _).
test(cousin_yesno_false) :-
    \+ query([is,it,true,that,lisa,is,the,cousin,of,herb], _).
test(cousin_whois) :-
    query([who,is,the,cousin,of,bart], ling).

% Tests for 'nephew' relationship
test(nephew_yesno_true) :-
    query([is,it,true,that,bart,is,the,nephew,of,patty], _).
test(nephew_yesno_false) :-
    \+ query([is,it,true,that,ling,is,the,nephew,of,selma], _).
test(nephew_whois) :-
    query([who,is,the,nephew,of,patty], bart).
test(nephew_whois) :-
    query([who,is,the,nephew,of,selma], bart).

% Tests for 'niece' relationship
test(niece_yesno_true) :-
    query([is,it,true,that,lisa,is,the,niece,of,patty], _).
test(niece_yesno_false) :-
    \+ query([is,it,true,that,bart,is,the,niece,of,selma], _).
test(niece_whois) :-
    query([who,is,the,niece,of,patty], lisa).
test(niece_whois) :-
    query([who,is,the,niece,of,selma], maggie).

% Tests for 'nibling' relationship
test(nibling_yesno_true) :-
    query([is,it,true,that,bart,is,the,nibling,of,patty], _).
test(nibling_yesno_true) :-
    query([is,it,true,that,lisa,is,the,nibling,of,selma], _).
test(nibling_yesno_false) :-
    \+ query([is,it,true,that,ling,is,the,nibling,of,homer], _).
test(nibling_whois) :-
    query([who,is,the,nibling,of,patty], bart).
test(nibling_whois) :-
    query([who,is,the,nibling,of,selma], lisa).
test(nibling_whois) :-
    query([who,is,the,nibling,of,selma], maggie).

% Tests for 'child'
test(child_yesno) :-
    query([is,it,true,that,bart,is,the,child,of,homer], _).
test(child_whois) :-
    query([who,is,the,child,of,marge], lisa).

% Tests for 'grandchild'
test(grandchild_yesno) :-
    query([is,it,true,that,lisa,is,the,grandchild,of,abe], _).
test(grandchild_whois) :-
    query([who,is,the,grandchild,of,abe], lisa).

% Tests for 'son'
test(son_yesno) :-
    query([is,it,true,that,bart,is,the,son,of,homer], _).
test(son_whois) :-
    query([who,is,the,son,of,homer], bart).

% Tests for 'daughter'
test(daughter_yesno) :-
    query([is,it,true,that,lisa,is,the,daughter,of,marge], _).
test(daughter_whois) :-
    query([who,is,the,daughter,of,marge], lisa).

% Tests for 'granddaughter'
test(granddaughter_yesno) :-
    query([is,it,true,that,lisa,is,the,granddaughter,of,mona], _).
test(granddaughter_whois) :-
    query([who,is,the,granddaughter,of,abe], lisa).

% Tests for 'grandson'
test(grandson_yesno) :-
    query([is,it,true,that,bart,is,the,grandson,of,abe], _).
test(grandson_whois) :-
    query([who,is,the,grandson,of,abe], bart).

% Tests for 'grandparent'
test(grandparent_yesno) :-
    query([is,it,true,that,abe,is,the,grandparent,of,lisa], _).
test(grandparent_whois) :-
    query([who,is,the,grandparent,of,bart], abe).

:- end_tests(relationships).

:- begin_tests(ancestry).

test(ancestor_yesno_true) :-
    query([is,it,true,that,abe,is,the,ancestor,of,lisa], _).
test(ancestor_yesno_false) :-
    \+ query([is,it,true,that,ling,is,the,ancestor,of,bart], _).
test(ancestor_whois) :-
    query([who,is,the,ancestor,of,bart], abe).
test(ancestor_all) :-
    findall(X, ancestor(X, bart), Ancestors),
    Ancestors = [homer, marge, abe, mona, clancy, jacqueline].

% Tests for `descendant`
test(descendant_yesno_true) :-
    query([is,it,true,that,bart,is,the,descendant,of,abe], _).
test(descendant_yesno_false) :-
    \+ query([is,it,true,that,clancy,is,the,descendant,of,homer], _).
test(descendant_whois) :-
    query([who,is,the,descendant,of,abe], homer).
test(descendant_all) :-
    findall(X, descendant(X, abe), Descendants),
    Descendants = [herb, homer, lisa, maggie, bart].

% Comprehensive ancestor and descendant direct queries
test(ancestor_direct_true) :-
    ancestor(abe, lisa).
test(ancestor_direct_false) :-
    \+ ancestor(ling, bart).
test(descendant_direct_true) :-
    descendant(bart, abe).
test(descendant_direct_false) :-
    \+ descendant(clancy, homer).

:- end_tests(ancestry).

:- begin_tests(compound_sentences).

% Compound sentences using "and" for relationships

% Tests for compound sentences using "and" (is a relationship)
test(compound_and_father) :-
    query([is,it,true,that,homer,is,the,father,of,lisa,and,homer,is,the,father,of,bart], _).
test(compound_and_mother) :-
    query([is,it,true,that,marge,is,the,mother,of,lisa,and,marge,is,the,mother,of,bart], _).
test(compound_and_sister) :-
    query([is,it,true,that,lisa,is,the,sister,of,bart,and,lisa,is,the,sister,of,maggie], _).
test(compound_and_brother) :-
    query([is,it,true,that,bart,is,the,brother,of,lisa,and,bart,is,the,brother,of,maggie], _).
test(compound_and_sibling) :-
    query([is,it,true,that,lisa,is,the,sibling,of,bart,and,lisa,is,the,sibling,of,maggie], _).
test(compound_and_aunt) :-
    query([is,it,true,that,patty,is,the,aunt,of,lisa,and,patty,is,the,aunt,of,bart], _).
test(compound_and_uncle) :-
    query([is,it,true,that,herb,is,the,uncle,of,lisa,and,herb,is,the,uncle,of,bart], _).
test(compound_and_nephew) :-
    query([is,it,true,that,bart,is,the,nephew,of,selma,and,bart,is,the,nephew,of,patty], _).
test(compound_and_niece) :-
    query([is,it,true,that,lisa,is,the,niece,of,selma,and,lisa,is,the,niece,of,patty], _).
test(compound_and_nibling) :-
    query([is,it,true,that,bart,is,the,nibling,of,selma,and,bart,is,the,nibling,of,patty], _).
test(compound_and_grandparent) :-
    query([is,it,true,that,abe,is,the,grandparent,of,lisa,and,abe,is,the,grandparent,of,bart], _).
test(compound_and_grandfather) :-
    query([is,it,true,that,abe,is,the,grandfather,of,lisa,and,abe,is,the,grandfather,of,bart], _).
test(compound_and_grandmother) :-
    query([is,it,true,that,mona,is,the,grandmother,of,lisa,and,mona,is,the,grandmother,of,bart], _).
test(compound_and_husband) :-
    query([is,it,true,that,homer,is,the,husband,of,marge,and,homer,is,the,husband,of,marge], _).
test(compound_and_wife) :-
    query([is,it,true,that,marge,is,the,wife,of,homer,and,marge,is,the,wife,of,homer], _).
test(compound_and_cousin) :-
    query([is,it,true,that,ling,is,the,cousin,of,bart,and,ling,is,the,cousin,of,lisa], _).

% Compound sentences using "and" for "has-a" relationships
test(compound_and_has_father) :-
    query([is,it,true,that,homer,has,a,father,and,homer,has,a,mother], _).
test(compound_and_has_daughter) :-
    query([is,it,true,that,homer,has,a,daughter,and,marge,has,a,daughter], _).

% Compound sentences using "is-a" and "has-a" relationships
test(compound_and_is_a_father_and_has_a_daughter) :-
    query([is,it,true,that,homer,is,a,father,and,homer,has,a,daughter], _).
test(compound_and_is_a_husband_and_has_a_wife) :-
    query([is,it,true,that,homer,is,a,husband,and,marge,has,a,husband], _).

% More complex compound sentences
test(compound_is_a_and_has_a) :-
    query([is,it,true,that,homer,is,a,father,and,homer,has,a,daughter,and,marge,is,the,mother,of,lisa], _).
test(compound_and_is_a_and_has_a_cousin) :-
    query([is,it,true,that,homer,is,a,father,and,homer,has,a,son,and,lisa,is,the,daughter,of,homer], _).

% Queries combining "and" with "is-a" or "has-a" relationships and others
test(compound_and_grandparent_and_parent) :-
    query([is,it,true,that,abe,is,the,grandparent,of,lisa,and,abe,is,the,parent,of,homer], _).
test(compound_and_is_a_grandfather_and_is_a_father) :-
    query([is,it,true,that,abe,is,a,grandfather,and,abe,is,a,father], _).

% Tests for compound sentences using "and" for is-a/has-a relationships
test(compound_and_is_a_parent_and_has_a_child) :-
    query([is,it,true,that,homer,is,a,parent,and,homer,has,a,child], _).

:- end_tests(compound_sentences).

:- begin_tests(are_have_relations).

% Tests for "are" (plural relationships)
test(are_parents) :-
    query([is,it,true,that,homer,and,marge,are,parents], _).
test(are_siblings) :-
    query([is,it,true,that,lisa,and,bart,are,siblings], _).
test(are_children) :-
    query([is,it,true,that,lisa,and,bart,are,children], _).
test(are_grandparents) :-
    query([is,it,true,that,abe,and,mona,are,grandparents], _).
test(are_cousins) :-
    query([is,it,true,that,ling,and,lisa,are,cousins], _).

% 3rd person (parents including Selma)
test(are_parents_with_selma) :-
    query([is,it,true,that,homer,and,marge,and,selma,are,parents], _).
test(are_grandparents_with_selma) :-
    query([is,it,true,that,abe,and,mona,and,selma,are,grandparents], _).

% "Is it true that X and Y are siblings" with individual siblings
test(are_siblings_individual) :-
    query([is,it,true,that,homer,and,lisa,are,siblings], _).

% Tests for "have" (plural relationships)
test(have_children) :-
    query([is,it,true,that,homer,and,marge,have,children], _).
test(have_siblings) :-
    query([is,it,true,that,homer,and,marge,have,siblings], _).
test(have_grandchildren) :-
    query([is,it,true,that,abe,and,mona,have,grandchildren], _).
test(have_cousins) :-
    query([is,it,true,that,lisa,and,bart,have,cousins], _).

% Tests for gramatically incorrect phrases
test(are_parents_fail) :-
    \+ query([is,it,true,that,homer,are,parents], _).
test(have_parents_fail) :-
    \+ query([is,it,true,that,homer,have,parents], _).
test(are_and_have_fail) :-
    \+ query([is,it,true,that,homer,are,parents,and,homer,have,parents], _).

% Tests for compound sentences with multiple people.
test(are_parents_have_children_compound) :-
    query([is,it,true,that,homer,and,marge,are,parents,and,homer,and,marge,have,children], _).
test(are_parents_compound) :-
    query([is,it,true,that,homer,and,marge,are,parents,and,homer,and,marge,are,parents], _).
test(are_grandparents_compound) :-
    query([is,it,true,that,abe,and,mona,are,grandparents,and,jacqueline,and,clancy,are,grandparents], _).

:- end_tests(are_have_relations).

