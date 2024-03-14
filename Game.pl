
% Facts and rules as provided

move(snake).
move(water).
move(gun).

wins(snake, water).
wins(water, gun).
wins(gun, snake).

outcome(PlayerMove, ComputerMove, Result) :-
    wins(PlayerMove, ComputerMove),
    Result = 'Player wins!'.

outcome(PlayerMove, ComputerMove, Result) :-
    wins(ComputerMove, PlayerMove),
    Result = 'Computer wins!'.

outcome(PlayerMove, ComputerMove, Result) :-
    PlayerMove == ComputerMove,
    Result = 'It\'s a draw!'.

% New rules for playing 5 rounds and displaying final results

play_rounds(0, PlayerWins, ComputerWins, Draws) :-
    nl,
    write('Game Over!'), nl,
    write('Player wins: '), write(PlayerWins), nl,
    write('Computer wins: '), write(ComputerWins), nl,
    write('Draws: '), write(Draws), nl,
    determine_winner(PlayerWins, ComputerWins).

play_rounds(RoundsLeft, PlayerWins, ComputerWins, Draws) :-
    write('Round '), write(5 - RoundsLeft), write(': Enter your move (snake, water, gun): '),
    read(PlayerMove),
    random_member(ComputerMove, [snake, water, gun]),
    write('Computer chose: '), write(ComputerMove), nl,
    outcome(PlayerMove, ComputerMove, Result),
    write(Result), nl,
    update_scores(Result, PlayerWins, ComputerWins, Draws, UpdatedPlayerWins, UpdatedComputerWins, UpdatedDraws),
    NewRoundsLeft is RoundsLeft - 1,
    play_rounds(NewRoundsLeft, UpdatedPlayerWins, UpdatedComputerWins, UpdatedDraws).

update_scores('Player wins!', PlayerWins, ComputerWins, Draws, UpdatedPlayerWins, ComputerWins, Draws) :-
    UpdatedPlayerWins is PlayerWins + 1.

update_scores('Computer wins!', PlayerWins, ComputerWins, Draws, PlayerWins, UpdatedComputerWins, Draws) :-
    UpdatedComputerWins is ComputerWins + 1.

update_scores('It\'s a draw!', PlayerWins, ComputerWins, Draws, PlayerWins, ComputerWins, UpdatedDraws) :-
    UpdatedDraws is Draws + 1.

determine_winner(PlayerWins, ComputerWins) :-
    nl,
    write('Final Results:'), nl,
    (PlayerWins > ComputerWins ->
        write('Player is the overall winner!');
        (ComputerWins > PlayerWins ->
            write('Computer is the overall winner!');
            write('It\'s a tie!'))).

% Entry point
start_game :-
    play_rounds(5, 0, 0, 0).
