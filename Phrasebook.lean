/-
Copyright (c) 2024-2025 Lean FRO LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Author: David Thrane Christiansen
-/

import VersoManual
import Phrasebook.Meta.Lean

-- This is a chapter that's included
import Phrasebook.LinearAlgebra

-- This gets access to most of the manual genre (which is also useful for textbooks)
open Verso.Genre Manual

-- This gets access to Lean code that's in code blocks, elaborated in the same process and
-- environment as Verso
open Verso.Genre.Manual.InlineLean


open Phrasebook

set_option pp.rawOnError true


#doc (Manual) "Mathlib Phrasebook" =>

%%%
authors := ["the Mathlib community"]
%%%

{index}[example]
The Mathlib phrasebook tells you the answer to questions of the form "How do I say ... using Mathlib?"

{include 1 Phrasebook.LinearAlgebra}

# Index
%%%
number := false
tag := "index"
%%%

{theIndex}
