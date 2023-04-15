language(java).
paradigm(java, object_oriented).
paradigm(java, procedural).
popularity(java, very_popular).
objective(java, system).
objective(java, software).
objective(java, web_apps).
objective(java, desktop_apps).
objective(java, mobile_apps).
run_type(java, compiled).
level(java, high).
typed(java, static).


language(python).
paradigm(python, object_oriented).
paradigm(python, functional).
paradigm(python, procedural).
popularity(python, very_popular).
objective(python, system).
objective(python, software).
objective(python, web_apps).
objective(python, desktop_apps).
objective(python, games).
run_type(python, interpreted).
level(python, high).
typed(python, dynamic).


language(c).
paradigm(c, procedural).
popularity(c, regular).
objective(c, system).
objective(c, software).
run_type(c, compiled).
level(c, partially).
typed(c, static).


language(cpp).
paradigm(cpp, object_oriented).
paradigm(cpp, procedural).
popularity(cpp, very_popular).
objective(cpp, system).
objective(cpp, software).
objective(cpp, mobile_apps).
objective(cpp, desktop_apps).
objective(cpp, games).
run_type(cpp, compiled).
level(cpp, partially).
typed(cpp, static).


language(c_sharp).
paradigm(c_sharp, object_oriented).
paradigm(c_sharp, procedural).
popularity(c_sharp, popular).
objective(c_sharp, system).
objective(c_sharp, software).
objective(c_sharp, games).
objective(c_sharp, desktop_apps).
run_type(c_sharp, compiled).
level(c_sharp, high).
typed(c_sharp, static).


language(f_sharp).
paradigm(f_sharp, object_oriented).
paradigm(f_sharp, functional).
paradigm(f_sharp, procedural).
popularity(f_sharp, rare).
objective(f_sharp, system).
objective(f_sharp, software).
objective(f_sharp, games).
objective(f_sharp, desktop_apps).
run_type(f_sharp, compiled).
level(f_sharp, high).
typed(f_sharp, static).


language(haskell).
paradigm(haskell, functional).
paradigm(haskell, procedural).
popularity(haskell, rare).
objective(haskell, software).
objective(haskell, web_apps).
run_type(haskell, compiled).
level(haskell, high).
typed(haskell, static).


language(prolog).
paradigm(prolog, functional).
paradigm(prolog, logical).
popularity(prolog, very_rare).
objective(prolog, software).
run_type(prolog, compiled).
level(prolog, high).
typed(prolog, dynamic).


choose_language(Lang) :-
    prompt_choose_paradigms(Paradigms),
    prompt_choose_popularity(Popularity),
    prompt_choose_objective(Objective),
    prompt_choose_run_type(RunType),
    prompt_choose_level(Level),
    prompt_choose_typed(Typed),
    language(Lang),
    ( Paradigms == null ; maplist(paradigm(Lang), Paradigms) ),
    ( Popularity == null ; popularity(Lang, Popularity) ),
    ( Objective == null ; objective(Lang, Objective) ),
    ( RunType == null ; run_type(Lang, RunType) ),
    ( Level == null ; level(Lang, Level) ),
    ( Typed == null ; typed(Lang, Typed) ).


prompt_choose_paradigms(Paradigms) :-
    (   y_or_n('Have you got any choosen paradigms?')
    ->  choose_multiple('Choose paradigms (separate with commas):', paradigm, Paradigms)
    ;   Paradigms = null
    ).


prompt_choose_popularity(Popularity) :-
    (   y_or_n('Do you want to choose popularity of language?')
    ->  choose_single('Choose popularity:', popularity, Popularity)
    ;   Popularity = null
    ).


prompt_choose_objective(Objective) :-
    (   y_or_n('Do you want to choose objective?')
    ->  choose_single('Choose objective:', objective, Objective)
    ;   Objective = null
    ).


prompt_choose_run_type(RunType) :-
    (   y_or_n('Do you want to choose if it''s compiled or interpreted?')
    ->  choose_single('Choose run type:', run_type, RunType)
    ;   RunType = null
    ).


prompt_choose_level(Level) :-
    (   y_or_n('Do you want to choose level of language?')
    ->  choose_single('Choose level:', level, Level)
    ;   Level = null
    ).


prompt_choose_typed(Typed) :-
    (   y_or_n('Do you want to choose if static or dynamic typed?')
    ->  choose_single('Choose typing:', typed, Typed)
    ;   Typed = null
    ).


choose_single(Prompt, Property, Result) :-
    write(Prompt), nl,
    foreach(option(Property, Number, Name, _), format('~s) ~s~n', [Number, Name])),
    read_line_to_string(user_input, ValueString),
    normalize_space(string(Value), ValueString),
    findall(N, option(Property, N, _, _), PossibleAnswers),
    (   member(Value, PossibleAnswers)
    ->  option(Property, Value, _, Result)
    ;   write('Choosen invalid option, please try again.'), nl,
        choose_single(Prompt, Property, Result)
    ).


choose_multiple(Prompt, Property, Result) :-
    write(Prompt), nl,
    foreach(option(Property, Number, Name, _), format('~s) ~s~n', [Number, Name])),
    read_line_to_string(user_input, ValuesString),
    split_string(ValuesString, ",", ",\s", ValuesOptions),
    findall(N, option(Property, N, _, _), PossibleAnswers),
    (   maplist(member_reversed(PossibleAnswers), ValuesOptions)
    ->  maplist(option(Property), ValuesOptions, _, Result)
    ;   write('Choosen invalid option, please try again.'), nl,
        choose_multiple(Prompt, Property, Result)
    ).


y_or_n(Question) :-
    write(Question), nl,
    write('y or n'), nl,
    get_single_char(C),
    (   (C == 89 ; C == 121)
    ->  true
    ;   (C == 78 ; C == 110)
    ->  false
    ;   y_or_n(Question)
    ).


member_reversed(X, Y) :-
    member(Y, X).


option(popularity, "1", "Very popular", very_popular).
option(popularity, "2", "Popular", popular).
option(popularity, "3", "Regular", regular).
option(popularity, "4", "Rare", rare).
option(popularity, "5", "Very rare", very_rare).
option(popularity, "6", "Almost unknown", almost_unknown).

option(paradigm, "1", "Object oriented", object_oriented).
option(paradigm, "2", "Functional", functional).
option(paradigm, "3", "Procedural", procedural).
option(paradigm, "4", "Logical", logical).

option(objective, "1", "System", system).
option(objective, "2", "Software", software).
option(objective, "3", "Web apps", web_apps).
option(objective, "4", "Mobile apps", mobile_apps).
option(objective, "5", "Desktop apps", desktop_apps).

option(run_type, "1", "Compiled", compiled).
option(run_type, "2", "Interpreted", interpreted).

option(typed, "1", "Static", static).
option(typed, "2", "Dynamic", dynamic).

option(level, "1", "High", high).
option(level, "2", "Partially high", partially).
option(level, "3", "Low", low).
