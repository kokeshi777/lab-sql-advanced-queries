#task 1
select 
count(*) as actors_pair,
fa1.film_id, 
fa1.actor_id as actor_id1, 
concat(a1.first_name, ' ', a1.last_name) as actor_name1, 
fa2.actor_id as actor_id2, 
concat(a2.first_name, ' ', a2.last_name) as actor_name2
from actor as a1
join film_actor as fa1
on a1.actor_id = fa1.actor_id
join film_actor as fa2
on fa1.actor_id <> fa2.actor_id
and fa1.actor_id < fa2.actor_id
and fa1.film_id = fa2.film_id
join actor as a2
on a2.actor_id = fa2.actor_id
group by actor_id1
order by actors_pair, actor_id1, actor_id2;
#Task #2
create view multiple_actors as 
select film_id, actor_id from  film_actor
where actor_id in (select actor_id from film_actor
group by actor_id
having count(film_id)>1
order by count(film_id) asc)
order by film_id;
drop view if exists multiple_actors;
create view multiple_actors as 
select film_id, actor_id from film_actor
group by actor_id
order by film_id asc;

select f.title, a.first_name, a.last_name  from multiple_actors as m
join actor as a using(actor_id)
join film as f using(film_id)
order by film_id asc;

