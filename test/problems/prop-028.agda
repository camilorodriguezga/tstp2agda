
-- tstp2agda proof

open import Data.FOL.Deep 3
open import Data.FOL.Deep.ATP.Metis 3

-- Vars
p : Prop
p = Var (# 0)

q : Prop
q = Var (# 1)

r : Prop
r = Var (# 2)

-- Premise
Γ : Ctxt
Γ = ∅

-- Conjecture
goal : Prop
goal = ((((p ⇒ r) ∧ (¬ p ⇒ ¬ q)) ∧ (p ∨ q)) ⇒ (p ∧ r))

-- Subgoals
subgoal₀ : Prop
subgoal₀ = ((((p ⇒ r) ∧ (¬ p ⇒ ¬ q)) ∧ (p ∨ q)) ⇒ p)

subgoal₁ : Prop
subgoal₁ = (((((p ⇒ r) ∧ (¬ p ⇒ ¬ q)) ∧ (p ∨ q)) ∧ p) ⇒ r)

-- Metis Proof.
proof₀ : Γ ⊢ subgoal₀
proof₀ =
  RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₀        )
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₀        )
        (
        atp-simplify $ ∧-intro
          (
          inference rule no supported yet $
            atp-canonicalize $
              atp-strip $
                assume {Γ = Γ} $
                  atp-neg subgoal₀          )
          (
          inference rule no supported yet $
            atp-canonicalize $
              atp-strip $
                assume {Γ = Γ} $
                  atp-neg subgoal₀          )
        )



proof₁ : Γ ⊢ subgoal₁
proof₁ =
  RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₁        )
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₁        )
        (
        inference rule no supported yet $
          atp-canonicalize $
            atp-strip $
              assume {Γ = Γ} $
                atp-neg subgoal₁        )



