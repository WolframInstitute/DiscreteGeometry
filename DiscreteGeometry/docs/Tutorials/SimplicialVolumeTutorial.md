---
Template: TechNote
Name: SimplicialVolumeTutorial
Title: Simplicial Volume
Context: WolframInstitute`DiscreteGeometry`
Paclet: WolframInstitute/DiscreteGeometry
URI: WolframInstitute/DiscreteGeometry/tutorial/SimplicialVolumeTutorial
Keywords: [simplicial volume, Gromov norm, homology class, l1 norm, linear program, cocycle, Vietoris-Rips complex, scale profile, flat torus, area cocycle, fundamental cycle]
RelatedGuides: [ChainComplexesAndHomologyGuide]
---

- The $\ell^1$ norm of a chain $z = \sum_\sigma z_\sigma \sigma$ is $|z|_1 = \sum_\sigma |z_\sigma|$, and the norm of a homology class is the least norm of a cycle representing it, $\lVert \alpha \rVert_1 = \min \{ |z|_1 : [z] = \alpha \}$. On a closed manifold the norm of the fundamental class is Gromov's **simplicial volume**.
- On a fixed finite complex a top class has one representing cycle, so its norm is a facet count. The freedom that singular simplices give in the continuum comes on a graph from **scale**: the Vietoris–Rips complex $K_r(G)$ has a simplex for every vertex set of diameter at most $r$, and a class of the clique complex $K_1(G)$ pushes forward to a class $\alpha_r$ of $K_r(G)$ whose norm can only fall.
- The **scale profile** $r \mapsto \lVert \alpha_r \rVert_1$ is the invariant. It is non-increasing, it is $0$ once the class dies, and the normalised profile $\lVert \alpha_r \rVert_1 / |V|$ either decays, as on a flat torus, or stays above a floor, as on a hyperbolic surface.
- The norm is a linear program, $\min \sum_\sigma t_\sigma$ subject to $-t \leq z + \partial w \leq t$. Its dual optimum is a cocycle $\varphi$ with $\lVert \varphi \rVert_\infty \leq 1$ and $\langle \varphi, z \rangle = \lVert \alpha \rVert_1$, a certificate of the value. The computations below use [HomologyClassNorm](), [FundamentalCycle](), [SimplicialVolumeProfile]() and [AreaCocycle]().

## Setup

```wl
Needs["WolframInstitute`DiscreteGeometry`"]
```

A flat torus for the experiments: a graph, the lift of its vertices to the plane, the periods of the lattice of deck translations, the facets of one cell per lattice point and the largest area of a triangle of unit diameter in the limit norm of the lattice. Every vertex of a facet is lifted to its periodic image nearest the first one, and the facet is oriented by the sign of its lifted area; the scale is the largest graph distance inside a facet, the density the number of vertices per unit area.

```wl
FlatTorus[graph_, coordinates_, periods_, facets_, extremalVolume_] := With[
  {shifts = Tuples[{-1, 0, 1}, 2] . periods, density = VertexCount[graph] / Abs @ Det @ periods, distance = GraphDistanceMatrix @ graph, index = AssociationThread[VertexList @ graph -> Range @ VertexCount @ graph]},
  {displacement = {point, origin} |-> First @ MinimalBy[point - origin + # & /@ shifts, N @* Norm]},
  {orientation = facet |-> Sign @ Det[displacement[coordinates @ #, coordinates @ First @ facet] & /@ Rest @ facet]},
  <|"Graph" -> graph, "Coordinates" -> coordinates, "Periods" -> periods, "FundamentalCycle" -> AssociationMap[orientation, Sort /@ facets], "Scale" -> Max[distance[[index /@ #, index /@ #]] & /@ facets], "Density" -> density, "ExtremalVolume" -> extremalVolume, "Constant" -> 1 / (density extremalVolume)|>]
```

The square torus: the Cartesian product of two cycles, metric $\ell^1$, every unit square cut along a diagonal into two half-squares; the largest triangle of unit $\ell^1$ diameter has area $1/4$.

```wl
FlatTorus["Square", {m_, n_}] := With[
  {graph = GraphProduct[CycleGraph[m], CycleGraph[n], "Cartesian"]},
  FlatTorus[graph, AssociationMap[Identity, VertexList @ graph], {{m, 0}, {0, n}},
    Flatten[Table[With[{x = {i, j}, x1 = {Mod[i + 1, m, 1], j}, x2 = {i, Mod[j + 1, n, 1]}, x12 = {Mod[i + 1, m, 1], Mod[j + 1, n, 1]}}, {{x, x1, x12}, {x, x2, x12}}], {i, m}, {j, n}], 2], 1/4]]
```

The triangular torus: the lattice spanned by unit vectors $e_1$ and $e_2$ at $120$ degrees, so that $e_1$, $e_2$ and $e_1 + e_2$ are the three edge directions, with the unit triangles as facets; the largest triangle of unit diameter is the equilateral one, of area $\sqrt{3}/4$.

```wl
FlatTorus["Triangular", {m_, n_}] := With[
  {graph = Graph @ Flatten @ Table[{{i, j} <-> {Mod[i + 1, m], j}, {i, j} <-> {i, Mod[j + 1, n]}, {i, j} <-> {Mod[i + 1, m], Mod[j + 1, n]}}, {i, 0, m - 1}, {j, 0, n - 1}]},
  FlatTorus[graph, AssociationMap[Apply[{i, j} |-> {i - j/2, j Sqrt[3]/2}], VertexList @ graph], {{m, 0}, {-n/2, n Sqrt[3]/2}},
    Flatten[Table[With[{x = {i, j}, x1 = {Mod[i + 1, m], j}, x2 = {i, Mod[j + 1, n]}, x12 = {Mod[i + 1, m], Mod[j + 1, n]}}, {{x, x1, x12}, {x, x2, x12}}], {i, 0, m - 1}, {j, 0, n - 1}], 2], Sqrt[3]/4]]
```

The honeycomb torus: the sites $\{i, j, 0\}$ on a triangular lattice of spacing $\sqrt{3}$ and the sites $\{i, j, 1\}$ at its triangle centroids, each hexagon cut into its alternating triangle and three ears; the largest triangle of unit diameter in the limit norm of the honeycomb has area $3\sqrt{3}/16$.

```wl
FlatTorus["Honeycomb", {m_, n_}] := With[
  {graph = Graph @ Flatten @ Table[{{i, j, 0} <-> {i, j, 1}, {i, j, 0} <-> {Mod[i - 1, m], j, 1}, {i, j, 0} <-> {i, Mod[j - 1, n], 1}}, {i, 0, m - 1}, {j, 0, n - 1}]},
  FlatTorus[graph, AssociationMap[Apply[{i, j, s} |-> i {Sqrt[3], 0} + j {Sqrt[3]/2, 3/2} + s {Sqrt[3]/2, 1/2}], VertexList @ graph], {m {Sqrt[3], 0}, n {Sqrt[3]/2, 3/2}},
    Flatten[Table[With[{v0 = {i, j, 1}, v1 = {Mod[i + 1, m], j, 0}, v2 = {Mod[i + 1, m], j, 1}, v3 = {Mod[i + 1, m], Mod[j + 1, n], 0}, v4 = {i, Mod[j + 1, n], 1}, v5 = {i, Mod[j + 1, n], 0}}, {{v0, v2, v4}, {v0, v1, v2}, {v2, v3, v4}, {v4, v5, v0}}], {i, 0, m - 1}, {j, 0, n - 1}], 2], 3 Sqrt[3]/16]]
```

The facets of a flat torus drawn in the plane, each lifted next to its first vertex.

```wl
flatPicture[torus_] := With[
  {shifts = Tuples[{-1, 0, 1}, 2] . torus["Periods"], lift = torus["Coordinates"]},
  {nearest = {point, origin} |-> origin + First @ MinimalBy[point - origin + # & /@ shifts, N @* Norm]},
  Graphics[{EdgeForm[Gray], FaceForm[Opacity[0.3, StandardBlue]], Polygon[(facet |-> With[{origin = lift[First @ facet]}, (v |-> nearest[lift[v], origin]) /@ facet]) /@ Keys @ torus["FundamentalCycle"]]}]]
```

The pairing $\langle \varphi, z \rangle$ of a cochain with a chain, both given as associations from simplices to coefficients.

```wl
pairing[cochain_, chain_] := Total @ KeyValueMap[{simplex, coefficient} |-> coefficient Lookup[cochain, Key @ simplex, 0], chain]
```

## The norm of a class

- The cycle graph $C_m$ is a circle. Its fundamental cycle is the sum of its edges, and at scale $r$ the Rips complex has an edge between any two vertices at most $r$ steps apart. Below, the Rips complex of $C_{12}$ at scale $2$, with the edges of a cycle of least norm representing the class drawn thick: six long edges with weight $1$, so the norm is $6$, half the facet count.

```wl
With[{g = CycleGraph[12]},
  {minimiser = HomologyClassNorm[VietorisRipsComplex[g, 2, 3], FundamentalCycle[g], "Cycle"]},
  HighlightGraph[Graph[GraphPower[g, 2], VertexCoordinates -> CirclePoints[12]], UndirectedEdge @@@ Keys @ minimiser]]
```

- For $r < m/3$ the norm of the class of $C_m$ at scale $r$ is $m/r$: the rotation chain $\frac{1}{r} \sum_i [v_i, v_{i+r}]$ is a representative of norm $m/r$, and the winding cocycle, the number of steps of an edge divided by $m$, has sup norm $r/m$ and pairs to $1$.
- The property `"Cocycle"` returns the dual optimum. On $C_{30}$ at scale $4$: the norm, the norm of the returned cycle, the pairing of the returned cocycle with the fundamental cycle, and the sup norm of the cocycle.

```wl
With[{g = CycleGraph[30]}, {base = FundamentalCycle[g]},
  {result = HomologyClassNorm[VietorisRipsComplex[g, 4, 3], base, {"Norm", "Cycle", "Cocycle"}]},
  {result[[1]], Total @ Abs @ result[[2]], pairing[result[[3]], base], Max @ Abs @ result[[3]]}]
```

- A rational value is certified: the returned cycle and cocycle are exact and prove it from both sides. A decimal value is the solver's optimum without a certificate.
- A cohomology class has a norm too, by the same program on the cochain complex read upward: the generator of $H^1$ of the square has norm $1$.

```wl
HomologyClassNorm[CochainComplex[CycleGraph[4]], 1, {1, 0, 0, 0}]
```

## The scale profile

- The profile of $C_{30}$ over the scales $1$ to $9$, real and integral. The real profile is $30/r$; the integral profile, the least norm of an integral representative, is $\lceil 30/r \rceil$, and the two agree only where $r$ divides $30$.

```wl
With[{g = CycleGraph[30]},
  ListLinePlot[{List @@@ Normal @ SimplicialVolumeProfile[g, {1, 9}], List @@@ Normal @ SimplicialVolumeProfile[g, {1, 9}, "Coefficients" -> Integers]}, Mesh -> All]]
```

- The normalised profile divides by the number of vertices. On the circle it is $1/r$: the simplicial volume of the circle is $0$, and on a graph this appears as decay in scale rather than as an exact zero.

```wl
Normal @ SimplicialVolumeProfile[CycleGraph[12], {1, 3}, "Normalization" -> "Vertex"]
```

- The profile stops at the first scale where the class dies. The Rips complex of $C_6$ at scale $2$ is the boundary of the octahedron with its interior filled, so the class dies there.

```wl
Normal @ SimplicialVolumeProfile[CycleGraph[6], {1, 5}]
```

## Flat tori

- A lattice torus is a graph with a lift to the plane. The base class is the sum of the facets of one cell per lattice point, coherently oriented, taken at the first scale where every facet is a simplex: the unit triangles of the triangular torus at scale $1$, the half-squares of the square torus and the hexagon fans of the honeycomb at scale $2$. Below, the three tori with their facets.

```wl
GraphicsRow[flatPicture /@ {FlatTorus["Square", {5, 5}], FlatTorus["Triangular", {5, 5}], FlatTorus["Honeycomb", {3, 3}]}]
```

- Two theorems fix the profile below a quarter of the systole: on the triangular torus $\lVert \alpha_r \rVert_1 = 2|V|/r^2$, and on the square torus $\lVert \alpha_r \rVert_1 = 4|V|/r^2$ at even $r$. The upper bound is a chain of big triangles of side $r$ with weights $1/r^2$ and $2/r^2$, the lower bound is the area cocycle of the next section. The profile of the triangular torus on $144$ vertices at scales $1$ and $2$:

```wl
With[{t = FlatTorus["Triangular", {12, 12}]}, Normal @ SimplicialVolumeProfile[t["Graph"], t["FundamentalCycle"], {1, 2}]]
```

- The constants $2$ and $4$ have one source. For a lattice with limit norm $N$, density $\rho$ of vertices per unit area and $V_{\max}(N)$ the largest area of a triangle whose vertices are pairwise at $N$-distance at most $1$, the normalised value $r^2 \lVert \alpha_r \rVert_1 / |V|$ is $1/(\rho V_{\max}(N))$ wherever the extremal triangle is a lattice triangle at scale $r$. The three tori at their base scale, against the constant.

```wl
Dataset @ Table[
  With[{t = FlatTorus[name, {8, 8}]}, {r = t["Scale"]},
    <|"torus" -> name, "scale" -> r, "r^2 ||T||_r / |V|" -> r^2 SimplicialVolumeProfile[t["Graph"], t["FundamentalCycle"], {r, r}][r] / VertexCount @ t["Graph"], "1 / (density V_max)" -> t["Constant"]|>],
  {name, {"Square", "Triangular", "Honeycomb"}}]
```

## The area cocycle

- On a flat torus the signed area of the lifted triangle is a $2$-cocycle on $K_r(G)$ as long as every simplex lifts consistently, which holds below a quarter of the systole. Scaled to sup norm $1$ it pairs with the base class to $\mathrm{Area}(T) / A_r$, where $A_r$ is the largest lifted area of a simplex of $K_r(G)$, and this is the lower bound of the two theorems. Wherever the bound is attained, the area cocycle is the dual optimum of the linear program.
- On the triangular torus on $64$ vertices at scale $2$: the pairing of the area cocycle with the base class, its sup norm, and the norm of the class.

```wl
With[{t = FlatTorus["Triangular", {8, 8}]},
  {phi = AreaCocycle[t["Graph"], t["Coordinates"], t["Periods"], 2]},
  {pairing[phi, t["FundamentalCycle"]], Max @ Abs @ phi, HomologyClassNorm[VietorisRipsComplex[t["Graph"], 2, 4], t["FundamentalCycle"]]}]
```

## Other ladders

- The Rips ladder is the default, but any family of complexes on the vertices of the graph works through the option `"Complex"` as a function of the scale, and a precomputed association from scales to complexes works directly. The Rips complex at twice the scale is the Čech complex of a cycle graph, the nerve of its balls, so its profile is $m/(2r)$.

```wl
Normal @ SimplicialVolumeProfile[CycleGraph[30], {1, 3}, "Complex" -> (r |-> VietorisRipsComplex[CycleGraph[30], 2 r, 3])]
```

- The ball-intersection complexes of the sister paclet InfraGeometry, `BallIntersectionComplex` and `BallIntersectionFiltration`, return plain lists of simplices and enter the same way. Beyond the Rips and Čech ladders the open questions are the constants of the other ladders, the hyperbolic floor $4g - 4$ on refined triangulations of surfaces of genus $g$, and the size of linear programs the solver can certify.
