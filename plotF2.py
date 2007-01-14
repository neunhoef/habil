#!/usr/bin/env python2.4
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=60000),
                             y=graph.axis.linear(min=0,max=3700000))
g.plot(graph.data.file("matmulF2.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/58891209.396419629"))
g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF2_all")
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=10000),
                             y=graph.axis.linear(min=0,max=16000))
g.plot(graph.data.file("matmulF2.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/58891209.396419629"))
g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF2_low")

