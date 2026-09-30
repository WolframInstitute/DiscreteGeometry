BeginTestSection["ChainComplexTests"]

(* ===== Fixtures ===== *)

triangulatedTorus[ n_ ] := Graph @ Flatten @ Table[
  { { i, j } <-> { Mod[ i + 1, n ], j }, { i, j } <-> { i, Mod[ j + 1, n ] }, { i, j } <-> { Mod[ i + 1, n ], Mod[ j + 1, n ] } },
  { i, 0, n - 1 }, { j, 0, n - 1 } ]

projectivePlane = { { 1, 2, 3 }, { 1, 3, 4 }, { 1, 4, 5 }, { 1, 5, 6 }, { 1, 2, 6 }, { 2, 3, 5 }, { 2, 4, 5 }, { 2, 4, 6 }, { 3, 4, 6 }, { 3, 5, 6 } }

eulerPoincareQ[ cc_ ] := With[ { signs = (-1)^Range[ 0, cc[ "Length" ] ] }, signs . BettiNumbers[ cc ] == signs . cc[ "Dimensions" ] ]


(* ===== d_(k-1) . d_k = 0 ===== *)

VerificationTest[
  ChainComplexQ /@ ChainComplex /@ { CycleGraph[ 6 ], TorusGraph[ { 4, 4 } ], CompleteGraph[ 4 ], triangulatedTorus[ 4 ], PetersenGraph[ ] },
  { True, True, True, True, True },
  TestID -> "ChainComplexQ-CliqueComplexes"
]

VerificationTest[
  ChainComplexQ @ ChainComplex @ ComplexClosure @ projectivePlane,
  True,
  TestID -> "ChainComplexQ-ProjectivePlane"
]

VerificationTest[
  ChainComplexQ @ ChainComplex[ { { { 1, 1 } }, { { 1 }, { 1 } } } ],
  False,
  TestID -> "ChainComplexQ-SquareNonzero"
]

VerificationTest[
  ChainComplexQ @ ChainComplex[ { { { 1, -1 } }, { { 1 }, { 1 } } } ],
  True,
  TestID -> "ChainComplexQ-AbstractComplex"
]

VerificationTest[
  AllTrue[ ChainComplex[ triangulatedTorus[ 4 ] ][ "BoundaryMatrices" ], MatchQ[ #, _SparseArray ] & ],
  True,
  TestID -> "ChainComplex-Sparse"
]


(* ===== Boundary maps ===== *)

(* d_1 {a, b} = b - a and d_2 {1, 2, 3} = {2, 3} - {1, 3} + {1, 2} *)
VerificationTest[
  Normal /@ { BoundaryMap[ { { 1, 2, 3 } }, 1 ], BoundaryMap[ { { 1, 2, 3 } }, 2 ] },
  { { { -1, -1, 0 }, { 1, 0, -1 }, { 0, 1, 1 } }, { { 1 }, { -1 }, { 1 } } },
  TestID -> "BoundaryMap-Triangle"
]

VerificationTest[
  With[ { tetrahedron = ComplexClosure[ { { 1, 2, 3, 4 } } ] },
    Table[ BoundaryMap[ tetrahedron, n ] == Transpose @ ComplexIncidenceMatrix[ tetrahedron, n - 1 ], { n, 3 } ] ],
  { True, True, True },
  TestID -> "BoundaryMap-IncidenceMatrixTranspose"
]

VerificationTest[
  With[ { cc = ChainComplex @ CompleteGraph[ 4 ] },
    Table[ BoundaryMap[ CochainComplex @ cc, k ] == Transpose @ BoundaryMap[ cc, k + 1 ], { k, 0, 2 } ] ],
  { True, True, True },
  TestID -> "CochainComplex-Transpose"
]

VerificationTest[
  With[ { cochains = CochainComplex @ triangulatedTorus[ 4 ] },
    Normal[ BoundaryMap[ cochains, 1 ] . BoundaryMap[ cochains, 0 ] ] == ConstantArray[ 0, { 32, 16 } ] ],
  True,
  TestID -> "CochainComplex-SquareZero"
]


(* ===== Betti numbers ===== *)

VerificationTest[
  BettiNumbers @ CycleGraph[ 6 ],
  { 1, 1 },
  TestID -> "BettiNumbers-Circle"
]

(* the square grid on the torus has no triangles: its clique complex is the graph, b_1 = E - V + 1 *)
VerificationTest[
  BettiNumbers @ TorusGraph[ { 4, 4 } ],
  { 1, 17 },
  TestID -> "BettiNumbers-TorusGraph"
]

VerificationTest[
  BettiNumbers @ triangulatedTorus[ 4 ],
  { 1, 2, 1 },
  TestID -> "BettiNumbers-TriangulatedTorus"
]

VerificationTest[
  BettiNumbers @ CompleteGraph[ 4 ],
  { 1, 0, 0, 0 },
  TestID -> "BettiNumbers-Tetrahedron"
]

VerificationTest[
  BettiNumbers @ GraphComplex[ CompleteGraph[ 4 ], 3 ],
  { 1, 0, 1 },
  TestID -> "BettiNumbers-TetrahedronBoundary"
]

VerificationTest[
  BettiNumbers @ ChainComplex[ { { { 1, -1 } } } ],
  { 0, 1 },
  TestID -> "BettiNumbers-AbstractComplex"
]

VerificationTest[
  BettiNumbers @ VietorisRipsComplex[ CirclePoints[ 8 ], 0.8 ],
  { 1, 1 },
  TestID -> "BettiNumbers-VietorisRips"
]

VerificationTest[
  eulerPoincareQ /@ ChainComplex /@ { CycleGraph[ 6 ], TorusGraph[ { 4, 4 } ], triangulatedTorus[ 5 ], PetersenGraph[ ], ComplexClosure @ projectivePlane },
  { True, True, True, True, True },
  TestID -> "BettiNumbers-EulerPoincare"
]

VerificationTest[
  BettiNumbers @ triangulatedTorus[ 4 ] == BettiNumbers @ VertexReplace[ triangulatedTorus[ 4 ], { i_, j_ } :> 10 j + i ],
  True,
  TestID -> "BettiNumbers-RelabellingInvariant"
]

VerificationTest[
  With[ { cc = ChainComplex @ triangulatedTorus[ 4 ] }, Table[ HomologyRank[ cc, k ], { k, 0, 4 } ] ],
  { 1, 2, 1, 0, 0 },
  TestID -> "HomologyRank-Torus"
]


(* ===== Integral homology ===== *)

VerificationTest[
  HomologyGroups @ projectivePlane,
  <| 0 -> { 1, { } }, 1 -> { 0, { 2 } }, 2 -> { 0, { } } |>,
  TestID -> "HomologyGroups-ProjectivePlane"
]

VerificationTest[
  Homology[ projectivePlane, 1 ],
  { 0, { 2 } },
  TestID -> "Homology-ProjectivePlane"
]

VerificationTest[
  HomologyGroups @ triangulatedTorus[ 4 ],
  <| 0 -> { 1, { } }, 1 -> { 2, { } }, 2 -> { 1, { } } |>,
  TestID -> "HomologyGroups-TorusTorsionFree"
]

VerificationTest[
  ReducedHomology @ CompleteGraph[ 4 ],
  <| 0 -> { 0, { } }, 1 -> { 0, { } }, 2 -> { 0, { } }, 3 -> { 0, { } } |>,
  TestID -> "ReducedHomology-Contractible"
]

VerificationTest[
  ReducedHomology @ GraphComplex[ CompleteGraph[ 4 ], 3 ],
  <| 0 -> { 0, { } }, 1 -> { 0, { } }, 2 -> { 1, { } } |>,
  TestID -> "ReducedHomology-Sphere"
]


(* ===== Simplicial sets ===== *)

VerificationTest[
  BettiNumbers @ SimplicialSet[ { { 1, 2, 3 } } ],
  BettiNumbers @ { { 1, 2, 3 } },
  TestID -> "SimplicialSet-Simplex"
]

(* one vertex and one loop, as a Delta-complex: d = d_0 - d_1 = 0 *)
VerificationTest[
  BettiNumbers @ SimplicialSet[ { { 1, 1 } }, "IncludeDegeneracies" -> False ],
  { 1, 1 },
  TestID -> "SimplicialSet-Circle"
]

(* the normalized complex drops the degenerate edge {1, 1} and the degenerate triangle {1, 1, 2}: an interval *)
VerificationTest[
  BettiNumbers @ SimplicialSet[ { { 1, 1, 2 } } ],
  { 1, 0 },
  TestID -> "SimplicialSet-NormalizedInterval"
]

VerificationTest[
  ChainComplexQ @ ChainComplex @ SimplicialSet[ { { 1, 2, 3, 4 }, { 1, 1, 2 } } ],
  True,
  TestID -> "SimplicialSet-SquareZero"
]

EndTestSection[]
