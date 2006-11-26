#
# This file tests the speed of vector additions over finite fields in GAP.
# Please start this file with at least 1000MB of memory, and check,
# that no garbage collections occur:
#
#   gap -m 1000m -g -g speedtest.g
#
# Do not run other jobs on the same machine at the same time to avoid
# spoiling the results by cache issues!
#

LoadPackage("cvec");

InstallOtherMethod(BaseDomain,[IsGF2VectorRep],function(v) return GF(2); end);
InstallOtherMethod(BaseDomain,[Is8BitVectorRep],
  function(v) return GF(Q_VEC8BIT(v)); end);

FastRandomize := function(v)
  local f,l,i;
  Print("Randomizing vector...\n");
  f := BaseDomain(v);
  l := Elements(f);
  for i in [1..1000] do
      v[i] := Random(l);
  od;
  for i in [1001,2001..Length(v)-999] do
      CopySubVector(v,v,[1..1000],[i..i+999]);
  od;
  Print("Done.\n");
end;

Evaluate := function(v,nr,t1,t2,t3,readfactor)
  local mem,total,totalr,totalw,t;
  Print("Done, total times: ",t2-t1," ms and ",t3-t2," ms\n");
  t := QuoInt(t3-t1,2);   # Take the average of both timings
  if AbsInt((t3-t2) - (t2-t1)) * 100 > t then
      Print("WARNING: Both timings differ by more than 1%!\n");
  fi;
  if t < 100 then
      Print("WARNING: Error could be more than 1%!\n");
  fi;
  if IsCVecRep(v) then
      mem := nr * (SHALLOW_SIZE(v)-GAPInfo.BytesPerVariable);
  elif IsGF2VectorRep(v) then
      mem := nr * (SHALLOW_SIZE(v)-2*GAPInfo.BytesPerVariable);
  else
      mem := nr * (SHALLOW_SIZE(v)-3*GAPInfo.BytesPerVariable);
  fi;
  Print("Vectors use ",mem/nr," bytes each.\n");
  Print("Total memory read: ",2*mem,", total memory written: ",mem,"\n");
  # We compute the total amount of memory read and written in 1s:
  totalr := QuoInt(readfactor*mem*1000,t);
  totalw := QuoInt(mem*1000,t);
  total := totalr + totalw;
  # Transform into MB:
  totalr := QuoInt(totalr,1024*1024);
  totalw := QuoInt(totalw,1024*1024);
  total := QuoInt(total,1024*1024);
  
  Print("Throughput:   ",String(totalr,5)," MB/s read\n",
        "            + ",String(totalw,5)," MB/s written\n",
        "            = ",String(total,5)," MB/s memory access\n\n");
end;

TestADD2 := function(v,w,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing ADD2 over ",BaseDomain(v),"...\n");
  t1 := Runtime();
  for i in [1..nr] do CVEC_ADD2(v,w,0,0); od;
  t2 := Runtime();
  for i in [1..nr] do CVEC_ADD2(v,w,0,0); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,2);
end;

TestADD3 := function(v,w,z,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing ADD3 over ",BaseDomain(v),"...\n");
  t1 := Runtime();
  for i in [1..nr] do CVEC_ADD3(z,v,w); od;
  t2 := Runtime();
  for i in [1..nr] do CVEC_ADD3(z,v,w); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,2);
end;

TestGF2 := function(v,w,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing ADDCOEFFS_GF2VEC_GF2VEC over GF(2)...\n");
  t1 := Runtime();
  for i in [1..nr] do ADDCOEFFS_GF2VEC_GF2VEC(v,w); od;
  t2 := Runtime();
  for i in [1..nr] do ADDCOEFFS_GF2VEC_GF2VEC(v,w); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,2);
end;

Test8bit := function(v,w,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing ADD_ROWVECTOR_VEC8BITS_2 over ",BaseDomain(v),"\n");
  t1 := Runtime();
  for i in [1..nr] do ADD_ROWVECTOR_VEC8BITS_2(v,w); od;
  t2 := Runtime();
  for i in [1..nr] do ADD_ROWVECTOR_VEC8BITS_2(v,w); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,2);
end;

TestMUL1 := function(v,s,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing MUL1 over ",BaseDomain(v),"...\n");
  t1 := Runtime();
  for i in [1..nr] do CVEC_MUL1(v,s,0,0); od;
  t2 := Runtime();
  for i in [1..nr] do CVEC_MUL1(v,s,0,0); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,1);
end;

TestMULTROWVECTOR := function(v,s,nr)
  local t1,t2,t3,i;

  GASMAN("collect");
  Print("Testing MULT_ROWVECTOR_VEC8BITS over ",BaseDomain(v),"\n");
  t1 := Runtime();
  for i in [1..nr] do MULT_ROWVECTOR_VEC8BITS(v,s); od;
  t2 := Runtime();
  for i in [1..nr] do MULT_ROWVECTOR_VEC8BITS(v,s); od;
  t3 := Runtime();
  Evaluate(v,nr,t1,t2,t3,1);
end;

Print("Testing cvecs...\n\n");

# First vectors over GF(2) that use 32000000 bytes each:
cl := CVEC_NewCVecClass(2,1,256000000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,500);
TestADD2(v,w,500);

# Now vectors over GF(2) that use 125000 bytes each:
cl := CVEC_NewCVecClass(2,1,1000000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,500000);
TestADD2(v,w,500000);

# Now vectors over GF(2) that use 62500 bytes each:
cl := CVEC_NewCVecClass(2,1,500000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,1000000);
TestADD2(v,w,1000000);

# Then vectors over GF(7) that use 32000000 bytes each:
cl := CVEC_NewCVecClass(7,1,64000000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,500);
TestADD2(v,w,500);
TestMUL1(w,6*Z(7)^0);

# Now vectors over GF(7) that use 125000 bytes each:
cl := CVEC_NewCVecClass(7,1,250000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,500000);
TestADD2(v,w,500000);
TestMUL1(w,6*Z(7)^0,500000);

# Now vectors over GF(7) that use 62500 bytes each:
cl := CVEC_NewCVecClass(7,1,125000);
v := CVEC_New(cl); FastRandomize(v);
w := CVEC_New(cl); FastRandomize(w);
z := CVEC_New(cl);
TestADD3(v,w,z,1000000);
TestADD2(v,w,1000000);
TestMUL1(w,6*Z(7)^0,1000000);

# Now the other compressed vectors:

Print("Testing standard compressed vectors...\n\n");

# First vectors over GF(2) that use 32000000 bytes each:
v := [0*Z(2)]; ConvertToVectorRep(v,2); RESIZE_GF2VEC(v,256000000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
TestGF2(v,w,500);

# Now vectors over GF(2) that use 125000 bytes each:
v := [0*Z(2)]; ConvertToVectorRep(v,2); RESIZE_GF2VEC(v,1000000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
TestGF2(v,w,500000);

# Now vectors over GF(2) that use 62500 bytes each:
v := [0*Z(2)]; ConvertToVectorRep(v,2); RESIZE_GF2VEC(v,500000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
TestGF2(v,w,1000000);

# Then vectors over GF(7) that use 32000000 bytes each:
v := [0*Z(7)]; ConvertToVectorRep(v,7); RESIZE_VEC8BIT(v,64000000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
Test8bit(v,w,500);
TestMULTROWVECTOR(w,6*Z(7)^0,500);

# Now vectors over GF(7) that use 125000 bytes each:
v := [0*Z(7)]; ConvertToVectorRep(v,7); RESIZE_VEC8BIT(v,250000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
Test8bit(v,w,500000);
TestMULTROWVECTOR(w,6*Z(7)^0,500000);

# Now vectors over GF(7) that use 62500 bytes each:
v := [0*Z(7)]; ConvertToVectorRep(v,7); RESIZE_VEC8BIT(v,125000);
w := ShallowCopy(v);
z := ShallowCopy(v);
FastRandomize(v);
FastRandomize(w);
Test8bit(v,w,1000000);
TestMULTROWVECTOR(w,6*Z(7)^0,1000000);

