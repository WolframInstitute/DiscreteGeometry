Package["WolframInstitute`DiscreteGeometry`"]

(* Usage messages for exported symbols. Experimental functions are marked (experimental). *)

ComplexClosure::usage = "ComplexClosure[g] returns the simplicial closure of a list of simplices g.";
IndexComplex::usage = "IndexComplex[g] relabels vertices of complex g to a consecutive ordering of integers.";

SimplexDimension::usage = "SimplexDimension[s] gives the dimension (#vertices - 1) of simplex s.";
ComplexDimension::usage = "ComplexDimension[g] gives the maximal simplex dimension of complex g (or -1 for empty).";
ComplexDimensions::usage = "ComplexDimensions[g] gives inductive vertex dimensions of complex g.";
ComplexInductiveDimension::usage = "ComplexInductiveDimension[g] gives the mean of vertex dimensions (inductive dimension).";
SimplexList::usage = "SimplexList[g, k] lists all simplices of dimension <= k (or within a range {kmin,kmax}).";
ComplexBones::usage = "ComplexBones[g] returns interior (d-2)-faces (\"bones\") of a pure d-dimensional complex.";
ComplexWalls::usage = "ComplexWalls[g] returns codimension-1 faces (\"walls\") of a pure complex (potential boundary facets).";
ComplexFacets::usage = "ComplexFacets[g] returns all maximal simplices (facets) of g.";
ComplexFrames::usage = "ComplexFrames[g] returns the ordered facets (frames) of g: every permutation of each maximal simplex.";
ComplexHypergraph::usage = "ComplexHypergraph[g] returns the maximal simplices of g as a hypergraph, peeling top-down by dimension so faces already contained in a higher simplex are dropped.";
ComplexVertexList::usage = "ComplexVertexList[g] returns the sorted list of vertices in g.";
SimplexCardinality::usage = "SimplexCardinality[g, k] gives the number of k-dimensional simplices in g.";
SimplexCardinalities::usage = "SimplexCardinalities[g] gives counts of simplices in each dimension (f-vector without the leading 1).";
SimplexStar::usage = "SimplexStar[g, s] gives the star: all simplices containing s.";
SimplexStarSphere::usage = "SimplexStarSphere[g, s] gives the star of s with s itself removed (the simplices strictly containing s).";
SimplexCore::usage = "SimplexCore[g, s] gives all simplices contained in s.";
SimplexCoreSphere::usage = "SimplexCoreSphere[s] gives the proper faces of s: its closure with s itself removed.";
SimplexUnitSphere::usage = "SimplexUnitSphere[g, s] gives the unit sphere (link) around simplex s (its star minus interior).";
SimplexMirror::usage = "SimplexMirror[g, s] returns the \"mirror\" simplex made by the first vertex absent from each coface in the star boundary (used for geodesic continuation).";
SimplexBoundary::usage = "SimplexBoundary[s] lists codimension-1 faces of simplex s.";
ComplexDual::usage = "ComplexDual[g] returns a dual cell structure (barycentric dual) of g.";
SimplexIndex::usage = "SimplexIndex[s] gives signed index weight of simplex s; SimplexIndex[s,t] gives relative index if s and t coincide as sets.";
SimplexSign::usage = "SimplexSign[s] is the permutation signature of vertex ordering of s; SimplexSign[s,t] relative signature if same underlying set.";
SimplexWeight::usage = "SimplexWeight[s] is (-1)^(Length[s]).";
ContractibleQ::usage = "ContractibleQ[g] attempts a recursive star decomposition test for contractibility of g.";
ComplexSphereQ::usage = "ComplexSphereQ[g] heuristically tests if g is a combinatorial sphere (vertex links spheres + Euler).";
ComplexManifoldQ::usage = "ComplexManifoldQ[g] tests if all vertex links are spheres or balls (pseudomanifold / manifold condition).";
SimplicialMap::usage = "SimplicialMap[g, perm] builds a simplicial map induced by a vertex permutation.";

ComplexJoin::usage = "ComplexJoin[a,b] returns the join of simplicial complexes a and b.";

ComplexEulerCharacteristic::usage = "ComplexEulerCharacteristic[g] gives the alternating sum of simplex counts of g.";
ComplexFermiCharacteristic::usage = "ComplexFermiCharacteristic[g] gives the multiplicative Fermi characteristic (product of simplex weights).";
LefschetzNumber::usage = "LefschetzNumber[g] estimates average Lefschetz number of random automorphisms; LefschetzNumber[g,map] uses a given simplicial map.";
LefschetzCurvature::usage = "LefschetzCurvature[g] gives simplexwise curvature contributions via Lefschetz fixed point indices.";

ComplexPolynomial::usage = "ComplexPolynomial[g, t] gives the f-polynomial 1 + sum f_i t^i of g.";
PoincarePolynomial::usage = "PoincarePolynomial[g, t] gives the Poincaré polynomial from Betti numbers of g.";
ComplexCurvature::usage = "ComplexCurvature[g, t] integrates the f-polynomial symbolically.";
ComplexCurvatures::usage = "ComplexCurvatures[g, t] gives curvature values for each simplex using its unit sphere.";
DehnSommervilleQ::usage = "DehnSommervilleQ[g] tests the Dehn–Sommerville relations f(t)=f(-1-t).";

GraphComplex::usage = "GraphComplex[g, k] returns the clique complex of graph g, the cliques with at most k vertices (dimension k - 1); GraphComplex[g, {n, k}] the cliques with n to k vertices. Infinity for the full clique complex.";
SkeletonComplex::usage = "SkeletonComplex[g] returns the 2-skeleton clique complex of graph g.";
ComplexGraph::usage = "ComplexGraph[g] returns the 1-skeleton graph of simplicial complex g.";
FaceGraph::usage = "FaceGraph[g] returns incidence graph between simplices and subfaces.";
BarycentricRefinement::usage = "BarycentricRefinement[g] returns the barycentric subdivision (complex, graph, or iterated form).";

GraphTopology::usage = "GraphTopology[g] returns star neighborhoods of each simplex of the clique complex of g.";
AlexandrovTopology::usage = "AlexandrovTopology[g] returns the specialization/Alexandrov topology induced by the face poset of g.";

IndexMatrix::usage = "IndexMatrix[g,k] returns signed incidence between (k+1)- and k-simplices; IndexMatrix[g] defaults to full complex.";
SignMatrix::usage = "SignMatrix[g,k] returns orientation sign incidence matrix between (k+1)- and k-simplices.";
FaceMatrix::usage = "FaceMatrix[i][g, x, y] gives the Boolean matrix of the i-th face map between simplex lists x and y (entry 1 when deleting vertex i of a y-simplex yields the x-simplex).";
ComplexIncidenceMatrix::usage = "ComplexIncidenceMatrix[g,k] returns the oriented incidence matrix at dimension k.";
ConnectionMatrix::usage = "ConnectionMatrix[g] returns Euler-characteristic based connection matrix among simplices.";
GreenFunctionMatrix::usage = "GreenFunctionMatrix[g] returns the inverse of ConnectionMatrix[g] in closed form via star-intersection Euler characteristics (Knill's unimodularity theorem). Distinct from GreenOperatorMatrix.";
GreenOperatorMatrix::usage = "GreenOperatorMatrix[g] returns the Moore-Penrose pseudoinverse of the Hodge Laplacian (d + d^T)^2, block-diagonal by simplex degree. Top-left block of GreenOperatorMatrix[GraphComplex[g]] is the graph-Laplacian pseudoinverse.";
HodgePropagatorMatrix::usage = "HodgePropagatorMatrix[g, k] returns the Moore-Penrose pseudoinverse of the boundary operator d_k = ComplexIncidenceMatrix[g, k], computed as (d_k^T d_k)^+ d_k^T. HodgePropagatorMatrix[g, All] returns the list over k = 0..ComplexDimension[g] - 1.";
DiracHodgeMatrix::usage = "DiracHodgeMatrix[g] returns d + d^T for the simplicial complex g.";
DiracConnectionMatrix::usage = "DiracConnectionMatrix[g] returns L + L^T for connection matrix L.";
DiracBlockMatrix::usage = "DiracBlockMatrix[g] is block diagonal with incidence blocks. DiracBlockMatrix[cc] for a ChainComplex cc (or a graph, or SimplicialData) is the Dirac operator D = d + d^* on the direct sum of the chain groups, as a sparse matrix. DiracBlockMatrix[cc, {m0, m1, ...}] takes the adjoint with respect to one inner product per degree, each a positive definite matrix or the vector of its diagonal.";
DiracDualBlockMatrix::usage = "DiracDualBlockMatrix[g] is dual block diagonal with transposed incidence products.";
DiracColumns::usage = "DiracColumns[g] partitions DiracHodgeMatrix columns by simplex dimensions.";
DiracDualColumns::usage = "DiracDualColumns[g] returns transposed column blocks of DiracHodgeMatrix.";
HodgeBlock::usage = "HodgeBlock[g] returns (d + d^T)^2 for complex g (global, not partitioned).";
HodgeMatrix::usage = "HodgeMatrix[g] returns block-diagonal Hodge Laplacian matrices by dimension.";
HodgeLaplacianMatrix::usage = "HodgeLaplacianMatrix[g] returns the block form (d^T d + d d^T) aggregated as DiracBlockMatrix^2. HodgeLaplacianMatrix[cc] for a ChainComplex cc (or a graph, or SimplicialData) is D^2, block diagonal with the Hodge Laplacians d_k^* d_k + d_(k+1) d_(k+1)^*. HodgeLaplacianMatrix[cc, {m0, m1, ...}] is the weighted version, one inner product per degree.";
BettiVector::usage = "BettiVector[g] returns Betti numbers (nullities) for each dimension of g. BettiVector[cc] and BettiVector[cc, {m0, m1, ...}] are the nullities of the Hodge Laplacian blocks of a ChainComplex cc.";

MatrixBlocks::usage = "MatrixBlocks[m, blocks] splits square matrix m into block submatrices according to cardinalities blocks.";
MatrixNullity::usage = "MatrixNullity[m] gives the dimension of the null space of square matrix m.";
MatrixColumns::usage = "MatrixColumns[m, blocks] extracts grouped column blocks from square matrix m.";
SuperTrace::usage = "SuperTrace[mat] returns graded trace (alternating signs) or from vector of traces.";
PseudoDeterminant::usage = "PseudoDeterminant[m] gives product of nonzero eigenvalues of m.";
SuperDeterminant::usage = "SuperDeterminant[m] gives graded determinant from pseudo-determinants of blocks.";

GraphSuspension::usage = "GraphSuspension[g] adds two new universal vertices and returns a 3D graph embedding.";
RandomGraphAutomorphism::usage = "RandomGraphAutomorphism[g, n] samples n automorphisms (All for all, Automatic for one).";

(* Graph.wl *)
GraphEdgeWeights::usage = "GraphEdgeWeights[g] gives edge weights (default 1) for graph g.";
GraphVertexWeights::usage = "GraphVertexWeights[g] gives vertex weights (default 1) for graph g.";

FormanRicciCurvature::usage = "FormanRicciCurvature[g] returns Association[edge -> kappa] with Forman's combinatorial Ricci curvature on the clique complex of g. Options: \"OnCells\" (Integer | All | {dims}; output cell dimension(s), default 1) and \"MaxCellDimension\" (Automatic (default) | Integer; clique-complex truncation, Automatic = Max[OnCells] + 1).";
SectionalCurvatures::usage = "SectionalCurvatures[g] estimates discrete sectional curvatures for edge neighborhoods (if implemented).";
SpacetimeGraph::usage = "SpacetimeGraph[{m,n}] builds a 2D causal diamond style spacetime graph grid.";
SpacetimeTorusGraph::usage = "SpacetimeTorusGraph[{m,n}] builds a periodic (toroidal) spacetime graph.";
RotateEdge::usage = "RotateEdge[e,{m,n}] rotates a directed edge in toroidal coordinates.";
KickEdge::usage = "KickEdge[e] applies one 'kick' transition edge transformation.";
PersistEdge::usage = "PersistEdge[e] returns edge advanced forward without lateral change.";
RightMatrix::usage = "RightMatrix[g,{m,n}] returns sparse right-step transition matrix for a graph walk.";
ToroidalRightMatrix::usage = "ToroidalRightMatrix[g] returns right-walk transition matrix with wrap-around edges.";
ToroidalLeftMatrix::usage = "ToroidalLeftMatrix[g] returns left-walk transition matrix with wrap-around edges.";
DiracWalk::usage = "DiracWalk[g,p] returns coined quantum walk transition matrix (mix of kick/persist).";
VertexAmplitudes::usage = "VertexAmplitudes[g, edgeWeights,{m,n}] returns complex amplitude per vertex from adjacent weighted edges.";

(* Mesh.wl *)
ComplexEmbedding::usage = "ComplexEmbedding[g,d] numerically embeds complex g in R^d via energy minimization (d=2 or 3).";
ComplexMesh::usage = "ComplexMesh[g,d] builds a MeshRegion from complex g (with optional explicit coordinates).";
HighlightComplex::usage = "HighlightComplex[g, h] renders the mesh of complex g with the simplices in h highlighted (each h entry a vertex list, optionally wrapped in Style).";
GraphMesh::usage = "GraphMesh[g] builds a MeshRegion from graph g using its embedding + cliques up to size 4.";
MeshComplex::usage = "MeshComplex[mr] returns the simplicial complex induced by MeshRegion mr.";
MeshIncidenceMatrix::usage = "MeshIncidenceMatrix[mr,k] gives oriented incidence matrix between (k-1)- and k-cells.";
CellOrientation::usage = "CellOrientation[cell] gives orientation sign (+/-1) of a mesh cell.";
FlipCellOrientation::usage = "FlipCellOrientation[cell] reverses or rotates orientation of a cell consistently.";
HighlightCellOrientations::usage = "HighlightCellOrientations[mr] colors top-dimensional cells by orientation sign.";
OrientMeshRegion::usage = "OrientMeshRegion[mr] attempts to orient all top-dimensional cells consistently.";
TriangulateArrayMesh::usage = "TriangulateArrayMesh[mr] refines a mesh to bounded cell measure.";
OrientableMeshRegionQ::usage = "OrientableMeshRegionQ[mr] heuristically tests orientability via connectivity of oriented adjacency.";
MoebiusMesh::usage = "MoebiusMesh[nu,nv] constructs a triangulated Möbius band strip.";
PathMesh::usage = "PathMesh[list] returns a simple path mesh through given vertices.";

(* Chains.wl *)
SymmetricRelationGraph::usage = "SymmetricRelationGraph[f, assoc] builds an undirected graph joining keys whose values satisfy relation f.";
SpatialReconstruction::usage = "SpatialReconstruction[g, slice, n] returns spatial relation graph from causal graph slice after n steps.";
CausalGraphSimpleChains::usage = "CausalGraphSimpleChains[g] finds simple source-sink path families in causal graph g.";
CoordinatizeCausalGraph::usage = "CoordinatizeCausalGraph[g,{obs1,obs2}] assigns 2D coordinates from pairs of observer chains.";
CoordinatizedCausalGraph::usage = "CoordinatizedCausalGraph[g,{obs1,obs2}] builds a reduced causal graph with observer highlighting.";

(* Experimental.wl (experimental) *)
FaceVector::usage = "FaceVector[g] gives the f-vector (excluding empty face) of complex g.";
HVector::usage = "HVector[g] gives the h-vector derived from the f-vector of g.";
GVector::usage = "GVector[g] gives the g-vector (first differences of h).";
LinkComplex::usage = "LinkComplex[g,s] returns the link of simplex s in g.";
InducedSubcomplex::usage = "InducedSubcomplex[g,verts] returns the induced subcomplex on a vertex subset.";
VertexDeletion::usage = "VertexDeletion[g,v] removes vertex v (and incident simplices) returning the induced subcomplex.";
ComplexUnion::usage = "ComplexUnion[a,b] returns closure of union of complexes a and b.";
ComplexIntersection::usage = "ComplexIntersection[a,b] returns simplices common to a and b (no closure).";
ComplexDifference::usage = "ComplexDifference[a,b] returns closure of simplices in a not in b.";
PureComplexQ::usage = "PureComplexQ[g] tests whether all facets have identical dimension.";
RandomSimplicialComplex::usage = "RandomSimplicialComplex[n,p,max] generates Linial–Meshulam random complex up to max dimension.";
RandomFlagComplex::usage = "RandomFlagComplex[n,p,k] generates an Erdős–Rényi G(n,p) then clique complex up to dimension k.";
FacetGraph::usage = "FacetGraph[g] returns the dual adjacency graph of facets sharing a ridge.";
BettiAssociation::usage = "BettiAssociation[g] gives an association from dimension to Betti number.";
EulerBettiConsistencyQ::usage = "EulerBettiConsistencyQ[g] checks Euler characteristic equals alternating Betti sum.";
EnumerateComplexes::usage = "EnumerateComplexes[verts,d] generates all simplicial complexes on given vertex set with maximal dimension d (default Infinity). Use option \"MaxCount\"->n to cap enumeration size.";
DiscreteDirichletEnergy::usage = "DiscreteDirichletEnergy[g,f] gives 1/2 Sum_{(u,v)} (f[u]-f[v])^2 over edges of the 1-skeleton of complex or graph g; f may be an Association or list aligned to vertex order.";

(* Geodesics *)
ComplexGeodesicFlow::usage = "ComplexGeodesicFlow[g, path] performs one geodesic extension step of a simplex path within complex g via mirror continuation.";
SimplexOrbit::usage = "SimplexOrbit[g, path, n] iteratively applies ComplexGeodesicFlow up to n steps (default Infinity) or until the path self-intersects.";
ComplexGeodesics::usage = "ComplexGeodesics[g] returns a list of unique geodesics starting from all the facets.";

(* SimplicialSet.wl *)
SimplicialData::usage = "SimplicialData[faceBlocks, degeneracyBlocks] is a container for face- and degeneracy-blocks of correct dimensions representing a simplicial set structure.";
SimplicialSet::usage = "SimplicialSet[simplices] constructs the minimal simplicial set that contains the given set of simplices. Options: \"IncludeDegeneracies\"->True (default), \"FlattenMultiplicities\"->True (default).";
SimplicialSetQ::usage = "SimplicialSetQ[sd] checks if the given simplicial data form a valid simplicial set (face and degeneracy maps satisfy simplicial identities).";
DeltaComplexQ::usage = "DeltaComplexQ[sd] checks if the given simplicial data form a Delta-complex (face maps satisfy simplicial identities, all degeneracy maps are zero).";
SimplicialComplexQ::usage = "SimplicialComplexQ[sd] checks if the given simplicial data form a simplicial complex (each simplex has a unique combination of boundary elements).";

(* ChainComplex.wl -- the names and conventions of PureMath's ChainComplex *)
ChainComplex::usage = "ChainComplex[{d1, d2, ...}] represents a chain complex by its boundary matrices, d_k : C_k -> C_(k-1) an n_(k-1) x n_k matrix. ChainComplex[complex] gives the simplicial chain complex of a list of simplices, closed under faces: C_k has the sorted k-simplices as basis in canonical order, and d_k is sparse with d_k sigma = Sum_i (-1)^i (sigma without its i-th vertex). ChainComplex[g] gives the chain complex of the clique complex of the graph g, on the vertices renumbered 1, 2, ... in VertexList order. ChainComplex[SimplicialData[...]] gives the normalized chain complex (nondegenerate simplices, d_k = Sum_i (-1)^i d_i); it stays unevaluated when an empty normalized level lies below a nonempty one. Properties: cc[\"BoundaryMatrices\"], cc[\"Length\"], cc[\"Dimensions\"] (the ranks n_0, n_1, ... of the chain groups).";
CochainComplex::usage = "CochainComplex[{d0, d1, ...}] represents a cochain complex by its coboundary matrices, d^k : C^k -> C^(k+1). CochainComplex[cc] gives the dual of the chain complex cc, d^k = Transpose[d_(k+1)]; CochainComplex[complex] and CochainComplex[g] dualize ChainComplex[complex] and ChainComplex[g]. Properties: \"CoboundaryMatrices\", \"Length\".";
ChainComplexQ::usage = "ChainComplexQ[expr] gives True if expr is a ChainComplex whose boundary matrices have compatible dimensions and compose to zero, d_(k-1) . d_k = 0, and False otherwise.";
BoundaryMap::usage = "BoundaryMap[cc, n] gives the boundary matrix d_n : C_n -> C_(n-1) of a chain complex, 1 <= n <= cc[\"Length\"]. BoundaryMap[CochainComplex[...], n] gives the coboundary d^n : C^n -> C^(n+1), 0-indexed. BoundaryMap[complex, n] and BoundaryMap[g, n] read ChainComplex[complex] and ChainComplex[g].";
Homology::usage = "Homology[cc, n] gives the n-th integral homology group H_n = ker d_n / im d_(n+1) as the pair {rank, torsion}, standing for Z^rank (+) Z/t_1 (+) Z/t_2 (+) ...; above the top degree it is {0, {}}. Also Homology[complex, n], Homology[g, n], Homology[SimplicialData[...], n].";
HomologyGroups::usage = "HomologyGroups[cc] gives the integral homology of a chain complex as an association <|k -> {b_k, torsion_k}|>, k = 0, ..., cc[\"Length\"]: b_k = n_k - rank d_k - rank d_(k+1), and torsion_k the invariant factors > 1 of d_(k+1) (Smith normal form). Also HomologyGroups[complex], HomologyGroups[g], HomologyGroups[SimplicialData[...]].";
HomologyRank::usage = "HomologyRank[cc, n] gives the Betti number b_n = n_n - rank d_n - rank d_(n+1), the rank of H_n; 0 above the top degree. Also on a complex, a graph or SimplicialData.";
BettiNumbers::usage = "BettiNumbers[cc] gives the Betti numbers {b_0, b_1, ..., b_D} of a chain complex, the ranks of its homology over the rationals, from matrix ranks alone. Also BettiNumbers[complex], BettiNumbers[g] (the clique complex), BettiNumbers[SimplicialData[...]].";
ReducedHomology::usage = "ReducedHomology[cc] gives the reduced integral homology, the homology of the complex augmented by C_0 -> Z, as an association <|k -> {b_k, torsion_k}|>; it differs from HomologyGroups only by one less free summand in degree 0. Also on a complex, a graph or SimplicialData.";

(* SimplicialVolume.wl -- the l^1 norm of a homology class and its scale profile (Gromov's simplicial volume on a graph) *)
HomologyClassNorm::usage = "HomologyClassNorm[cc, n, z] gives the l^1 norm of the homology class of the cycle z in degree n of the chain complex cc, min |z + d_(n+1) w|_1 over the chains w, z a vector over the basis of C_n; the linear program is solved on machine reals and the value is an exact rational when the rationalised minimiser and dual cocycle certify it, else the solver's float. HomologyClassNorm[CochainComplex[...], n, z] gives the norm of a cohomology class, with d^(n-1) in place of d_(n+1). HomologyClassNorm[complex, chain] does the same on a list of simplices, the chain an association simplex -> coefficient whose keys may be oriented ({4, 3} -> -1 is {3, 4} -> 1), through ChainComplex[complex]. HomologyClassNorm[..., property] with \"Norm\", \"Cycle\" (the minimiser) or \"Cocycle\" (the dual maximiser, a cocycle of sup norm at most 1 pairing with z to the norm), or a list of these, as LinearOptimization[..., {\"PrimalMinimizer\", \"DualMaximizer\"}]; on a simplex list the cycle and cocycle come back as chains. Options: \"Coefficients\" -> Reals | Integers (the integral norm by the mixed-integer solver), Method and Tolerance of LinearOptimization (default CLP primal simplex at 10^-12, retried at Automatic).";
FundamentalCycle::usage = "FundamentalCycle[cc, n] gives the primitive integral vector spanning ker d_n of the chain complex cc when that kernel has rank one, sign fixed by its first entry, and {} otherwise. FundamentalCycle[cc] takes the top degree, where ker d_n is H_n. FundamentalCycle[complex] gives the top class of a list of simplices as a chain simplex -> coefficient, <||> when the top homology has not rank one; FundamentalCycle[g] does the same on the clique complex of the graph g.";
SimplicialVolumeProfile::usage = "SimplicialVolumeProfile[g, {r1, r2}] gives the association r -> ||alpha_r||_1, the l^1 norm of the image of the fundamental class alpha of the clique complex of the graph g in the Vietoris-Rips complex at scale r, for r1 <= r <= r2, stopping at the first scale where the class dies. SimplicialVolumeProfile[g, chain, {r1, r2}] follows the given chain instead; SimplicialVolumeProfile[filtration, chain] evaluates every complex of an association r -> complex. Options: \"Complex\" -> \"VietorisRips\" (the clique complex of the r-th power graph) or any function r -> complex on the vertices of g; \"Normalization\" -> None | \"Vertex\" (divides by the vertex count); \"Coefficients\", Method and Tolerance of HomologyClassNorm.";
AreaCocycle::usage = "AreaCocycle[complex, coordinates, periods] gives the volume cocycle of the flat torus R^d / (periods) on the top simplices of complex, as an association simplex -> value: each vertex is lifted by coordinates to its periodic image nearest the first vertex, the value is the signed volume of the lifted simplex, scaled to sup norm 1. It is a cocycle while the simplices lift consistently (diameters below half the systole), and against the fundamental class it pairs to the lower bound of the flat theorems. AreaCocycle[g, coordinates, periods, r] does the same on the Vietoris-Rips complex of the graph g at scale r.";

BettiTable::usage = "BettiTable[data, radii, opts] returns <| 'Radii'->rlist, 'Betti'->matrix, 'Dimensions'->{d0,...} |> constructed from BettiCurves. Options: passes through MaxDimension -> k (default Automatic=all).";
BettiCurves::usage = "BettiCurves[data, radii, opts] returns an association r -> {b0,b1,...}. Option MaxDimension->k truncates vectors (Automatic = all).";
VietorisRipsFiltration::usage = "VietorisRipsFiltration[data, radii, opts] returns association r -> Vietoris–Rips complex at scale r. Options: 'MaxDimension'->k (default Infinity) is passed to VietorisRipsComplex and bounds the number of vertices of a simplex, not its dimension; 'Sort'->True/False to control radius sorting.";
VietorisRipsComplex::usage = "VietorisRipsComplex[data, r, k] returns the Vietoris–Rips simplicial complex (clique complex of threshold graph) truncated to simplices with at most k vertices, i.e. dimension k - 1 (Infinity for full). VietorisRipsComplex[g, r, k] does the same for a Graph g under its shortest-path metric: the clique complex of the radius-r power graph (at r = 1 this is GraphComplex[g]).";
VietorisRipsThresholdGraph::usage = "VietorisRipsThresholdGraph[data, r, opts] returns the threshold graph joining points with distance <= r. Options: 'Metric'->f (default EuclideanDistance), 'IncludeLoops'->False (future use), 'VertexCoordinates'->True to attach coordinates. VietorisRipsThresholdGraph[g, r] returns instead the r-th power of a Graph g, joining vertices whose graph distance is <= r.";

PersistentHomology::usage = "PersistentHomology[filtration, opts] returns association dim -> {{birth,death},...} over GF(2). PersistentHomology[data, radii] builds internal filtration first. Option MaxDimension->k (Automatic = all).";
PersistenceIntervals::usage = "PersistenceIntervals[filtration, opts] internal helper implementing Z2 reduction; same output format as PersistentHomology.";
PersistenceDiagram::usage = "PersistenceDiagram[filtration, opts] returns list {dim,birth,death}. Also PersistenceDiagram[data, radii] builds filtration. Option MaxDimension->k.";
PopularNetwork::usage = "PopularNetwork[name, what] returns a requested artifact: 'Graph' (default), 'Description', 'Source', or 'All' (association with all fields).";
PopularNetworkNames::usage = "PopularNetworkNames[] lists available names for PopularNetwork.";
PopularHypergraph::usage = "PopularHypergraph[name, what] returns a hypergraph dataset as list-of-hyperedges ('Hypergraph', default) or derived views: 'IncidenceGraph', '2SectionGraph', 'Description', 'Source', or 'All'.";
PopularHypergraphNames::usage = "PopularHypergraphNames[] lists available hypergraph dataset names (FIM transaction itemsets etc.).";
HypergraphVertexSet::usage = "HypergraphVertexSet[edges] returns the set of distinct vertices in a list-of-hyperedges representation.";
HypergraphVertexCount::usage = "HypergraphVertexCount[edges] gives the number of distinct vertices.";
HyperedgeCount::usage = "HyperedgeCount[edges] gives the number of hyperedges.";
HyperedgeSizes::usage = "HyperedgeSizes[edges] returns a list of the sizes of each hyperedge.";
HyperedgeSizeDistribution::usage = "HyperedgeSizeDistribution[edges] tallies hyperedge sizes as {size,count}.";
HypergraphDegree::usage = "HypergraphDegree[edges] returns an association vertex -> number of incident hyperedges (treating duplicates within a hyperedge once).";
HypergraphMaximalEdges::usage = "HypergraphMaximalEdges[edges] filters to inclusion-maximal hyperedges (removing those strictly contained in another).";
HypergraphComplex::usage = "HypergraphComplex[edges] returns the downward-closed simplicial complex generated by the hyperedges.";
HypergraphLineGraph::usage = "HypergraphLineGraph[edges] returns the intersection graph of hyperedges (one vertex per hyperedge).";
Hypergraph2Section::usage = "Hypergraph2Section[edges] returns the 2-section (primal) graph connecting vertices co-occurring in a hyperedge of size >= 2.";
Weighted2SectionGraph::usage = "Weighted2SectionGraph[edges, min] returns a weighted 2-section graph with edge weights = co-occurrence counts (filtering weights < min).";
HypergraphSummary::usage = "HypergraphSummary[edges] returns an association summarizing counts, size stats, average degree, and degree distribution.";

(* QuantumCalculus.wl *)
WaveEquationSolution::usage = "WaveEquationSolution[g, u0, v0, t] gives the d'Alembert wave equation solution cos(D t) u0 + t sinc(D t) v0 on a simplicial complex g.";
DiscreteWaveStep::usage = "DiscreteWaveStep[g, u, uPrev] returns {uNext, u} for one discrete-time leapfrog wave step on complex g.";
WavePropagator::usage = "WavePropagator[g, t] returns the unitary wave propagator matrix exp(i D t) for complex g.";
WuCharacteristic::usage = "WuCharacteristic[g, m] gives the m-th Wu characteristic (generalized Euler characteristic from m-tuple interactions). Default m=2.";
IsospectralDeformation::usage = "IsospectralDeformation[g, t, n] returns the Dirac matrix after Lax-pair isospectral deformation D'=[d-d*,D] for time t in n steps.";
DiracMass::usage = "DiracMass[g, t] extracts the diagonal mass term from the isospectrally deformed Dirac operator at time t.";
ConnesDistance::usage = "ConnesDistance[g] returns the Connes spectral distance matrix between vertices of complex g.";
DiracZetaFunction::usage = "DiracZetaFunction[g, s] gives the super-spectral zeta function str(|D|^{-s}) of the Dirac operator.";
ConnectionZetaFunction::usage = "ConnectionZetaFunction[g, s] gives the spectral zeta function of the connection matrix L.";
LefschetzZetaFunction::usage = "LefschetzZetaFunction[g, perm, z] gives the Lefschetz zeta function exp(sum L(T^n)/n z^n) for automorphism perm.";
AnalyticTorsion::usage = "AnalyticTorsion[g] gives the analytic torsion exp(1/2 sum (-1)^{k+1} k log det'(H_k)) of complex g.";
IndexExpectationCurvature::usage = "IndexExpectationCurvature[g] gives the index-expectation curvature K(x)=E[1-chi(S(x) cap {f<f(x)})], satisfying Gauss-Bonnet: sum K = chi.";

(* ===== Tessellations / maps (moved from SyntheticInfrageometry) ===== *)

(* Differential forms and cochains. Cochains are stored sparsely on the increasing
   representative of each clique; two conventions share that format and are not
   interchangeable -- see the header of Kernel/DifferentialForms.wl. *)

