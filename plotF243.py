#!/usr/bin/env python2.4
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=20000),
                             y=graph.axis.linear(min=0,max=500000))
g.plot(graph.data.file("matmulF243.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/23306152.532941788"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF243_all")
