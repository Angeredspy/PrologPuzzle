video(baby_eats_cake). 
video(dancing_hyena). 
video(happy_hermits). 
video(magnet_mayhem). 

time(fifteen_seconds).
time(thirtyone_seconds).
time(thirtyeight_seconds).
time(fiftyfive_seconds). 

views(four_million).
views(five_million).
views(six_million).
views(seven_million). 

solve :-  
    video(BillVideo) , video(InezVideo) , video(StacyVideo) , video(CarlVideo), 
    all_different([BillVideo, InezVideo , StacyVideo , CarlVideo]) ,  

    time(BillVideoTime), time(InezVideoTime) , time(StacyVideoTime), time(CarlVideoTime) , 
    all_different([BillVideoTime , InezVideoTime , StacyVideoTime , CarlVideoTime]) , 

    views(BillVideoViews) , views(InezVideoViews) , views(StacyVideoViews) , views(CarlVideoViews), 
    all_different([BillVideoViews , InezVideoViews , StacyVideoViews , CarlVideoViews]),   

    Groups = [ [bill , BillVideo , BillVideoTime , BillVideoViews],
               [inez , InezVideo , InezVideoTime , InezVideoViews], 
               [stacy, StacyVideo, StacyVideoTime, StacyVideoViews], 
               [carl , CarlVideo , CarlVideoTime , CarlVideoViews] ] , 

    % 1. The video with 6 million views is either happy happy_hermits or the 15_second long video  
    ((member([_ , happy_hermits , _ , six_million], Groups),
     not(member([_ , _ , fifteen_seconds, six_million], Groups));
    
     member([_ , _ , fifteen_seconds , six_million], Groups)), 
    not(member([_ , happy_hermits , _ , six_million], Groups))), 

    % 2.  magnet_mayhem is either the video with 7 million views or the video thats 31_seconds long 
    ((member([_ , magnet_mayhem , thirtyone_seconds , _] , Groups), 
        not(member([_ , magnet_mayhem , _ , seven_million], Groups));
   
     member([_ , magnet_mayhem , _ , seven_million] , Groups)), 
     not(member([_ , magnet_mayhem , thirtyone_seconds , _], Groups))),   

     not(member([_ , magnet_mayhem , fiftyfive_seconds , _], Groups)),

    % 3. Stacys viral video is 15_seconds long 
    ((member([stacy , _ , fifteen_seconds , _], Groups), 
    not(member([inez , _ , fifteen_seconds , _], Groups)),
    not(member([carl , _ , fifteen_seconds , _], Groups)),
    not(member([bill , _ , fifteen_seconds , _], Groups)))),  

    %4. the viral video thats 38 seconds long isnt baby eats cake 
    not(member([_ , baby_eats_cake , thirtyeight_seconds , _], Groups)), 

    %5. carls video has 2 million more views than dancing hyena   
    ((member([carl , _ , _ , six_million], Groups),
    member([_ , dancing_hyena , _ , four_million], Groups));

    (member([carl , _ , _ , seven_million], Groups), 
    member([_ , dancing_hyena , _ , five_million], Groups))),

    %6. bills viral video received 4 million views 
    ((member([bill , _ , _ , four_million], Groups),
    not(member([inez , _ , _ , four_million], Groups)),
    not(member([carl , _ , _ , four_million], Groups)),
    not(member([stacy , _ , _ , four_million], Groups)))),

    %7. Neither happy hermits nor the video thats 31 seconds long is Inezs video
    not(member([inez , happy_hermits , _ , _], Groups)),
    not(member([inez , _ , thirtyone_seconds , _], Groups)), 

    %8. of the video thats 15 seconds long and carls video, one is magnet mayhem and the other got 6 million views  
     ((member([_ , magnet_mayhem , fifteen_seconds , _], Groups), 
        member([carl , _ , _ , six_million], Groups),
       not(member([carl , magnet_mayhem , _ , _], Groups)),
       not(member([_ , magnet_mayhem , _ , six_million], Groups)); 

       (member([_ , _ , fifteen_seconds , six_million], Groups), 
        member([carl , magnet_mayhem , _ , _], Groups)),
        not(member([carl , _ , _ , six_million], Groups)),
       not(member([_ , magnet_mayhem , fifteen_seconds , _], Groups)))), 
 
   tell(bill , BillVideo , BillVideoTime , BillVideoViews), 
   tell(inez , InezVideo , InezVideoTime , InezVideoViews), 
   tell(stacy , StacyVideo , StacyVideoTime, StacyVideoViews), 
   tell(carl , CarlVideo , CarlVideoTime ,CarlVideoViews).  

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(Q, X, Y, Z) :-
   write('A person called  '), write(Q), write('  Took a video called '), 
   write(X), write(' that was  '), write(Y), write(' and Got '), write(Z), write(' . ') 
   , nl .
