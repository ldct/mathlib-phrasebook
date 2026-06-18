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

#doc (Manual) "Differential calculus" =>

We describe Mathlib's theory of differential calculus in the sections below.

# First examples

Mathlib has a theory of differential calculus. Given functions:
```lean
variable (f : ℝ → ℝ) (g : ℝ → ℝ)
```
Mathlib has tools as follows:
1. {lean}`Differentiable ℝ f` asks whether $`f` differentiable everywhere.
2. {lean}`∀ x, HasDerivAt f (g x) x` asks whether $`g` is the derivative of `f` everywhere.
3. {lean}`deriv f` is the derivative of $`f` (or zero if it is not differentiable).

We note in passing the following consistency:
```lean
example (h : Differentiable ℝ f) (x : ℝ) :
    HasDerivAt f (deriv f x) x :=
  (h x).hasDerivAt
```

# Further details

## Local issues

Differentiation is a local operation and this is reflected in Mathlib's API. For example the
{name}`Differentiable` definition comes in four flavours:
- {name}`DifferentiableAt`: asks whether a function is differentiable at a single point
- {name}`Differentiable`: asks whether a function is differentiable everywhere
- {name}`DifferentiableWithinAt`: asks whether a function is differentiable at a point within a subset
- {name}`DifferentiableOn`: asks whether a function is differentiable everywhere within a subset

In addition {name}`HasDerivAt` and {name}`deriv` have variants
{name}`HasDerivWithinAt` and {name}`derivWithin`.

## Coefficients

Mathlib's theory of differential calculus supports quite general coefficients including the reals,
the complex numbers, and the $`p`-adic numbers. For example here is the statement that {name}`deriv`
and {name}`HasDerivAt` are mutually compatible for a map of the $`p`-adics:
```lean
example (p : ℕ) [Fact p.Prime] (f : ℚ_[p] → ℚ_[p])
    (h : Differentiable ℚ_[p] f) (x : ℚ_[p]) :
    HasDerivAt f (deriv f x) x :=
  (h x).hasDerivAt
```

## Differentiability classes

The definitions {name}`ContDiffAt`, {name}`ContDiff`, {name}`ContDiffWithinAt`, {name}`ContDiffOn`
can be used to express continuous differentiability to any order. Note that these definitions
consume an order parameter of type {lean}`WithTop ℕ∞` and this allows discussion of all finite
orders as well as the smooth and analytic orders:
```lean
open scoped ContDiff
variable (k : ℕ)
#check ContDiff ℝ k f -- k-times continuously differentiable
#check ContDiff ℝ ∞ f -- smooth
#check ContDiff ℝ ω f -- analytic
```

## Fréchet derivatives

Mathlib has support for multivariable differential calculus via the Fréchet derivative, providing
an extensive theory of differential calculus for maps between any two normed spaces (not
necessarily finite-dimensional). The {name}`ContDiff` and {name}`Differentiable` definitions (and
their API) apply quite generally but for general domains one needs to use:
- {name}`HasFDerivAt` rather than {name}`HasDerivAt`
- {name}`HasFDerivWithinAt` rather than {name}`HasDerivWithinAt`
- {name}`fderiv` rather than {name}`deriv`
- {name}`fderivWithin` rather than {name}`derivWithin`
