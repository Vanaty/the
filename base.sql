DROP DATABASE the;
create database the;
use the ;
create table the_user(
    id int primary key auto_increment,
    nom varchar(50),
    password varchar(50),
    admin int
);
create table the_variete(
    id int primary key auto_increment,
    libelle varchar(50),
    ocupation decimal(10,2),
    rendement decimal(10,2),
    prixVente decimal(10,2) default 0
);
create table the_partielle(
    id int primary key auto_increment,
    surface decimal(10,2)
);
create table the_gestion_partielle(
    id int primary key auto_increment,
    id_partielle int,
    id_variete int,
    FOREIGN KEY (id_partielle) REFERENCES the_partielle(id),
    FOREIGN KEY (id_variete) REFERENCES the_variete(id)
);
create table the_cueilleur(
    id int primary key auto_increment,
    nom varchar(50),
    genre int,
    daty date,
    poidsMin decimal(12,2) default 0
);
create table the_categorie_depense(
    id int primary key auto_increment,
    libelle varchar(50)

);
create table the_cueillette(
    id int primary key auto_increment,
    daty date,
    id_user int,
    id_cueilleur int,
    salaire decimal(17,2) default 0,
    mallus decimal(7,2) default 0,
    bonus decimal(7,2) default 0,
    id_partielle int,
    poids int default 0,
    prix decimal(17,2),
    FOREIGN KEY (id_user) REFERENCES the_user(id),
    FOREIGN KEY (id_cueilleur) REFERENCES the_cueilleur(id),
    FOREIGN KEY (id_partielle) REFERENCES the_partielle(id)
);

create table the_depense(
    id int primary key auto_increment,
    daty date,
    montant decimal(17,2) default 0,
    id_categorie_depense int,
    id_user int,
    FOREIGN KEY (id_user) REFERENCES the_user(id),
    FOREIGN KEY (id_categorie_depense) REFERENCES the_categorie_depense(id)
);

create table the_salaire(
    id int primary key auto_increment,
    montant decimal(17,2) default 0
);

insert into the_user values(default,'rakoto',sha1('rakoto'),1);
insert into the_user values(default,'rasoa',sha1('rasoa'),0);
insert into the_variete values(default,'veromanitra',1.8,100,1000);
insert into the_partielle values(default,1);
insert into the_partielle values(default,2);

insert into  the_gestion_partielle values(default,1,1);
insert into  the_gestion_partielle values(default,2,1);
insert into  the_cueilleur values(default,'narindra',1,'2024-12-01',2);
-- insert into  the_cueillette values(default,'2024-12-01',1,1,100,1,15);
-- insert into  the_cueillette values(default,'2024-11-30',1,1,10,1,15);
-- insert into  the_cueillette values(default,'2024-11-05',1,1,50,1,10);
-- insert into  the_cueillette values(default,'2024-11-05',1,1,12,2,10);

insert into the_categorie_depense values(default,'gasoil');
select * from the_gestion_partielle gp join the_variete v join the_partielle p on gp.id_variete = v.id  and gp.id_partielle = p.id;   
select * from cueillette group by year(daty),month(daty);   

select r.rendement - rep.poids poids,r.id_partielle from (select sum(v.rendement) rendement,gp.id_partielle from the_gestion_partielle gp join the_variete v join the_partielle p on gp.id_variete = v.id  and gp.id_partielle = p.id group by gp.id_partielle) r 
join 
(select * from (select sum(poids) poids,id_partielle,daty from the_cueillette group by year(daty),month(daty),id_partielle) d where year(daty) = year('2024-11-30') AND month('2024-11-30')=month(daty)) rep on r.id_partielle = rep.id_partielle;

select sum(poids) poids,id_partielle from the_cueillette where '2024-10-10' < daty AND daty < '2024-11-30';




create table the_regeneration(
    id int primary key auto_increment,
    mois int
);

insert into the_regeneration(id,mois) values (1,1)
insert into the_regeneration(id,mois) values (2,2)

create table the_penalite(
    id int primary key auto_increment,
    bonus decimal(10,2) default 0,
    mallus decimal(10,2) default 0
);
insert into the_penalite(bonus,mallus) values(10,10);

-- create table the_payement(
--     id int primary key auto_increment,
--     id_cueilleur int,
--     nom varchar(50),
--     mallus decimal(7,2),
--     bonus decimal(7,2),
--     montant decimal(10,2),
--     daty date,
--     FOREIGN KEY (id_cueilleur) REFERENCES the_cueilleur(id)
-- );