Use ig_clone;

/*QUERY 1 IS SCHEMA*/
/*QUERY 2*/
Select id,username,created_at from users order by created_at asc limit 5;
Select id,username,created_at from users order by created_at asc;

/*QUERY 3*/
select username from users
left join photos on users.id=photos.user_id
where photos.id is null;

/*QUERY 4*/
select users.username, photos.id,photos.image_url,count(*) as total_likes
from likes
inner join photos on photos.id=likes.photo_id
inner join users on users.id=likes.photo_id
group by photos.id
order by total_likes desc
limit 1;

/*QUERY 5*/
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2);

/*QUERY 6*/
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
inner join photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC limit 5;

/*QUERY 7*/
SELECT users.id,username, COUNT(users.id) As totallikes_by_user
FROM users
inner join likes ON users.id = likes.user_id
GROUP BY users.id
HAVING totallikes_by_user = (SELECT COUNT(*) FROM photos);


/*QUERY 8*/
Select id,username,created_at from users where monthname(created_at)='may' order by created_at desc limit 5;

/*QUERY 9*/
create view like_table as
(select username from users where id in(select user_id from photos where id in(select photo_id from likes)));

select username from like_table where username regexp '^c'; 

Select users.username,users.id,comments.user_id,comments.photo_id from users inner join comments on
users.id=comments.id  inner join likes on
comments.photo_id=likes.photo_id
where users.username like 'c%';

/*QUERY 10*/
Select username,count(*) from users inner join photos on users.id=photos.user_id group by username
having count(*) between 3 and 5 order by count(*) desc limit 30;





