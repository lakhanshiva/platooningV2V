%% 11/17/18
%% Lakhan Kamireddy

-module(p1).

-export([start/0, leader/0]).

leader() -> %% This is the leader process function
	receive
		finished ->
			io:format("Leader finished~n", []);
		drive ->
			io:format("Leader received the command to drive forward~n", [])
	end.

start() -> %% program execution begins here
	Leader_PID = spawn(p1, leader, []), %% Spawning the leader process
	Leader_PID ! drive. %% Sending the command drive to the leader process