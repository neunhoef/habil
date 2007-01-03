#!/usr/bin/env python2.4
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=30000),
                             y=graph.axis.linear(min=0,max=2700000))
g.plot(graph.data.file("matmulF7.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/10047259.3309"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF7_all")
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=15000),
                             y=graph.axis.linear(min=0,max=350000))
g.plot(graph.data.file("matmulF7.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/10047269.3309"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF7_low")

