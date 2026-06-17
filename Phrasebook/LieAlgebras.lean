/-
Copyright (c) 2026 Oliver Nash. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Oliver Nash
-/

import VersoManual
import Phrasebook.Meta.Lean
import Mathlib

-- This gets access to most of the manual genre (which is also useful for textbooks)
open Verso.Genre Manual

-- This gets access to Lean code that's in code blocks, elaborated in the same process and
-- environment as Verso
-- Write a code block with ```savedLean ... ``` to save it to an external file.
open Verso.Genre.Manual.InlineLean


open Phrasebook

set_option pp.rawOnError true

#doc (Manual) "Lie algebras" =>

We describe Mathlib's theory of Lie algebras in the sections below.

# Lie algebras and their representations

Mathlib contains a theory of Lie algebras and their representations.

The following adds a Lie algebra to the Lean environment
```lean
variable {R L : Type*} [CommRing R]
  [LieRing L] [LieAlgebra R L]
```

Lie algebras use a bracket notation: the product of `x` and `y` is written `⁅x, y⁆`. Thus the
Jacobi identity appears as:
```lean
example (x y z : L) :
    ⁅x, ⁅y, z⁆⁆ + ⁅y, ⁅z, x⁆⁆ + ⁅z, ⁅x, y⁆⁆ = 0 :=
  lie_jacobi x y z
```

The following adds a representation
```lean
variable {M : Type*}
  [AddCommGroup M] [Module R M]
  [LieRingModule L M] [LieModule R L M]
```

This data determines a morphism of Lie algebras $`L → End(M)`. In Mathlib this morphism appears
as {name}`LieModule.toEnd`. More generally morphisms and equivalences between any Lie algebras
may be added to the environment using a special notation as follows
```lean
variable {L' : Type*}
  [LieRing L'] [LieAlgebra R L']
  (φ : L →ₗ⁅R⁆ L') (e : L ≃ₗ⁅R⁆ L')
```

# Properties of Lie algebras

Familiar concepts from Lie theory appear in Mathlib as follows:
- *Nilpotentcy* {name}`LieModule.IsNilpotent` (generalised to Lie modules)
- *Solvability* {name}`LieAlgebra.IsSolvable`
- *Simplicity* {name}`LieAlgebra.IsSimple`

The following three conditions, are all equivalent in finite dimensions in
characteristic zero but are distinct and thus each have their own definition:
- *Non-degenerate Killing form* {name}`LieAlgebra.IsKilling`
- *Direct sum of simple ideals* {name}`LieAlgebra.IsSemisimple`
- *Trivial solvable radical* {name}`LieAlgebra.HasTrivialRadical`

For a final example, the following adds a Cartan subalgebra to the environment
```lean
variable (H : LieSubalgebra R L) [H.IsCartanSubalgebra]
```

# Notable results

The following are some notable results in Mathlib's Lie theory library:
- *Engel's theorem*: {name}`LieModule.isNilpotent_iff_forall`
- *Lie's theorem*: {name}`LieModule.exists_nontrivial_weightSpace_of_isSolvable`
- *Existence of Cartan subalgebras* {name}`LieAlgebra.exists_isCartanSubalgebra_engel`
- *Root system of a semisimple Lie algebra* {name}`LieAlgebra.IsKilling.rootSystem`
