mother(X,Y) :- parent(X,Y),female(X).
father(X,Y) :- parent(X,Y),male(X).
son(X,Y) :- parent(Y,X),male(X).
daughter(X,Y) :- parent(Y,X),female(X).
sister(X,Y) :- parent(Z,X),parent(Z,Y),female(X),X \= Y.
brother(X,Y) :- parent(Z,X),parent(Z,Y),male(X),X \= Y.
sibling(X,Y) :- parent(Z,X),parent(Z,Y),X \= Y.
grandmother(X,Y) :- parent(Z,Y),mother(X,Z).
grandfather(X,Y) :- parent(Z,Y),father(X,Z).
grandson(X,Y) :- parent(Y,Z),son(X,Z).
granddaughter(X,Y) :- parent(Y,Z),daughter(X,Z).
aunt(X,Y) :- parent(Z,Y),sister(X,Z).
uncle(X,Y) :- parent(Z,Y),brother(X,Z).
niece(X,Y) :- sibling(Z,Y),daughter(X,Z).
nephew(X,Y) :- sibling(Z,Y),son(X,Z).
cousin(X,Y) :- parent(Z,X),parent(T,Y),sibling(Z,T). 

human(X) :- male(X).
human(X) :- female(X).

member(Element,[Element|Tail]).
member(Element,[Head|Tail]) :- member(Element,Tail).
makeSet([],[]).
makeSet([Head|Tail],List):- makeSet(Tail,List),member(Head,List).
makeSet([Head|Tail],[Head|List]) :- makeSet(Tail,List), not(member(Head,List)).		

allPeople(L,N) :- findall(X,human(X),L),length(L,N).

relative(Y,X) :- mother(X,Y).
relative(Y,X) :- father(X,Y).
relative(Y,X) :- son(X,Y).
relative(Y,X) :- daughter(X,Y).
relative(Y,X) :- sibling(X,Y).
relative(Y,X) :- grandmother(X,Y).
relative(Y,X) :- grandfather(X,Y).
relative(Y,X) :- grandson(X,Y).
relative(Y,X) :- granddaughter(X,Y).
relative(Y,X) :- aunt(X,Y).
relative(Y,X) :- uncle(X,Y).
relative(Y,X) :- niece(X,Y).
relative(Y,X) :- nephew(X,Y).
relative(Y,X) :- cousin(X,Y).

removeNonRelatives(X,L,R) :- findall(Y,relative(Y,X),Relativelist),
							 intersection(L,Relativelist,List),makeSet(List,R).

mlC(X,Y) :- cousin(X,Y),male(Y).
maleCousins(X,MC) :- findall(Y,mlC(X,Y),List),makeSet(List,MC).

newGeneration(L) :- findall(X,human(X),AllPeople),
			findall(Z,parent(Z,T),ParentList),subtract(AllPeople,ParentList,L1),makeSet(L1,L).