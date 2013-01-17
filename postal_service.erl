-module(postal_service).

-export([start/0]).


start() -> loop([]).
loop(Connected) ->
   receive 
      {add_client, Client} ->
         io:format("starting a client handler\n"),
         spawn( client_handler, start(), [Client, self()] ),
         loop(Connected ++ [Client]);
      
      {send_all, Message} ->
         io:format("sending ~p to everyone", [Message]);
      _ ->
         io:format("received an unknown\n")
   end.