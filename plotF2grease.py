#!/usr/bin/env python2.4
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=5000),
                             y=graph.axis.linear(min=0,max=2300))
g.plot(graph.data.file("matmulF2grease.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/58920575.06481263"))
g.plot(graph.data.file("matmulF2grease.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF2grease.dat",x="4*$1",y="49*$2"))
g.writeEPSfile("matmulF2grease")
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=2500),
                             y=graph.axis.linear(min=0,max=300))
g.plot(graph.data.file("matmulF2grease.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/58920575.06481263"))
g.plot(graph.data.file("matmulF2grease.dat",x="2*$1",y="7*$2"))
g.plot(graph.data.file("matmulF2grease.dat",x="4*$1",y="49*$2"))
g.writeEPSfile("matmulF2grease_scaled")
