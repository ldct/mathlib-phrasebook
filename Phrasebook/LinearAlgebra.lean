/-
Copyright (c) 2024-2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: David Thrane Christiansen, Anne Baanen
-/

import VersoManual
import Phrasebook.Meta.Lean
import Mathlib

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean


open Phrasebook

set_option pp.rawOnError true



#doc (Manual) "How to write linear algebra using Mathlib" =>

This page explains how to express common concepts in linear algebra using the definitions in Mathlib.
We assume basic knowledge of both Lean and linear algebra.

# Modules and vector spaces

::: leanSection
```lean -show
variable {x y z : ℤ} {v w : Fin 2 → ℤ}
```
The defining characteristic shared between modules and vector spaces is the properties of their scalar multiplication.
Scalar multiplication is written `(· • ·)` (`\bu`),
so for example distributivity of multiplication is written {lean}`(x * y) • v = x • (y • v)` (see {name}`mul_smul`).
...

Mathlib has one typeclass called {name}`Module` that can be used in combination with other classes
to express semimodules, modules and vector spaces in a uniform way.
To say `V` is a vector space over the field `K`, write:

```lean
variable {K V : Type*}
  [Field K] [AddCommGroup V] [Module K V]
```
:::

To say `M` is a module over the ring `R`, write:

::: leanSection
```lean
variable {R M : Type*}
  [Ring R] [AddCommGroup M] [Module R M]
```
:::

To say `M` is a semimodule over the semiring `R`, write:

::: leanSection
```lean
variable {R M : Type*}
  [Semiring R] [AddCommMonoid M] [Module R M]
```

The {lean}`Module R M` parameter specifies the behaviour of scalar multiplication, while {lean}`AddCommMonoid M` (and its descendants) and {lean}`Semiring R` (and its descendants) specify behaviour of operations that stay within {lean}`M` and {lean}`R` respectively, such as `(· + ·)` and `(· * ·)` respectively.

In this document, we'll use "module" to mean "semimodule, module, or vector space" and "ring" to mean "semiring, ring, or field" if the distinction between those does not matter.
:::

::: leanSection
```lean -show
variable {R M : Type*}
```

Lean *cannot* automatically infer that {lean}`M` has negation if {lean}`R` has,
because a priori it cannot guess the correct {lean}`R` given an arbitrary {lean}`M`.
So if we declare variables like:
```lean
variable [Ring R] [AddCommMonoid M] [Module R M]
```
then trying to negate elements of {lean}`M` will fail.

```lean +error (name := negError)
#check fun x : M => -x
```
```leanOutput negError
failed to synthesize instance of type class
  Neg M

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
```
The solution is to either declare \[{lean}`AddCommGroup M`\] in your variables,
or to add the instance inline using {lean}`Module.addCommMonoidToAddCommGroup`.

:::

## Examples of modules

```lean -show
variable {i j : Type} {n : ℕ} {R M : Type*} [Ring R] [AddCommGroup M] [Module R M] {x : M}
```

The {lean}`n`-dimensional free module over the ring {lean}`R` is written {lean}`Fin n → R`.
Mathlib provides a module structure on the function type {lean}`i → R` for any type `i`.

A ring is a module over itself, with scalar multiplication equal to multiplication.
This module structure is found by typeclass inference. Use {name}`smul_eq_mul` to state this equality.

Finally, an additive monoid {lean}`M` is a module over the natural numbers,
with the scalar multiplication {lean}`n • x` defined as `x + x + ... + x`, {lean}`n` times.
Analogously, additive groups are modules over the integers.
These module structures are found by typeclass inference.

## Linear maps

## Submodules

## Linear independence

## Basis and free modules

## Rank and dimension

## Finite modules

# Matrices

The type of matrices is written {lean}`Matrix i j R`. ...

In this context, a *vector* (written `vec` inside of names) refers to functions {lean}`i → R`, where {lean}`i` can often be any (finite) type. Sometimes operations on vectors are restricted to the case {lean}`i = Fin n`.

## Determinant

## Inverse

## Converting between matrices and linear maps

# Bilinear, sesquilinear and quadratic forms.
