#!/usr/bin/env python
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=20000),
                             y=graph.axis.linear(min=0,max=1800000))
g.plot(graph.data.file("matmulF7.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/4976455.1465877071"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF7_all")
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=10000),
                             y=graph.axis.linear(min=0,max=250000))
g.plot(graph.data.file("matmulF7.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/4976455.1465877071"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF7.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF7_low")

