#!/usr/bin/env python
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=2000),
                             y=graph.axis.linear(min=0,max=5000))
g.plot(graph.data.file("matmulF17.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/1702127.6595744682"))
g.plot(graph.data.file("matmulF17.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF17.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF17_all")
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=1000),
                             y=graph.axis.linear(min=0,max=700))
g.plot(graph.data.file("matmulF17.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/1702127.6595744682"))
g.plot(graph.data.file("matmulF17.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF17.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF17_low")

