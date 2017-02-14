
-- tstp2agda proof

open import Data.FOL.Deep 4 public
open import Data.FOL.Deep.ATP.Metis 4 public

-- Vars
a : Prop
a = Var (# 0)

b : Prop
b = Var (# 1)

c : Prop
c = Var (# 2)

d : Prop
d = Var (# 3)

-- Axioms
a₁ : Prop
a₁ = a

a₂ : Prop
a₂ = b

a₃ : Prop
a₃ = ((¬ a ∨ ¬ b) ∨ c)

a₄ : Prop
a₄ = (¬ c ∨ d)

-- Premises
Γ : Ctxt
Γ = ∅ , a1 , a2 , a3 , a4

-- Conjecture
a₅ : Prop
a₅ = (((d ∧ a) ∧ b) ∧ c)

-- Subgoals
subgoal₀ : Prop
subgoal₀ = d

subgoal₁ : Prop
subgoal₁ = (d ⇒ a)

subgoal₂ : Prop
subgoal₂ = ((d ∧ a) ⇒ b)

subgoal₃ : Prop
subgoal₃ = (((d ∧ a) ∧ b) ⇒ c)

-- Metis Proof.
proof₀ : Γ ⊢ subgoal₀
proof₀ =
 RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        atp-canonicalize $
          atp-strip $
            assume {Γ = Γ} $
              atp-neg subgoal₀
        )
        (
        atp-simplify $ ∧-intro
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₀) (assume {Γ = ∅} a4)
          )
          (
          atp-simplify $ ∧-intro
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₀) (assume {Γ = ∅} a3)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₀) (assume {Γ = ∅} a1)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₀) (assume {Γ = ∅} a2)
            )
          )
        )

proof₁ : Γ ⊢ subgoal₁
proof₁ =
 RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        atp-canonicalize $
          atp-strip $
            assume {Γ = Γ} $
              atp-neg subgoal₁
        )
        (
        atp-canonicalize $
          weaken (atp-neg subgoal₁) (assume {Γ = ∅} a1)
        )
        (
        atp-simplify $ ∧-intro
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₁) (assume {Γ = ∅} a4)
          )
          (
          atp-simplify $ ∧-intro
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₁) (assume {Γ = ∅} a3)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₁) (assume {Γ = ∅} a1)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₁) (assume {Γ = ∅} a2)
            )
          )
        )

proof₂ : Γ ⊢ subgoal₂
proof₂ =
 RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        atp-canonicalize $
          atp-strip $
            assume {Γ = Γ} $
              atp-neg subgoal₂
        )
        (
        atp-canonicalize $
          weaken (atp-neg subgoal₂) (assume {Γ = ∅} a2)
        )
        (
        atp-canonicalize $
          weaken (atp-neg subgoal₂) (assume {Γ = ∅} a1)
        )
        (
        atp-simplify $ ∧-intro
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₂) (assume {Γ = ∅} a4)
          )
          (
          atp-simplify $ ∧-intro
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₂) (assume {Γ = ∅} a3)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₂) (assume {Γ = ∅} a1)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₂) (assume {Γ = ∅} a2)
            )
          )
        )

proof₃ : Γ ⊢ subgoal₃
proof₃ =
 RAA $
    atp-canonicalize $
      atp-simplify $ ∧-intro
        (
        atp-canonicalize $
          atp-strip $
            assume {Γ = Γ} $
              atp-neg subgoal₃
        )
        (
        atp-simplify $ ∧-intro
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₃) (assume {Γ = ∅} a3)
          )
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₃) (assume {Γ = ∅} a1)
          )
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₃) (assume {Γ = ∅} a2)
          )
        )
        (
        atp-canonicalize $
          weaken (atp-neg subgoal₃) (assume {Γ = ∅} a1)
        )
        (
        atp-canonicalize $
          weaken (atp-neg subgoal₃) (assume {Γ = ∅} a2)
        )
        (
        atp-simplify $ ∧-intro
          (
          atp-canonicalize $
            weaken (atp-neg subgoal₃) (assume {Γ = ∅} a4)
          )
          (
          atp-simplify $ ∧-intro
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₃) (assume {Γ = ∅} a3)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₃) (assume {Γ = ∅} a1)
            )
            (
            atp-canonicalize $
              weaken (atp-neg subgoal₃) (assume {Γ = ∅} a2)
            )
          )
        )

proof : Γ ⊢ goal
proof = ? -- Not supported yet

