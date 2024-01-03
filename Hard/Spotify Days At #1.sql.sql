  ----------------------------------------Question-----------------------------------------------------
  --// Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings on the same day.  //--                                                     //--
  --// Output the track name and the number of days in the 1st position.     //--
  --//  Order your output alphabetically by track name.     //--
  --// If the region 'US' appears in dataset, it should be included in the worldwide ranking.       //--                                                             //--
  -----------------------------------------Tables-----------------------------------------------------------
  --spotify_daily_rankings_2017_us,
  --------------------colums----------------
  --position: int
  --trackname: varchar
  --artist: varchar
  --strems: int
  --url: varchar
  --date: datetime
  -- spotify_worldwide_daily_song_ranking
  --------------------colums----------------
  --id: int
  --postion: int
  --trackname: int
  --trackname: varchar
  --artist: varchar
  --strems: int
  --url: varchar
  --date: datetime
  --region: varchar
  -----------------------------------------Let's start solving!!--------------------------------------
  --EXPECTED OUTPUT: track_name | no_of_days_inn1_position 
  -- ORDER BY trackname alphabetically
-----------------------------------------steps to solve the question----------------
--Merge the two tabels on trackname and date columns
--filter out the US tracks that are in postion #1
-- to calculate the no. days a particular track had stayed in the first place by creating a subset of only US track names
-- it's a bit tricky 
--1) we need to check if the US #1 track is also #1 in worldwide ranking
--2) we need to get the sum of the number of times it has occured
  --define a new column using SUM() OVER (PARTITION BY) clauses
  --Insert CASE expressions within the SUM() function
    --WHEN world.position =1 THEN 1
    --ELSE 0
--store SUM() value in new column say "n_days_on_n1_position"
--select trackname and perform MAX() function on temp table with GROUP BY
--ORDER BY trackname

-------------writting the solution---------------
select tmp.trackname, 
            max(n_day_on_n1_position) as n_day_on_n1_position
from
(select us.trackname , 
        SUM(CASE
            WHEN world.position =1 THEN 1
        ELSE 0
        END) OVER (PARTITION BY us.trackname) AS n_day_on_n1_position
from spotify_daily_rankings_2017_us us
inner join spotify_worldwide_daily_song_ranking world
on world.trackname = us.trackname
and world.date = us.date
where us.position = 1) tmp
group by trackname
order by trackname


