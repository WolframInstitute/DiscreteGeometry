Package["WolframInstitute`DiscreteGeometry`"]

PackageExport[ChainComplex]
PackageExport[CochainComplex]
PackageExport[ChainComplexQ]
PackageExport[BoundaryMap]
PackageExport[Homology]
PackageExport[HomologyGroups]
PackageExport[HomologyRank]
PackageExport[BettiNumbers]
PackageExport[ReducedHomology]


(* ===================== Chain complex ===================== *)

(* the simplicial chain complex: C_k has the sorted k-simplices of the closure as basis, in canonical order,
   and d_k sigma = Sum_i (-1)^i (sigma without its i-th vertex) *)
ChainComplex[ complex : { __ ? VectorQ } ] :=
  With[
    { closure = ComplexClosure @ complex },
    { top = Max[ Length /@ closure ] - 1 },
    { bases = Table[ Select[ closure, Length[ # ] == k + 1 & ], { k, 0, Max[ top, 1 ] } ] },
    ChainComplex @ Table[
      With[
        { faces = bases[[ k ]], simplices = bases[[ k + 1 ]] },
        { faceIndex = AssociationThread[ faces -> Range @ Length @ faces ] },
        SparseArray[
          Flatten @ Table[ { faceIndex[ Delete[ simplices[[ j ]], i ] ], j } -> (-1)^(i - 1), { j, Length @ simplices }, { i, k + 1 } ],
          { Length @ faces, Length @ simplices } ] ],
      { k, Max[ top, 1 ] } ]
  ]

(* the clique complex, on the vertices renumbered in VertexList order *)
ChainComplex[ graph_Graph ] :=
  ChainComplex @ GraphComplex @ IndexGraph @ graph

(* the normalized chain complex: the nondegenerate simplices, d_k = Sum_i (-1)^i d^k_i restricted to them;
   a 0 x n matrix does not exist, so an empty level below a nonempty one leaves the call unevaluated *)
ChainComplex[ SimplicialData[ dimensions_List, faceBlocks : { __List }, degeneracyBlocks_List ] ] :=
  With[
    { nondegenerate = Prepend[
        MapThread[ { degeneracies, size } |-> Complement[ Range @ size, Flatten @ SparseArray[ Total[ Total @ degeneracies, { 2 } ] ][ "NonzeroPositions" ] ],
          { degeneracyBlocks, Rest @ dimensions } ],
        Range @ First @ dimensions ] },
    { levels = Take[ nondegenerate, Max @ Position[ nondegenerate, Except[ { } ], { 1 }, Heads -> False ] ] },
    ChainComplex @ MapThread[
      { faces, rows, columns } |-> Total[ (-1)^Range[ 0, Length @ faces - 1 ] faces ][[ rows, columns ]],
      { Take[ faceBlocks, Length @ levels - 1 ], Most @ levels, Rest @ levels } ] /;
      FreeQ[ levels, { } ] && Length @ levels > 1
  ]

ChainComplex[ boundaries_List ][ "BoundaryMatrices" ] := boundaries

ChainComplex[ boundaries_List ][ "Length" ] := Length @ boundaries

ChainComplex[ boundaries : { __ ? MatrixQ } ][ "Dimensions" ] := Prepend[ Last /@ Dimensions /@ boundaries, First @ Dimensions @ First @ boundaries ]

ChainComplex[ boundaries_List ][ "Properties" ] := { "BoundaryMatrices", "Length", "Dimensions", "Properties" }


(* the dual complex: d^k = Transpose[ d_(k+1) ] : C^k -> C^(k+1) *)
CochainComplex[ ChainComplex[ boundaries_List ] ] :=
  CochainComplex[ Transpose /@ boundaries ]

CochainComplex[ complex : { __ ? VectorQ } | _Graph | _SimplicialData ] :=
  CochainComplex @ ChainComplex @ complex

CochainComplex[ coboundaries_List ][ "CoboundaryMatrices" ] := coboundaries

CochainComplex[ coboundaries_List ][ "Length" ] := Length @ coboundaries

CochainComplex[ coboundaries_List ][ "Properties" ] := { "CoboundaryMatrices", "Length", "Properties" }


(* d_(k-1) . d_k = 0 with compatible dimensions *)
ChainComplexQ[ ChainComplex[ boundaries : { __ ? MatrixQ } ] ] :=
  AllTrue[
    Partition[ boundaries, 2, 1 ],
    Apply[ { lower, upper } |->
      Last @ Dimensions @ lower == First @ Dimensions @ upper &&
        ( Min[ Dimensions @ lower, Dimensions @ upper ] == 0 || Chop @ Norm[ Flatten[ lower . upper ], Infinity ] == 0 ) ] ]

ChainComplexQ[ _ ] := False


(* d_n : C_n -> C_(n-1), 1-indexed; d^n : C^n -> C^(n+1), 0-indexed *)
BoundaryMap[ ChainComplex[ boundaries : { __ ? MatrixQ } ], n_Integer ] /; 1 <= n <= Length @ boundaries :=
  boundaries[[ n ]]

BoundaryMap[ CochainComplex[ coboundaries : { __ ? MatrixQ } ], n_Integer ] /; 0 <= n < Length @ coboundaries :=
  coboundaries[[ n + 1 ]]


(* ===================== Homology ===================== *)

(* b_k = dim C_k - rank d_k - rank d_(k+1); the torsion of H_k is the invariant factors > 1 of d_(k+1) *)
HomologyGroups[ cc : ChainComplex[ boundaries : { __ ? MatrixQ } ] ] :=
  AssociationThread[
    Range[ 0, Length @ boundaries ] ->
      Transpose[ { BettiNumbers @ cc, Append[ invariantFactors /@ boundaries, { } ] } ] ]

BettiNumbers[ cc : ChainComplex[ boundaries : { __ ? MatrixQ } ] ] :=
  With[
    { ranks = Join[ { 0 }, matrixRank /@ boundaries, { 0 } ] },
    cc[ "Dimensions" ] - Most @ ranks - Rest @ ranks
  ]

HomologyRank[ cc : ChainComplex[ { __ ? MatrixQ } ], n_Integer ? NonNegative ] :=
  PadRight[ BettiNumbers @ cc, n + 1 ][[ n + 1 ]]

(* H_n as the pair { rank, torsion coefficients }: Z^rank (+) Z/t_1 (+) ... *)
Homology[ cc : ChainComplex[ { __ ? MatrixQ } ], n_Integer ? NonNegative ] :=
  Lookup[ HomologyGroups @ cc, n, { 0, { } } ]

(* the augmentation C_0 -> Z removes one free summand from H_0 *)
ReducedHomology[ cc : ChainComplex[ { __ ? MatrixQ } ] ] :=
  MapAt[ { First[ # ] - 1, Last[ # ] } &, HomologyGroups @ cc, Key[ 0 ] ]

Scan[
  reader |-> ( reader[ complex : { __ ? VectorQ } | _Graph | _SimplicialData, arguments___ ] := reader[ ChainComplex @ complex, arguments ] ),
  { BoundaryMap, Homology, HomologyGroups, HomologyRank, BettiNumbers, ReducedHomology } ]


matrixRank[ matrix_ ] :=
  If[ Min @ Dimensions @ matrix == 0, 0, MatrixRank @ matrix ]

invariantFactors[ matrix_ ] :=
  If[ Min @ Dimensions @ matrix == 0, { }, Select[ Abs @ Diagonal @ SmithDecomposition[ Normal @ matrix ][[ 2 ]], # > 1 & ] ]
