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

#doc (Manual) "Groups" =>

We describe Mathlib's group theory in the sections below.

# Multiplicative and additive notation

Mathlib contains a theory of groups. Moreover it supports both multiplicative and additive
notation. The following adds a group to the Lean environment using multiplicative notation:
```lean
variable {G : Type*} [Group G]
```
The following expresses the associative law:
```lean
example (x y z : G) :
    (x * y) * z = x * (y * z) :=
  mul_assoc x y z
```

We can witness the same mathematics in additive notation as follows:
```lean
variable {A : Type*} [AddGroup A]

example (x y z : A) :
    (x + y) + z = x + (y + z) :=
  add_assoc x y z
```

# Properties of Groups

Morphisms and equivalences of groups exist and have a special notation as shown below:
```lean
variable (H : Type*) [Group H]
  (f : G →* H) (e : G ≃* H)
```

Subgroups and quotients also exist. For example the following demonstrates that Mathlib knows
that the cosets of a normal subgroup are naturally a group:
```lean
variable (N : Subgroup G) [N.Normal]
#synth Group (G ⧸ N)
```

Familiar concepts from group theory appear in Mathlib as follows:
- *Nilpotency* {name}`Group.IsNilpotent`
- *Solvability* {name}`IsSolvable`
- *Simplicity* {name}`IsSimpleGroup`

as well as many more.

# Notable results

The following are some notable results in Mathlib's Lie theory library:
- *Lagrange's theorem* {name}`Subgroup.card_subgroup_dvd_card`
- *Sylow's first theorem* {name}`Sylow.exists_subgroup_card_pow_prime`
- *Simplicity of the alternating group* {name}`alternatingGroup.isSimpleGroup`
- The *Schur-Zassenhaus theorem* {name}`Subgroup.exists_left_complement'_of_coprime`
