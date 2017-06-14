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

eldata1 = foreach elidata generate $0,$1,$2,$3,$4,($3-$2)/$2*100;--growth1(2001-2000)/2000*100
eldata2 = foreach eldata1 generate $0,$1,$2,$3,$4,$5,($4-$3)/$3*100;--here gro1 is 5 th col and doing gro2




avrgro = foreach eldata2 generate $0,$1,$2,$3,$4,$5,$6,($5+$6)/2;--avg


fi = filter avrgro by $7>10;
fi1 = filter avrgro by $7<-5;



dump fi1;
