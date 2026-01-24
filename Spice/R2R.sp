* C:\Users\Wyatt\Documents\School\SENIOR PROJECT\Spice\R2R.asc
m1 n015 b0 0 0 sky130_fd_pr__nfet_01v8
m2 n015 b0 1.8v 1.8v sky130_fd_pr__pfet_01v8
m3 n016 b1 0 0 sky130_fd_pr__nfet_01v8
m4 n016 b1 1.8v 1.8v sky130_fd_pr__pfet_01v8
m5 n017 b2 0 0 sky130_fd_pr__nfet_01v8
m6 n017 b2 1.8v 1.8v sky130_fd_pr__pfet_01v8
m7 n024 b9 0 0 sky130_fd_pr__nfet_01v8
m8 n024 b9 1.8v 1.8v sky130_fd_pr__pfet_01v8
m9 n025 b10 0 0 sky130_fd_pr__nfet_01v8
m10 n025 b10 1.8v 1.8v sky130_fd_pr__pfet_01v8
m12 n026 b11 1.8v 1.8v sky130_fd_pr__pfet_01v8
m13 n018 b3 0 0 sky130_fd_pr__nfet_01v8
m14 n018 b3 1.8v 1.8v sky130_fd_pr__pfet_01v8
m15 n019 b4 0 0 sky130_fd_pr__nfet_01v8
m16 n019 b4 1.8v 1.8v sky130_fd_pr__pfet_01v8
m17 n020 b5 0 0 sky130_fd_pr__nfet_01v8
m18 n020 b5 1.8v 1.8v sky130_fd_pr__pfet_01v8
m19 n021 b6 0 0 sky130_fd_pr__nfet_01v8
m20 n021 b6 1.8v 1.8v sky130_fd_pr__pfet_01v8
m21 n022 b7 0 0 sky130_fd_pr__nfet_01v8
m22 n022 b7 1.8v 1.8v sky130_fd_pr__pfet_01v8
m23 n023 b8 0 0 sky130_fd_pr__nfet_01v8
m24 n023 b8 1.8v 1.8v sky130_fd_pr__pfet_01v8
v1 1.8v 0 1.8
v2 b0 0 pulse(0 3.3 0 1n 1n 0.5u 1u)
v3 b1 0 pulse(0 3.3 0 1n 1n 1u 2u)
v4 b2 0 pulse(0 3.3 0 1n 1n 2u 4u)
v5 b3 0 pulse(0 3.3 0 1n 1n 4u 8u)
v6 b4 0 pulse(0 3.3 0 1n 1n 8u 16u)
v7 b5 0 pulse(0 3.3 0 1n 1n 16u 32u)
v8 b6 0 pulse(0 3.3 0 1n 1n 32u 64u)
v9 b7 0 pulse(0 3.3 0 1n 1n 64u 128u)
v10 b8 0 pulse(0 3.3 0 1n 1n 128u 256u)
v11 b9 0 pulse(0 3.3 0 1n 1n 256u 512u)
v12 b10 0 pulse(0 3.3 0 1n 1n 512u 1024u)
v13 b11 0 pulse(0 3.3 0 1n 1n 1024u 2048u)
m25 3v n013 n014 n014 sky130_fd_pr__nfet_01v8
m26 0 n013 n001 n001 sky130_fd_pr__pfet_01v8
m27 3v n001 v0 v0 sky130_fd_pr__nfet_01v8
r25 n014 0 {mc(1Meg, tol)}
r26 3v n001 {mc(1Meg, tol)}
m28 0 n014 v0 v0 sky130_fd_pr__pfet_01v8
v14 3v 0 3.3
r24 n003 n002 {mc(10k, tol)}
m11 n026 b11 0 0 sky130_fd_pr__nfet_01v8
r21 n002 0 {mc(20k, tol)} 
r20 n002 n015 {mc(20k, tol)}
r1 n003 n016 {mc(20k, tol)}
r2 n004 n017 {mc(20k, tol)} 
r3 n005 n018 {mc(20k, tol)} 
r4 n006 n019 {mc(20k, tol)} 
r7 n007 n020 {mc(20k, tol)} 
r8 n008 n021 {mc(20k, tol)} 
r9 n009 n022 {mc(20k, tol)}
r10 n010 n023 {mc(20k, tol)}
r14 n011 n024 {mc(20k, tol)}
r15 n012 n025 {mc(20k, tol)}
r19 n013 n026 {mc(20k, tol)}
r5 n004 n003 {mc(10k, tol)}
r6 n005 n004 {mc(10k, tol)}
r11 n006 n005 {mc(10k, tol)}
r12 n007 n006 {mc(10k, tol)}
r13 n008 n007 {mc(10k, tol)}
r16 n009 n008 {mc(10k, tol)}
r17 n010 n009 {mc(10k, tol)} 
r18 n011 n010 {mc(10k, tol)}
r22 n012 n011 {mc(10k, tol)}
r23 n013 n012 {mc(10k, tol)}
.model sky130_fd_pr__pfet_01v8 pmos(l=0.15 w=2 nf=1 ad=0.58 as=0.87 pd=4.58 ps=6.87 nrd=0.145 nrs=0.145 sa=0 sb=0 sd=0 mult=1 m=1)
.model sky130_fd_pr__nfet_01v8 nmos(l=0.15 w=1 nf=1 ad=0.29 as=0.435 pd=2.58 ps=3.87 nrd=0.29 nrs=0.29 sa=0 sb=0 sd=0 mult=1 m=1)
.tran 2.05m
.meas TRAN Voutavg RMS (V(V0))
.meas TRAN Voutmax MAX (V(V0))
.meas TRAN Voutmin MIN (V(V0))
.param tol 0.01
.step param run 0 9 1
.step param temp 0 100 10
.end
