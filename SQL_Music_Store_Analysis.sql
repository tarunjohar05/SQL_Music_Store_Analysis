use movie_database;
select * from actor;
select distinct(act_lname) from actor order by act_lname;
select count(act_fname),act_fname from actor group by act_fname;

select a.act_fname, a.act_lname, m.role from actor as a
inner join movie_cast as m
on a.act_id = m.act_id;
select act_fname from actor where act_fname like "__a%";
select count(act_id), act_id from actor group by act_id;
select act_id , dense_rank() over(order by act_id) as "dense_rank" from actor;
use world;
select * from city;
select population, ID, sum(population) over(partition by ID order by population) as "total sum" from city;
select population, rank() over(order by population) as "rank" from city;
use movie_database;
show tables;
desc actor;
create table cricket (
team varchar(20));
select * from cricket;
insert into cricket(team)
values ("India"),("Pak"),("Aus"),("Eng");
select * from cricket;
with cte as (
select *, row_number() over(order by team asc) as id
from cricket
  )
  select a.team as "Team -A" , b.team as "Team-B"
  from cte as a
  join cte as b
  on a.team <> b.team
  where a.id < b.id;
  select *, row_number() over(order by team) as id from cricket;
  create table emp(ID int, name varchar(10));
  desc emp;
  insert into emp(ID, name)
  values(1,"Emp1"),(2,"Emp2"),(3,"Emp3"),(4,"Emp4"),(5,"Emp5"),(6,"Emp6"),(7,"Emp7"),(8,"Emp8");
  select * from emp;
  use movie_database;
  create database music_database;
  use music_database;
  select * from album2;
  select * from employee order by levels desc limit 1;
  select * from invoice;
  select count(billing_country), billing_country from invoice group by billing_country order by count(billing_country) desc;
  select total from invoice order by total desc limit 3;
  select * from invoice;
  select sum(total) as invoice_total, billing_city from invoice group by billing_city order by invoice_total desc limit 1;
  use world;
  select * from city;
  select sum(population) as total, district from city group by district order by total desc limit 1;
  select sum(population), district from city group by district;
  use music_database;
  select * from album2;
  select * from employee order by levels desc limit 1;
  select * from invoice;
  select count(billing_country), billing_country from invoice group by billing_country order by count(billing_country) desc limit 1;
  select * from invoice order by total desc limit 3;
  select * from customer;
  select * from invoice;
  select sum(total), billing_city from invoice group by billing_city order by sum(total) desc limit 1;
  select * from customer;
  select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) from customer
  join invoice
  on customer.customer_id = invoice.customer_id
  group by customer.customer_id
  order by sum(invoice.total) desc limit 1;
  select customer.email ,customer.first_name, customer.last_name from customer
  join invoice on customer.customer_id = invoice.customer_id
  join invoice_line on invoice.invoice_id = invoice_line.invoice_id
  where track_id in(
  select track_id from track
  join genre on track.genre_id = genre.genre_id
  where genre.name like "Rock")
  order by email;
  select * from track;
  select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
  from track
  join album2 on album2.album_id = track.album_id
  join artist on artist.artist_id = album2.artist_id
  join genre on genre.genre_id = track.genre_id
  where genre.name like "Rock"
  group by artist.artist_id
  order by number_of_songs desc
  limit 10;
  select * from album2;
  select name, milliseconds from track where milliseconds > (
  select avg(milliseconds) as avg_track_length
  from track)
  order by milliseconds desc;
  with popular_genre as (
  select count(invoice_line.quantity) as purchases, customer.country, genre.name, genre.genre_id,
  row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as rowno
  from invoice_line
  join invoice on invoice.invoice_id = invoice_line.invoice_id
  join customer on customer.customer_id = invoice.customer_id
  join track on track.track_id  = invoice_line.track_id
  join genre on genre.genre_id = track.genre_id
  group by 2,3,4
  order by 2 asc , 1 desc
  )
  select * from popular_genre where rowno <= 1;
  with customer_with_country as (
  select customer.customer_id, first_name, last_name, billing_country, sum(total) as total_spending,
  row_number() over(partition by billing_country order by sum(total) desc) as rowno
  from invoice
  join customer on customer.customer_id = invoice.customer_id
  group by 1,2,3,4
  order by 4 asc,5 desc)
select * from customer_with_country where rowno <= 1;