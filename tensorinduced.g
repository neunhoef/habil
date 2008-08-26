gens1 := AtlasGenerators("A5",8).generators;
gens2 := AtlasGenerators("A5",9).generators;
one := gens1[1]^0;
#gens := [KroneckerProduct(gens1[1],one),
#            KroneckerProduct(gens1[2],one),
#            KroneckerProduct(one,gens2[1]),
#            KroneckerProduct(one,gens2[2])];
gens := [KroneckerProduct(gens1[1],one),
            KroneckerProduct(gens1[2],one),
            KroneckerProduct(one,gens1[1]),
            KroneckerProduct(one,gens1[2])];
n := Group(gens);
#Size(n);
#DisplayCompositionSeries(n);
gl := GL(4,4);
no := Normalizer(gl,n);
#Size(no);
nn := NormalSubgroups(no);
ss := List(nn,Size);
pos := Position(ss,7200);
g := nn[pos];
IsNormal(g,n);
# Size(g);
# Size(n);
# now g is (A5 x A5).C2
i := IsomorphismPermGroup(g);
p := Image(i);

# Now we try to construct all tensor induced representations for p!
h := NormalSubgroups(p);
ss := List(h,Size);
pos := Position(ss,3600);
h := h[pos];
nn := NormalSubgroups(h);
ss := List(nn,Size);
pos := Positions(ss,60);
f1 := nn[pos[1]];
f2 := nn[pos[2]];

# Now f1 and f2 are both A5 and h is A5 x A5
# 2-dimensional reps of A5 are:
# the irreducible 2-dimensional reps of A5 x A5 are simply the irreducible
# 2-dimensional reps of both factors with the second factor acting trivially.
irr1 := IrreducibleRepresentations(f1,GF(4));
irr2 := IrreducibleRepresentations(f2,GF(4));
dims1 := List(irr1,x->DimensionOfMatrixGroup(Range(x)));
dims2 := List(irr2,x->DimensionOfMatrixGroup(Range(x)));
f := Filtered([1..4],i->dims1[i]=2);
irr1 := irr1{f};
f := Filtered([1..4],i->dims2[i]=2);
irr2 := irr2{f};

# A very trivial and inefficient hack:
l1 := Elements(f1);
l2 := Elements(f2);
l := [];
ll := [];
for x in l1 do 
  for y in l2 do 
    Add(l,x*y);
    Add(ll,[x,y]);
  od;
od;
SortParallel(l,ll);

flip := [[1,0,0,0],[0,0,1,0],[0,1,0,0],[0,0,0,1]]*Z(2)^0;
ConvertToMatrixRep(flip,4);

TensorInduced := function(rep,H,G,g_2,x)
  # rep a representation of H in form of a GAP function
  # H and index 2 subgroup of G
  # g_2 an element of G\H
  # x an element of g to compute the representation of
  local y,z;
  if x in H then
    y := g_2^-1 * x * g_2;  # this is in H
    return KroneckerProduct(rep(x),rep(y));
  else
    y := g_2^-1 * x;        # this is in H
    z := x * g_2;           # this is in H
    return flip * KroneckerProduct(rep(y),rep(z));
  fi;
end;

rep1 := function(x)
  return ImageElm(irr1[1],ll[Position(l,x)][1]);
end;

rep2 := function(x)
  return ImageElm(irr1[2],ll[Position(l,x)][1]);
end;

rep3 := function(x)
  return ImageElm(irr2[1],ll[Position(l,x)][2]);
end;

rep4 := function(x)
  return ImageElm(irr2[2],ll[Position(l,x)][2]);
end;

repeat
  g_2 := PseudoRandom(p);
until not(g_2 in h);

gens1 := List(GeneratorsOfGroup(p),x->TensorInduced(rep1,h,p,g_2,x));
gens2 := List(GeneratorsOfGroup(p),x->TensorInduced(rep2,h,p,g_2,x));
gens3 := List(GeneratorsOfGroup(p),x->TensorInduced(rep3,h,p,g_2,x));
gens4 := List(GeneratorsOfGroup(p),x->TensorInduced(rep4,h,p,g_2,x));

m := GModuleByMats(GeneratorsOfGroup(g),GF(4));
m1 := GModuleByMats(gens1,GF(4));
m2 := GModuleByMats(gens2,GF(4));
m3 := GModuleByMats(gens3,GF(4));
m4 := GModuleByMats(gens4,GF(4));

MTX.IsAbsolutelyIrreducible(m);
MTX.Homomorphisms(m,m1);
MTX.Homomorphisms(m,m2);
MTX.Homomorphisms(m,m3);
MTX.Homomorphisms(m,m4);

