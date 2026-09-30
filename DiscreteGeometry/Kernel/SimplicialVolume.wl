Package["WolframInstitute`DiscreteGeometry`"]

PackageExport[HomologyClassNorm]
PackageExport[FundamentalCycle]
PackageExport[SimplicialVolumeProfile]
PackageExport[AreaCocycle]


(* ===================== Norm of a homology class ===================== *)

(* ||[z]||_1 = min |z + d w|_1 over w in C_(n+1), the quotient norm of l^1 by the boundaries, as the linear program
   min Sum t subject to -t <= z + d w <= t; the dual maximiser is a cocycle phi with ||phi||_inf <= 1 and <phi, z> = the norm.
   The solver runs on machine reals; the answer is exact when the rationalised minimiser and cocycle certify each other
   (a cycle of norm N and an exact cocycle of sup norm <= 1 pairing to N), else the solver's float. CLP primal simplex at
   Tolerance 10^-12 lands on exact vertices up to ~10^4 variables and declares larger problems unbounded, where the default
   tolerance still gives a float within 10^-5, so the solve retries there; Indeterminate is the norm when that fails too.
   Integer weights come from the mixed-integer solver inside the box |w|, t <= |z|_1, which it needs to stay bounded. *)
Options[ HomologyClassNorm ] = { "Coefficients" -> Reals, Method -> { "CLP", "Method" -> "Primal" }, Tolerance -> 10^-12 }

(* the class in degree n as a vector over the basis of C_n; the boundary out of degree n + 1 is the zero map at the top *)
HomologyClassNorm[ ChainComplex[ boundaries : { __ ? MatrixQ } ], n_Integer, cycle_ ? VectorQ, rest___ ] /; 0 <= n <= Length @ boundaries :=
  HomologyClassNorm[ If[ n < Length @ boundaries, boundaries[[ n + 1 ]], ConstantArray[ { }, Length @ cycle ] ], cycle, rest ]

(* the norm of a cohomology class: the boundary out of degree n + 1 of a cochain complex read upward is d^(n-1) *)
HomologyClassNorm[ CochainComplex[ coboundaries : { __ ? MatrixQ } ], n_Integer, cocycle_ ? VectorQ, rest___ ] /; 0 <= n <= Length @ coboundaries :=
  HomologyClassNorm[ If[ n > 0, coboundaries[[ n ]], ConstantArray[ { }, Length @ cocycle ] ], cocycle, rest ]

HomologyClassNorm[ boundaryMatrix_ ? MatrixQ, cycleVector_ ? VectorQ, opts : OptionsPattern[ ] ] :=
  HomologyClassNorm[ boundaryMatrix, cycleVector, "Norm", opts ]

(* without cells a class has one representative: the norm is the facet count, the sign vector its cocycle *)
HomologyClassNorm[ boundaryMatrix_ ? MatrixQ, cycleVector_ ? VectorQ, property : _String | { __String }, OptionsPattern[ ] ] /; Last @ Dimensions @ boundaryMatrix == 0 :=
  Lookup[ <| "Norm" -> Total @ Abs @ cycleVector, "Cycle" -> Normal @ cycleVector, "Cocycle" -> Sign @ Normal @ cycleVector |>, property ]

HomologyClassNorm[ boundaryMatrix_ ? MatrixQ, cycleVector_ ? VectorQ, property : _String | { __String }, OptionsPattern[ ] ] :=
  With[
    { boundary = SparseArray @ boundaryMatrix, cycle = Normal @ cycleVector, cells = Last @ Dimensions @ boundaryMatrix },
    { identity = IdentityMatrix[ Length @ cycle, SparseArray ] },
    { constraints = { Join[ Join[ boundary, identity, 2 ], Join[ -boundary, identity, 2 ] ], N @ Join[ cycle, -cycle ] },
      objective = N @ Join[ ConstantArray[ 0, cells ], ConstantArray[ 1, Length @ cycle ] ],
      box = { Join[ IdentityMatrix[ cells + Length @ cycle, SparseArray ], -IdentityMatrix[ cells + Length @ cycle, SparseArray ] ],
        N @ ConstantArray[ Total @ Abs @ cycle, 2 ( cells + Length @ cycle ) ] } },
    { solve = tolerance |-> Quiet[
        LinearOptimization[ objective, constraints, { "PrimalMinimumValue", "PrimalMinimizer", "DualMaximizer" }, Method -> OptionValue[ Method ], Tolerance -> tolerance ],
        { LinearOptimization::ubnd, LinearOptimization::nsolc, LinearOptimization::lpsub, LinearOptimization::lpsnf } ] },
    { solution = Replace[ solve @ OptionValue[ Tolerance ], Except[ { _ ? NumericQ, __ } ] :> solve @ Automatic ] },
    { weights = If[ OptionValue[ "Coefficients" ] === Integers,
        Round @ LinearOptimization[ objective, MapThread[ Join, { constraints, box } ], Join[ ConstantArray[ Integers, cells ], ConstantArray[ Reals, Length @ cycle ] ], "PrimalMinimizer" ][[ ;; cells ]],
        Rationalize[ solution[[ 2, ;; cells ]], 10^-6 ] ],
      cocycle = Rationalize[ solution[[ 3, 1, Length @ cycle + 1 ;; ]] - solution[[ 3, 1, ;; Length @ cycle ]], 10^-6 ] },
    { minimiser = cycle + boundary . weights },
    { certified = cocycle . cycle == Total @ Abs @ minimiser && Max @ Abs @ cocycle <= 1 && MatchQ[ Normal[ cocycle . boundary ], { 0 ... } ] },
    Lookup[
      <| "Norm" -> If[ OptionValue[ "Coefficients" ] === Integers || certified, Total @ Abs @ minimiser, Replace[ First @ solution, Except[ _ ? NumericQ ] -> Indeterminate ] ],
         "Cycle" -> minimiser,
         "Cocycle" -> cocycle |>,
      property ]
  ]

(* a chain on a simplex list is an association simplex -> coefficient, a key in non-sorted order standing for the sorted simplex
   with the sign of the permutation; the vertices are renumbered in their sorted order for ChainComplex, and the basis of C_n,
   the sorted n-simplices of the closure, is read back in the original labels *)
HomologyClassNorm[ complex : { ___List }, chain_Association, opts : OptionsPattern[ ] ] :=
  HomologyClassNorm[ complex, chain, "Norm", opts ]

HomologyClassNorm[ complex : { ___List }, chain_Association, property : _String | { __String }, opts : OptionsPattern[ ] ] :=
  With[
    { size = Length @ First @ Keys @ chain, vertices = Union @@ complex },
    { relabelled = Map[ AssociationThread[ vertices -> Range @ Length @ vertices ], complex, { 2 } ] },
    { simplices = Map[ vertices[[ # ]] &, ComplexClosure[ relabelled, { size } ], { 2 } ] },
    { simplexIndex = AssociationThread[ simplices -> Range @ Length @ simplices ] },
    { result = HomologyClassNorm[
        ChainComplex @ relabelled,
        size - 1,
        Normal @ SparseArray[ KeyValueMap[ { simplex, coefficient } |-> simplexIndex[ Sort @ simplex ] -> Signature[ simplex ] coefficient, chain ], Length @ simplices ],
        { "Norm", "Cycle", "Cocycle" }, opts ] },
    Lookup[
      <| "Norm" -> result[[ 1 ]],
         "Cycle" -> DeleteCases[ AssociationThread[ simplices -> result[[ 2 ]] ], 0 ],
         "Cocycle" -> DeleteCases[ AssociationThread[ simplices -> result[[ 3 ]] ], 0 ] |>,
      property ]
  ]


(* ===================== Fundamental cycle ===================== *)

(* the primitive integral vector spanning ker d_n when that kernel is a line, sign fixed by its first entry; { } otherwise *)
FundamentalCycle[ cc : ChainComplex[ { __ ? MatrixQ } ], n_Integer ] :=
  Replace[ NullSpace @ SparseArray @ BoundaryMap[ cc, n ], { { vector_ } :> Sign[ First @ DeleteCases[ vector, 0 ] ] vector / GCD @@ vector, _ -> { } } ]

(* the top degree, where ker d_n is H_n *)
FundamentalCycle[ cc : ChainComplex[ boundaries : { __ ? MatrixQ } ] ] :=
  FundamentalCycle[ cc, Length @ boundaries ]

(* the top class of a simplex list as a chain, <||> when the top homology has not rank one *)
FundamentalCycle[ complex : { ___List } ] :=
  With[
    { size = Max[ Length /@ complex ], vertices = Union @@ complex },
    { relabelled = Map[ AssociationThread[ vertices -> Range @ Length @ vertices ], complex, { 2 } ] },
    { simplices = Map[ vertices[[ # ]] &, ComplexClosure[ relabelled, { size } ], { 2 } ], vector = FundamentalCycle @ ChainComplex @ relabelled },
    If[ vector === { }, <||>, DeleteCases[ AssociationThread[ simplices -> vector ], 0 ] ]
  ]

FundamentalCycle[ graph_ ? GraphQ ] :=
  FundamentalCycle @ GraphComplex[ graph ]


(* ===================== Scale profile ===================== *)

(* r -> ||alpha_r||_1 for alpha pushed along the ladder r1 <= r <= r2; stops at the first scale where the class dies.
   "Complex": "VietorisRips" (the clique complex of the r-th power graph), or any function r -> complex on the vertices of g *)
Options[ SimplicialVolumeProfile ] = { "Complex" -> "VietorisRips", "Coefficients" -> Reals, "Normalization" -> None, Method -> { "CLP", "Method" -> "Primal" }, Tolerance -> 10^-12 }

SimplicialVolumeProfile[ graph_ ? GraphQ, { r1_Integer, r2_Integer }, opts : OptionsPattern[ ] ] :=
  SimplicialVolumeProfile[ graph, FundamentalCycle @ graph, { r1, r2 }, opts ]

SimplicialVolumeProfile[ graph_ ? GraphQ, chain_Association, { r1_Integer, r2_Integer }, opts : OptionsPattern[ ] ] :=
  With[
    { size = Length @ First @ Keys @ chain,
      scale = Replace[ OptionValue[ "Normalization" ], { "Vertex" -> 1 / VertexCount @ graph, _ -> 1 } ] },
    { ladder = Replace[ OptionValue[ "Complex" ], {
        "VietorisRips" -> ( r |-> VietorisRipsComplex[ graph, r, size + 1 ] ) } ] },
    Association @ First[
      Last @ Reap @ Do[
        With[ { norm = HomologyClassNorm[ ladder @ r, chain, FilterRules[ { opts }, Options @ HomologyClassNorm ] ] },
          Sow[ r -> scale norm ];
          If[ norm == 0, Break[ ] ] ],
        { r, r1, r2 } ],
      { } ]
  ]

(* a precomputed ladder, an association r -> complex: every scale is evaluated *)
SimplicialVolumeProfile[ filtration_Association, chain_Association, opts : OptionsPattern[ ] ] :=
  With[
    { scale = Replace[ OptionValue[ "Normalization" ], { "Vertex" -> 1 / Count[ First @ filtration, { _ } ], _ -> 1 } ] },
    ( complex |-> scale HomologyClassNorm[ complex, chain, FilterRules[ { opts }, Options @ HomologyClassNorm ] ] ) /@ filtration
  ]


(* ===================== Area cocycle ===================== *)

(* the volume cocycle of the flat torus R^d / (periods): phi(sigma) = signed volume of the straightened lift of sigma,
   every vertex lifted to its periodic image nearest the first one, scaled to sup norm 1. A cocycle as long as the
   simplices lift consistently (diameters below half the systole); against the fundamental class it pairs to
   Vol(T) / V_max, the lower bound of the flat theorems, which the LP dual attains where they hold. *)
AreaCocycle[ complex : { ___List }, coordinates_Association, periods_ ? MatrixQ ] :=
  With[
    { simplices = Union[ Sort /@ Select[ complex, Length[ # ] == Length[ periods ] + 1 & ] ],
      shifts = Tuples[ { -1, 0, 1 }, Length @ periods ] . periods },
    { displacement = { point, origin } |-> First @ MinimalBy[ point - origin + # & /@ shifts, N @* Norm ] },
    { volumes = ( simplex |-> Det[ displacement[ coordinates @ #, coordinates @ First @ simplex ] & /@ Rest @ simplex ] ) /@ simplices },
    DeleteCases[ AssociationThread[ simplices -> volumes / Max @ Abs @ volumes ], 0 ]
  ]

AreaCocycle[ graph_ ? GraphQ, coordinates_Association, periods_ ? MatrixQ, r_Integer ] :=
  AreaCocycle[ VietorisRipsComplex[ graph, r, Length[ periods ] + 1 ], coordinates, periods ]
