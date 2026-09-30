BeginTestSection["SimplicialVolumeTests"]

(* ===== Fixtures ===== *)

(* the triangular torus T(m, n): vertices Z_m x Z_n, edges along e1, e2 and e1 + e2; 2 m n facets. The lattice keeps the
   {i, j} labels, the torus is its IndexGraph (the simplex-list readers of ChainComplex need integer vertices) *)
triangularLattice[ m_, n_ ] :=
  Graph @ Flatten @ Table[
    { { i, j } <-> { Mod[ i + 1, m ], j }, { i, j } <-> { i, Mod[ j + 1, n ] }, { i, j } <-> { Mod[ i + 1, m ], Mod[ j + 1, n ] } },
    { i, 0, m - 1 }, { j, 0, n - 1 } ]

triangularTorus[ m_, n_ ] := IndexGraph @ triangularLattice[ m, n ]

(* lifted coordinates and periods of T(m, n): e1, e2 at 120 degrees so that e1, e2, e1 + e2 are unit *)
triangularCoordinates[ m_, n_ ] :=
  AssociationThread[ Range[ m n ] -> ( { #[[ 1 ]] - #[[ 2 ]]/2, #[[ 2 ]] Sqrt[ 3 ]/2 } & /@ VertexList @ triangularLattice[ m, n ] ) ]

triangularPeriods[ m_, n_ ] := { { m, 0 }, { -n/2, n Sqrt[ 3 ]/2 } }

(* the square torus TorusGraph[{m, n}], m, n >= 5, with every unit square (its 4-cycles) cut along one diagonal:
   at Rips scale 2 the squares are cliques and the half-squares carry the fundamental class *)
halfSquares[ graph_ ] :=
  FundamentalCycle @ Union @ Catenate[
    Subsets[ Sort @ #, { 1, 3 } ] & /@ Catenate[ ( { a, b, c, d } |-> { { a, b, c }, { a, c, d } } ) @@@ Map[ First, FindCycle[ graph, { 4 }, All ], { 2 } ] ] ]

(* coefficient vector of a chain over the sorted simplices of its degree in a complex *)
chainVector[ chain_, complex_ ] :=
  Lookup[ chain, Key /@ Union[ Sort /@ Select[ complex, Length[ # ] == Length @ First @ Keys @ chain & ] ], 0 ]

(* <cochain, chain> *)
pairing[ cochain_, chain_ ] :=
  Total @ KeyValueMap[ { simplex, coefficient } |-> coefficient Lookup[ cochain, Key @ simplex, 0 ], chain ]


(* ===== FundamentalCycle ===== *)

(* the cycle graph: every edge once, coefficients +-1, boundary zero *)
VerificationTest[
  With[ { complex = GraphComplex[ CycleGraph[ 6 ] ] }, { cycle = FundamentalCycle[ complex ] },
    { Length @ cycle, Union @ Abs @ Values @ cycle, Union @ Normal[ BoundaryMap[ complex, 1 ] . chainVector[ cycle, complex ] ] } ],
  { 6, { 1 }, { 0 } },
  TestID -> "FundamentalCycle-CycleGraph"
]

(* the triangular torus: all 2 |V| facets coherently oriented *)
VerificationTest[
  With[ { complex = GraphComplex @ triangularTorus[ 4, 4 ] }, { cycle = FundamentalCycle[ complex ] },
    { Length @ cycle, Union @ Abs @ Values @ cycle, Union @ Normal[ BoundaryMap[ complex, 2 ] . chainVector[ cycle, complex ] ] } ],
  { 32, { 1 }, { 0 } },
  TestID -> "FundamentalCycle-TriangularTorus"
]

(* the graph form is the clique complex form *)
VerificationTest[
  FundamentalCycle[ CycleGraph[ 5 ] ],
  FundamentalCycle @ GraphComplex[ CycleGraph[ 5 ] ],
  TestID -> "FundamentalCycle-GraphForm"
]

(* rank two (two circles) and rank zero (a path) have no fundamental cycle *)
VerificationTest[
  { FundamentalCycle @ GraphDisjointUnion[ CycleGraph[ 4 ], CycleGraph[ 4 ] ], FundamentalCycle @ PathGraph @ Range[ 5 ] },
  { <||>, <||> },
  TestID -> "FundamentalCycle-RankNotOne"
]

(* on the chain complex: the primitive null vector of d_n, the top degree by default, {} when the kernel is not a line *)
VerificationTest[
  { Abs @ FundamentalCycle @ ChainComplex[ CycleGraph[ 6 ] ],
    FundamentalCycle[ ChainComplex[ CycleGraph[ 6 ] ], 1 ],
    FundamentalCycle @ ChainComplex @ GraphDisjointUnion[ CycleGraph[ 4 ], CycleGraph[ 4 ] ],
    FundamentalCycle[ ChainComplex @ VietorisRipsComplex[ CycleGraph[ 12 ], 2, 3 ], 1 ] },
  { { 1, 1, 1, 1, 1, 1 }, FundamentalCycle @ ChainComplex[ CycleGraph[ 6 ] ], { }, { } },
  TestID -> "FundamentalCycle-ChainComplex"
]

(* the chain on the simplex list is the vector on the chain complex, in the canonical basis *)
VerificationTest[
  With[ { complex = GraphComplex @ CycleGraph[ 6 ] },
    chainVector[ FundamentalCycle @ complex, complex ] == FundamentalCycle @ ChainComplex @ CycleGraph[ 6 ] ],
  True,
  TestID -> "FundamentalCycle-ChainAndVectorAgree"
]


(* ===== HomologyClassNorm ===== *)

(* without (n+1)-simplices the class has one representative and the norm is the facet count *)
VerificationTest[
  { HomologyClassNorm[ GraphComplex[ CycleGraph[ 7 ] ], FundamentalCycle[ CycleGraph[ 7 ] ] ],
    HomologyClassNorm[ ChainComplex[ CycleGraph[ 7 ] ], 1, FundamentalCycle @ ChainComplex[ CycleGraph[ 7 ] ] ] },
  { 7, 7 },
  TestID -> "HomologyClassNorm-FacetCountWithoutCells"
]

(* cycle graph theorem: ||alpha_r||_1 = m / r for r < m / 3, exact rationals *)
VerificationTest[
  Table[ HomologyClassNorm[ VietorisRipsComplex[ CycleGraph[ 30 ], r, 3 ], FundamentalCycle[ CycleGraph[ 30 ] ] ], { r, 1, 9 } ],
  Table[ 30 / r, { r, 1, 9 } ],
  TestID -> "HomologyClassNorm-CycleGraphMOverR"
]

(* integral profile of the cycle graph: Ceiling[m / r] *)
VerificationTest[
  Table[ HomologyClassNorm[ VietorisRipsComplex[ CycleGraph[ 30 ], r, 3 ], FundamentalCycle[ CycleGraph[ 30 ] ], "Coefficients" -> Integers ], { r, 1, 5 } ],
  Table[ Ceiling[ 30 / r ], { r, 1, 5 } ],
  TestID -> "HomologyClassNorm-CycleGraphIntegralCeiling"
]

(* triangular torus theorem: ||alpha_r||_1 = 2 |V| / r^2 *)
VerificationTest[
  HomologyClassNorm[ VietorisRipsComplex[ triangularTorus[ 6, 6 ], 2, 4 ], FundamentalCycle @ triangularTorus[ 6, 6 ] ],
  18,
  TestID -> "HomologyClassNorm-TriangularTorus2VOverR2"
]

(* square torus theorem at an even scale: ||alpha_r||_1 = 4 |V| / r^2 for the half-square class of TorusGraph *)
VerificationTest[
  With[ { torus = TorusGraph[ { 6, 6 } ] },
    HomologyClassNorm[ VietorisRipsComplex[ torus, 2, 4 ], halfSquares @ torus ] ],
  36,
  TestID -> "HomologyClassNorm-SquareTorus4VOverR2"
]

(* certificate on the cycle graph: the minimiser is a cycle of the stated norm, the cocycle is a cocycle
   with sup norm 1 pairing to the norm against the original cycle *)
VerificationTest[
  With[ { complex = VietorisRipsComplex[ CycleGraph[ 30 ], 4, 3 ], base = FundamentalCycle[ CycleGraph[ 30 ] ] },
    { result = HomologyClassNorm[ complex, base, { "Norm", "Cycle", "Cocycle" } ] },
    { result[[ 1 ]],
      Total @ Abs @ result[[ 2 ]],
      Union @ Normal[ BoundaryMap[ complex, 1 ] . chainVector[ result[[ 2 ]], complex ] ],
      pairing[ result[[ 3 ]], base ],
      Max @ Abs @ result[[ 3 ]],
      Union @ Normal[ chainVector[ result[[ 3 ]], complex ] . BoundaryMap[ complex, 2 ] ] } ],
  { 15 / 2, 15 / 2, { 0 }, 15 / 2, 1, { 0 } },
  TestID -> "HomologyClassNorm-CertificateCycleGraph"
]

(* certificate on the torus: the area cocycle bound 4 / 72 per triangle is attained *)
VerificationTest[
  With[ { complex = VietorisRipsComplex[ triangularTorus[ 6, 6 ], 2, 4 ], base = FundamentalCycle @ triangularTorus[ 6, 6 ] },
    { result = HomologyClassNorm[ complex, base, { "Norm", "Cycle", "Cocycle" } ] },
    { Total @ Abs @ result[[ 2 ]],
      Union @ Normal[ BoundaryMap[ complex, 2 ] . chainVector[ result[[ 2 ]], complex ] ],
      pairing[ result[[ 3 ]], base ],
      Max @ Abs @ result[[ 3 ]],
      Union @ Normal[ chainVector[ result[[ 3 ]], complex ] . BoundaryMap[ complex, 3 ] ] } ],
  { 18, { 0 }, 18, 1, { 0 } },
  TestID -> "HomologyClassNorm-CertificateTriangularTorus"
]

(* a single property and the default agree *)
VerificationTest[
  With[ { complex = VietorisRipsComplex[ CycleGraph[ 12 ], 2, 3 ], base = FundamentalCycle[ CycleGraph[ 12 ] ] },
    { HomologyClassNorm[ complex, base ], HomologyClassNorm[ complex, base, "Norm" ] } ],
  { 6, 6 },
  TestID -> "HomologyClassNorm-PropertyForms"
]

(* an oriented key is the sorted simplex with the sign of the permutation *)
VerificationTest[
  With[ { complex = GraphComplex[ CycleGraph[ 4 ] ] },
    HomologyClassNorm[ complex, <| { 1, 2 } -> 1, { 2, 3 } -> 1, { 4, 3 } -> -1, { 4, 1 } -> 1 |> ] ],
  4,
  TestID -> "HomologyClassNorm-OrientedKeys"
]

(* the chain complex form: the class as a vector over the canonical basis of C_n *)
VerificationTest[
  With[ { complex = VietorisRipsComplex[ CycleGraph[ 12 ], 2, 3 ] }, { base = FundamentalCycle[ CycleGraph[ 12 ] ] },
    HomologyClassNorm[ ChainComplex @ complex, 1, chainVector[ base, complex ] ] ],
  6,
  TestID -> "HomologyClassNorm-ChainComplexForm"
]

(* the norm of a cohomology class: the generator of H^1 of the square has norm 1 *)
VerificationTest[
  HomologyClassNorm[ CochainComplex[ CycleGraph[ 4 ] ], 1, { 1, 0, 0, 0 } ],
  1,
  TestID -> "HomologyClassNorm-CochainComplex"
]

(* vertices of any kind: the same torus with {i, j} labels and with integer labels gives the same norm *)
VerificationTest[
  HomologyClassNorm[ VietorisRipsComplex[ triangularLattice[ 4, 4 ], 2, 4 ], FundamentalCycle @ triangularLattice[ 4, 4 ] ] ==
    HomologyClassNorm[ VietorisRipsComplex[ triangularTorus[ 4, 4 ], 2, 4 ], FundamentalCycle @ triangularTorus[ 4, 4 ] ],
  True,
  TestID -> "HomologyClassNorm-RelabellingInvariance"
]


(* ===== SimplicialVolumeProfile ===== *)

(* the smoke test of the work item; the 12 x 12 value is the solver's float where CLP lands off an exact vertex *)
VerificationTest[
  { Values @ SimplicialVolumeProfile[ CycleGraph[ 12 ], { 1, 3 } ],
    Values @ SimplicialVolumeProfile[ CycleGraph[ 30 ], { 4, 4 } ],
    Values @ SimplicialVolumeProfile[ CycleGraph[ 30 ], { 4, 4 }, "Coefficients" -> Integers ],
    Values @ SimplicialVolumeProfile[ triangularTorus[ 6, 6 ], { 1, 2 } ],
    Values @ SimplicialVolumeProfile[ triangularTorus[ 12, 12 ], { 2, 2 } ] },
  { { 12, 6, 4 }, { 15 / 2 }, { 8 }, { 72, 18 }, { 72 } },
  SameTest -> Equal,
  TestID -> "SimplicialVolumeProfile-Smoke"
]

(* keys are the scales *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 12 ], { 1, 3 } ],
  <| 1 -> 12, 2 -> 6, 3 -> 4 |>,
  TestID -> "SimplicialVolumeProfile-KeysAreScales"
]

(* non-increasing in r *)
VerificationTest[
  With[ { profile = Values @ SimplicialVolumeProfile[ CycleGraph[ 30 ], { 1, 9 } ] }, Min[ Most @ profile - Rest @ profile ] >= 0 ],
  True,
  TestID -> "SimplicialVolumeProfile-Monotone"
]

(* the profile stops at the first scale where the class dies: C_6 at r = 2 is the octahedron *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 6 ], { 1, 5 } ],
  <| 1 -> 6, 2 -> 0 |>,
  TestID -> "SimplicialVolumeProfile-StopsAtDeath"
]

(* the square torus: 4 |V| / r^2 at r = 2, dead at r = 3 where the systole is 6 *)
VerificationTest[
  With[ { torus = TorusGraph[ { 6, 6 } ] }, SimplicialVolumeProfile[ torus, halfSquares @ torus, { 2, 3 } ] ],
  <| 2 -> 36, 3 -> 0 |>,
  TestID -> "SimplicialVolumeProfile-SquareTorus"
]

(* per-vertex normalisation of the cycle graph decays like 1 / r *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 12 ], { 1, 3 }, "Normalization" -> "Vertex" ],
  <| 1 -> 1, 2 -> 1 / 2, 3 -> 1 / 3 |>,
  TestID -> "SimplicialVolumeProfile-VertexNormalisation"
]

(* the explicit-chain form with the fundamental cycle is the graph form *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 12 ], FundamentalCycle[ CycleGraph[ 12 ] ], { 1, 3 } ],
  SimplicialVolumeProfile[ CycleGraph[ 12 ], { 1, 3 } ],
  TestID -> "SimplicialVolumeProfile-ChainForm"
]

(* integral profile Ceiling[m / r] *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 30 ], { 1, 5 }, "Coefficients" -> Integers ],
  <| 1 -> 30, 2 -> 15, 3 -> 10, 4 -> 8, 5 -> 6 |>,
  TestID -> "SimplicialVolumeProfile-Integral"
]

(* any r -> complex builder: the Rips complex at scale 2 r gives m / (2 r) *)
VerificationTest[
  SimplicialVolumeProfile[ CycleGraph[ 30 ], { 1, 3 }, "Complex" -> ( r |-> VietorisRipsComplex[ CycleGraph[ 30 ], 2 r, 3 ] ) ],
  <| 1 -> 15, 2 -> 15 / 2, 3 -> 5 |>,
  TestID -> "SimplicialVolumeProfile-Builder"
]

(* a precomputed filtration *)
VerificationTest[
  SimplicialVolumeProfile[ AssociationMap[ r |-> VietorisRipsComplex[ CycleGraph[ 30 ], r, 3 ], { 2, 3, 5 } ], FundamentalCycle[ CycleGraph[ 30 ] ] ],
  <| 2 -> 15, 3 -> 10, 5 -> 6 |>,
  TestID -> "SimplicialVolumeProfile-Filtration"
]


(* ===== AreaCocycle ===== *)

(* the area cocycle of the triangular torus at r = 2 is the theorem's certificate: a cocycle of sup norm 1 pairing with the
   fundamental class to 2 |V| / r^2 up to the sign FundamentalCycle chose, the LP value; its values are the areas of the
   lifted triangles in units of the largest *)
VerificationTest[
  With[ { complex = VietorisRipsComplex[ triangularTorus[ 8, 8 ], 2, 4 ], base = FundamentalCycle @ triangularTorus[ 8, 8 ] },
    { cocycle = AreaCocycle[ complex, triangularCoordinates[ 8, 8 ], triangularPeriods[ 8, 8 ] ] },
    { Max @ Abs @ cocycle, Abs @ pairing[ cocycle, base ],
      Union @ Normal[ chainVector[ cocycle, complex ] . BoundaryMap[ complex, 3 ] ],
      HomologyClassNorm[ complex, base ], Union @ Abs @ Values @ cocycle } ],
  { 1, 32, { 0 }, 32, { 1/4, 1/2, 3/4, 1 } },
  TestID -> "AreaCocycle-TriangularTorusCertificate"
]

(* the graph form is the complex form on the Rips complex *)
VerificationTest[
  AreaCocycle[ triangularTorus[ 6, 6 ], triangularCoordinates[ 6, 6 ], triangularPeriods[ 6, 6 ], 2 ],
  AreaCocycle[ VietorisRipsComplex[ triangularTorus[ 6, 6 ], 2, 3 ], triangularCoordinates[ 6, 6 ], triangularPeriods[ 6, 6 ] ],
  TestID -> "AreaCocycle-GraphForm"
]

EndTestSection[]
