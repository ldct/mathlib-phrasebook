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

#doc (Manual) "Haar measure" =>

We describe Mathlib's theory of Haar measure in the sections below.

# Existence

A locally compact group admits a unique left-invariant measure which is unique up to scale (subject
to mild additional hypotheses). This is known as the Haar measure. Mathlib contains the theory of
Haar measure, including existence and uniqueness.

As the Haar measure is only unique up to scale, to obtain a Haar measure, one must supply a compact
subset $`K` (with non-empty interior) which is deemed to have unit measure. The following
demonstrates this in action:
```lean
variable {G : Type*}
  [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [MeasurableSpace G] [BorelSpace G]
  (K : TopologicalSpace.PositiveCompacts G)

#check MeasureTheory.Measure.haarMeasure K
```
Note that the existence of $`K` ensures that $`G` is locally compact:
```lean
example : LocallyCompactSpace G :=
  K.locallyCompactSpace_of_group
```

If $`G` is compact then the unique measure for which the entire group has unit measure can be
obtained as:
```lean
variable [CompactSpace G]

#check MeasureTheory.Measure.haarMeasure (G := G) ⊤
```

# Further API and uniqueness

The typeclass {name}`MeasureTheory.Measure.IsMulLeftInvariant` expresses that a measure is left
invariant and we can witness that a Haar measure is left invariant as follows:
```lean
open MeasureTheory.Measure in
example : (haarMeasure K).IsMulLeftInvariant :=
  inferInstance
```

In addition to the construction of the Haar measure, Mathlib has API characterising it. This is
encoded using the typeclass {name}`MeasureTheory.Measure.IsHaarMeasure`. One can use this to
author lemmas which will apply to any Haar measure by beginning:
```lean
variable (μ : MeasureTheory.Measure G) [μ.IsHaarMeasure]
```
We can witness that Mathlib knows such lemmas apply to types such as the reals and the circle as
follows:
```lean
open MeasureTheory MeasureTheory.Measure in
example : IsAddHaarMeasure (G := ℝ) volume :=
  inferInstance

open MeasureTheory MeasureTheory.Measure in
example : IsAddHaarMeasure (G := UnitAddCircle) volume :=
  inferInstance
```

There are several uniqueness statements for Haar measures. Of particular note is
{name}`MeasureTheory.Measure.isMulLeftInvariant_eq_smul`.
