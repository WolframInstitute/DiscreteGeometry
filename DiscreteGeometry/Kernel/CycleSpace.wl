Package["WolframInstitute`DiscreteGeometry`"]

PackageExport[FindIndecomposableCycles]


(* ===================== Indecomposable cycles ===================== *)

(* A cycle is indecomposable when it is not a sum mod 2 of strictly shorter cycles: the relevant cycles of Vismara (1997),
   the union of all minimum cycle bases. Lengths go up from the girth; an l-cycle is kept iff its edge vector is not in the
   GF(2) span of the shorter kept cycles, which is tested against the reduced row echelon basis by subtracting the pivot
   rows at once; the search stops when the span is the whole cycle space, of dimension E - V + c. *)
FindIndecomposableCycles[ graph_ ? GraphQ ] :=
  With[
    { edgeIndex = PositionIndex[ Sort /@ List @@@ EdgeList @ graph ], edgeCount = EdgeCount @ graph },
    { cyclomatic = edgeCount - VertexCount @ graph + Length @ ConnectedComponents @ graph,
      vector = cycle |-> Normal @ SparseArray[ Thread[ Lookup[ edgeIndex, Sort /@ List @@@ cycle ][[ All, 1 ]] -> 1 ], edgeCount ] },
    { step = { length, basis, found } |->
        With[
          { candidates = FindCycle[ graph, { length }, All ] },
          { vectors = vector /@ candidates },
          { residues = Which[
              candidates === { }, { },
              basis === { }, vectors,
              True, Mod[ vectors - vectors[[ All, Flatten[ FirstPosition[ #, 1 ] & /@ basis ] ]] . basis, 2 ] ] },
          { kept = Pick[ candidates, Positive @ Total[ residues, { 2 } ] ] },
          { length + 1, If[ kept === { }, basis, DeleteCases[ RowReduce[ Join[ basis, vector /@ kept ], Modulus -> 2 ], { 0 .. } ] ], Join[ found, kept ] } ] },
    Last @ NestWhile[ Apply @ step, { 3, { }, { } }, Length @ #[[ 2 ]] < cyclomatic && #[[ 1 ]] <= edgeCount & ]
  ]
