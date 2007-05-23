#!/usr/bin/env python2.4
from pyx import *
#g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=10000),
#                             y=graph.axis.linear(min=0,max=11000),
#                             key=graph.key.key(pos="br", dist=0.1))
g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=21000),
                             y=graph.axis.linear(min=0,max=800000))
#g.plot([graph.data.file("matmulF2wino0.dat",x=1,y=2,title="Winograd 0"),
#        graph.data.file("matmulF2wino1.dat",x=1,y=2,title="Winograd 1"),
#        graph.data.file("matmulF2wino2.dat",x=1,y=2,title="Winograd 2"),
#        graph.data.file("matmulF2wino3.dat",x=1,y=2,title="Winograd 3")])
g.plot(graph.data.file("matmulF3.dat",x=1,y=2))
g.plot(graph.data.function("y(x)=x**3/10998680.158380995"))
#g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="7*$2"))
#g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="8*$2"))
g.writeEPSfile("matmulF3_all")
#g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=10000),
#                             y=graph.axis.linear(min=0,max=12000))
#g.plot(graph.data.file("matmulF2.dat",x=1,y=2))
#g.plot(graph.data.function("y(x)=x**3/97139773.340528876"))
#g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="7*$2"))
#g.plot(graph.data.file("matmulF2.dat",x="2*$1",y="8*$2"))
#g.writeEPSfile("matmulF2_low")

#g = graph.graphxy(width = 14,x=graph.axis.linear(min=0,max=10000),
#                             y=graph.axis.linear(min=0,max=100000),
#                             key=graph.key.key(pos="br", dist=0.1))
#g.plot([graph.data.file("matmulF3wino0.dat",x=1,y=2,title="Winograd 0"),
#        graph.data.file("matmulF3wino1.dat",x=1,y=2,title="Winograd 1"),
#        graph.data.file("matmulF3wino2.dat",x=1,y=2,title="Winograd 2"),
#        graph.data.file("matmulF3wino3.dat",x=1,y=2,title="Winograd 3")])
#g.writeEPSfile("matmulF3_all")
