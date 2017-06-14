a1 = load '2000.txt' using PigStorage(',') as (catid,cname:chararray,m1:double,m2:double,m3:double,m4:double,m5:double,
m6:double,m7:double,m8:double,m9:double,m10:double,m11:double,m12:double);

a2 = load '2001.txt' using PigStorage(',') as (catid,cname:chararray,m1:double,m2:double,m3:double,m4:double,m5:double,
m6:double,m7:double,m8:double,m9:double,m10:double,m11:double,m12:double);

a3 = load '2002.txt' using PigStorage(',') as (catid,cname:chararray,m1:double,m2:double,m3:double,m4:double,m5:double,
m6:double,m7:double,m8:double,m9:double,m10:double,m11:double,m12:double);



redua1 = foreach a1 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$12+$13);

redua2 = foreach a2 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$12+$13);

redua3 = foreach a3 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$12+$13);


joindata = join redua1 by $0,redua2 by $0,redua3 by $0;--8col

elidata = foreach joindata generate $0,$1,$2,$5,$8;--5col

sumdt = foreach elidata generate $0,$1,($2+$3+$4);

odrdt = order sumdt by $2 desc;


--btdt = order sumdt by $2;
tpdt = limit odrdt 5;

dump tpdt;
