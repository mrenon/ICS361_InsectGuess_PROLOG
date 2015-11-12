

% -*- mode: Prolog  -*-
% (c) J. R. Fisher.
% http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_17.html 
%
% information from:
% http://wildlifeofhawaii.com/
% http://www.bishopmuseum.org/research/natsci/waipiostudy/students/meet_the_critters/insects.htm

% Animal identification rules
% To run, type      go.

go :- hypothesize(Animal), 
       write('I guess that the animal is: '), 
       write(Animal), nl, undo.

 /* hypotheses to be tested */ 
hypothesize(kamehameha_butterfly) :- kamehameha_butterfly, !. 
hypothesize(koa_butterfly) :- koa_butterfly, !. 
hypothesize(giant_hawaiian_dragonfly) :- giant_hawaiian_dragonfly, !. 
hypothesize(long-legged_flies) :- long-legged_flies, !. 
hypothesize(hawaiian-beaked_crane_fly) :- hawaiian-beaked_crane_fly, !. 
hypothesize(blackburns_hawaiian_damselfly) :- blackburns_hawaiian_damselfly, !. 
hypothesize(hawaiian_pond_bug) :- hawaiian_pond_bug, !. 
hypothesize(hawaiian_saldid_bug) :- hawaiian_saldid_bug, !. 
hypothesize(koa_bug) :- koa_bug, !. 
hypothesize(kauai_cave_wolf_spider) :- kauai_cave_wolf_spider, !. 

hypothesize(unknown). /* no diagnosis */ 

/* animal identification rules */ 
/* 10 required species */
kamehameha_butterfly :- lepidoptera,
                        verify(has_orange).
koa_butterfly :- lepidoptera, 
                        verify(has_green).
giant_hawaiian_dragonfly :- diptera, carnivore,
                        verify(has_green).
long-legged_flies :- diptera, carnivore, 
                        verify(has_brown).
hawaiian-beaked_crane_fly :- diptera, omnivore,
                        verify(has_brown).
blackburns_hawaiian_damselfly :- odonata,
                        verify(has_red).
hawaiian_pond_bug :- hemiptera, carnivore, 
                        verify(no_antennae),
                        verify(has_black).
hawaiian_saldid_bug :- hemiptera, carnivore,
                        verify(has_spots),
                        verify(no_antennae).
koa_bug :- hemiptera, herbivore, 
                        verify(no_antennae),
                        verify(has_green).
kauai_cave_wolf_spider :- araneae, herbivore, 
                        verify(has_brown).


/* 5 additional species */
happy_faced_spider :- araneae, carnivore,
                        verify(has_yellow).
nihoa_trapdoor_spider :- araneae, carnivore,
                        verify(has_brown).
oahu_tree_snail :- gastorpoda, herbivore,
                        verify(has_brown).
blackburns_sphinx_moth :- lepidoptera,
                        verify(has_spots),
                        verify(has_brown).
opae_ula :- decapoda, herbivore,
                        verify(has_red).



/* classification rules */
lepidoptera :-          herbivore,
                        verify(haustellum_mouth),
                        verify(has_wings), !.

diptera :-              verify(sucking_mouth), 
                        verify(has_wings), !.
 
odonata :-              carnivore,
                        verify(mandible_mouth), 
                        verify(has_wings), !.

hemiptera :-            verify(proboscis_mouth), 
                        verify(has_wings), !.

araneae :-              verify(fang_mouth), !.

gastorpoda :-           verify(sucking_mouth),
                        verify(has_shell), !.

decapoda :-             verify(mandible_mouth), 
                        verify(has_shell),
                        verify(has_gills), !.

                        

carnivore :- verify(eats_meat), !.

herbivore :- verify(eats_plants), !.

omnivore :-  verify(eats_both), !.

/* how to ask questions */ 
ask(Question) :- 
        write('Does the animal have the following attribute: '), 
        write(Question), write('? '), 
         read(Response), nl, 
         ( (Response == yes ; Response == y) 
         -> assert(yes(Question)) ; 
         assert(no(Question)), fail). 
:- dynamic yes/1,no/1. 
/* How to verify something */ 
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))). 
/* undo all yes/no assertions */ 
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail. 
undo. 