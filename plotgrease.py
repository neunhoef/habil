#!/usr/bin/env python
from pyx import *
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=100),
                             y=graph.axis.linear(min=0,max=50))
ct = {"q":2.0,"d":1.0,"f1":1,"f2":1}

g.plot(graph.data.function("y(x)=x*(q-1)/q*(1+1)",
                           context = ct))
for l in range(1,10):
    ct["l"] = l*1.0
    g.plot(graph.data.function("y(x) = q**l / l - d + x/l + (d-1)*f1",
                               context = ct))
g.writeEPSfile("guck.eps")
