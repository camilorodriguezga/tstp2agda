open import Data.Nat using (ℕ)

module Data.FOL.Deep.Theorems (n : ℕ) where

open import Data.FOL.Deep.Syntax n
open import Function using (_$_)

-- Equivalences.

id : ∀ {Γ} {φ} → Γ ⊢ φ → Γ ⊢ φ
id x = x

postulate ¬-⊤  : ∀ {Γ} → Γ ⊢ ¬ ⊤ → Γ ⊢ ⊥
postulate ¬-⊤₂ : ∀ {Γ} → Γ ⊢ ⊤   → Γ ⊢ ¬ ⊥

postulate ¬-⊥₁ : ∀ {Γ} → Γ ⊢ ¬ ⊥ → Γ ⊢ ⊤
postulate ¬-⊥₂ : ∀ {Γ} → Γ ⊢ ⊥   → Γ ⊢ ¬ ⊤


∧-comm  : ∀ {Γ} {φ ψ} → Γ ⊢ φ ∧ ψ → Γ ⊢ ψ ∧ φ
∧-comm {Γ} {φ}{ψ} seq = ∧-intro (∧-proj₂ seq) (∧-proj₁ seq)

postulate ∨-equiv : ∀ {Γ} {φ ψ} → Γ ⊢ φ ∨ ψ
                                → Γ ⊢ ¬ (¬ φ ∧ ¬ ψ)

postulate ∨-comm  : ∀ {Γ} {φ ψ} → Γ ⊢ φ ∨ ψ → Γ ⊢ ψ ∨ φ

postulate ∨-assoc₁ : ∀ {Γ} {φ ψ ρ} → Γ ⊢ (φ ∨ ψ) ∨ ρ
                                   → Γ ⊢ φ ∨ (ψ ∨ ρ)

postulate ∨-assoc₂ : ∀ {Γ} {φ ψ ρ} → Γ ⊢ φ ∨ (ψ ∨ ρ)
                                   → Γ ⊢ (φ ∨ ψ) ∨ ρ

postulate ∨-pick : ∀ {Γ} {φ ψ ρ} → Γ ⊢ (φ ∨ ψ) ∨ ρ
                                 → Γ ⊢ ψ ∨ (φ ∨ ρ)

postulate ¬-equiv : ∀ {Γ} {φ} → Γ ⊢ ¬ φ → Γ ⊢ φ ⇒ ⊥

-- Distribute Laws.

postulate ∧-dist₁ : ∀ {Γ} {φ ψ ω} → Γ ⊢ (φ ∨ ψ) ∧ ω
                                  → Γ ⊢ (φ ∧ ω) ∨ (ψ ∧ ω)

postulate ∧-dist₂ : ∀ {Γ} {φ ψ ω} → Γ ⊢ (φ ∧ ω) ∨ (ψ ∧ ω)
                                  → Γ ⊢ (φ ∨ ψ) ∧ ω

postulate ∨-dist₁ : ∀ {Γ} {φ ψ ω} → Γ ⊢ (φ ∧ ψ) ∨ ω
                                  → Γ ⊢ (φ ∨ ω) ∧ (ψ ∨ ω)

postulate ∨-dist₂ : ∀ {Γ} {φ ψ ω} → Γ ⊢ (φ ∨ ω) ∧ (ψ ∨ ω)
                                  → Γ ⊢ (φ ∧ ψ) ∨ ω

-- An example using a proof of x ∈ Γ.
swap : ∀ {Γ} {φ ψ γ} → (Γ , φ , ψ) ⊢ γ → Γ , ψ , φ ⊢ ψ
swap {Γ} {φ = φ}{ψ} x =
  axiom {Γ = (Γ , ψ , φ)} ψ $
    there {Γ = Γ , ψ} φ $
      here {φ = ψ} {Γ = Γ}

-- van Dalen 4th Edition. Chapter 2. Section 2.4.
-- Theorem 2.4.4

th244a : ∀ {Γ} {φ ψ} → Γ ⊢ φ ⇒ (ψ ⇒ φ)
th244a {Γ}{φ}{ψ = ψ} =
  ⇒-intro $
    ⇒-intro $
      weaken {φ = φ} ψ $
        assume {Γ = Γ} φ

th244b : ∀ {Γ} {φ ψ} → Γ ⊢ φ ⇒ (¬ φ ⇒ ψ)
th244b {Γ}{φ = φ}{ψ = ψ} =
  ⇒-intro $
    ⇒-intro $
      ⊥-elim {Γ = (Γ , φ , ¬ φ)} ψ $
        ¬-elim
          (assume  {Γ = (Γ , φ)} (¬ φ))
          (weaken (¬ φ) (assume {Γ = Γ} φ))

th244c : ∀ {Γ} {φ ψ ω} → Γ ⊢ (φ ⇒ ψ) ⇒ ((ψ ⇒ ω) ⇒ (φ ⇒ ω))
th244c {Γ}{φ = φ}{ψ}{ω} =
  ⇒-intro $
     ⇒-intro $
       ⇒-intro $
         ⇒-elim {Γ = Γ , φ ⇒ ψ , ψ ⇒ ω , φ}
           (weaken φ $
             assume {Γ = Γ , φ ⇒ ψ} $ ψ ⇒ ω)
           (⇒-elim {Γ = Γ , φ ⇒ ψ , ψ ⇒ ω , φ}
             (weaken φ $
               weaken (ψ ⇒ ω) $
                 assume {Γ = Γ} $ φ ⇒ ψ)
             (assume {Γ = Γ , φ ⇒ ψ , ψ ⇒ ω} φ))

th244d : ∀ {Γ} {φ ψ} → Γ ⊢ (¬ ψ ⇒ ¬ φ) ⇒ (φ ⇒ ψ)
th244d {Γ} {φ = φ}{ψ} =
  ⇒-intro $
    ⇒-intro $
      RAA $
        ¬-elim {Γ = Γ , ¬ ψ ⇒ ¬ φ , φ , ¬ ψ}
          (⇒-elim
            (weaken (¬ ψ) $
              weaken φ $
                assume {Γ = Γ} $ ¬ ψ  ⇒ ¬ φ)
            (assume {Γ = Γ , ¬ ψ ⇒ ¬ φ , φ} $ ¬ ψ))
          (weaken (¬ ψ) $
            assume {Γ = Γ , ¬ ψ ⇒ ¬ φ} φ)

th244e : ∀ {Γ} {φ} → Γ ⊢ ¬ (¬ φ) ⇒ φ
th244e {Γ} {φ} =
  ⇒-intro $ RAA
    (¬-elim {Γ = Γ , ¬ (¬ φ) , ¬ φ}
      (weaken (¬ φ) $
        assume {Γ = Γ} $ ¬ (¬ φ))
      (assume {Γ = Γ , ¬ (¬ φ)} $ ¬ φ))

e245b : ∀ {Γ Δ : Ctxt} {φ ψ} → Γ ⊢ φ → Δ , φ ⊢ ψ → Γ ⨆ Δ ⊢ ψ
e245b {Γ}{Δ = Δ} seq₁ seq₂ =
  ⇒-elim
    (weaken-Δ₂ Γ (⇒-intro seq₂))
    (weaken-Δ₁ Δ seq₁)

eComm⋀₁ : ∀ {Γ}{φ ψ : Prop} → Γ ⊢ φ ∧ ψ ⇒ ψ ∧ φ
eComm⋀₁ {Γ} {φ = φ}{ψ} =
  ⇒-intro $
    ∧-intro
      (∧-proj₂ $ assume {Γ = Γ} $ φ ∧ ψ)
      (∧-proj₁ {ψ = ψ} $ assume {Γ = Γ} $ φ ∧ ψ)

--- De Morgan's Law

∧-morgan₁ : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ (φ ∧ ψ) ⇒ (¬ φ ∨ ¬ ψ)
∧-morgan₁ {Γ} {φ}{ψ} =
  ⇒-intro {Γ = Γ} $
    RAA {Γ = Γ , ¬ (φ ∧ ψ)} {φ = ¬ φ ∨ ¬ ψ} $
      ¬-elim {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ)}
        (weaken (¬ (¬ φ ∨ ¬ ψ)) $
          assume {Γ = Γ} $ ¬ (φ ∧ ψ))
        (∧-intro
          (RAA {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ)} {φ = φ}
            (¬-elim {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ) , ¬ φ}
              (weaken (¬ φ) $
                assume {Γ = Γ , ¬ (φ ∧ ψ)} $ ¬ (¬ φ ∨ ¬ ψ))
              (∨-intro₁
                (¬ ψ)
                (assume {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ)} $ ¬ φ))))
          (RAA {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ)} {φ = ψ}
            (¬-elim {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ) , ¬ ψ}
              (weaken (¬ ψ) $
                assume {Γ = Γ , ¬ (φ ∧ ψ)} $ ¬ (¬ φ ∨ ¬ ψ))
              (∨-intro₂
                (¬ φ)
                (assume {Γ = Γ , ¬ (φ ∧ ψ) , ¬ (¬ φ ∨ ¬ ψ)} $ ¬ ψ )))))

postulate ∧-morgan₂ : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ φ ∨ ¬ ψ
                                  → Γ ⊢ ¬ (φ ∧ ψ)

postulate ∨-morgan₁ : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ (φ ∨ ψ) ⇒ ¬ φ ∧ ¬ ψ

postulate ∨-morgan₂ : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ φ ∧ ¬ ψ
                                  → Γ ⊢ ¬ (φ ∨ ψ)

-- auxiliar lemmas
lem1 : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ ¬ φ ∨ ¬ ¬ ψ → Γ ⊢ φ ∨ ψ
lem1 {Γ} {φ}{ψ} seq =
  ⇒-elim
    (⇒-intro
      (∨-elim {Γ = Γ}
        (∨-intro₁
          ψ
          (⇒-elim th244e $ assume {Γ = Γ} $ ¬ ¬ φ))
        (∨-intro₂
          φ
          (⇒-elim th244e $ assume {Γ = Γ} $ ¬ ¬ ψ))))
    seq

---
lem2 : ∀ {Γ} {φ ψ} → Γ ⊢ (φ ∨ ψ) ∧ ¬ ψ  → Γ ⊢ φ
lem2 {Γ} {φ}{ψ} seq =
  ⇒-elim
    (
    ⇒-intro $
      (∨-elim {Γ = Γ}
        (assume {Γ = Γ} φ)
        (⊥-elim {Γ = Γ , ψ}
          φ
          (¬-elim {Γ = Γ , ψ}
            (weaken ψ (∧-proj₂ seq))
            (assume {Γ = Γ} ψ))))
     )
    (∧-proj₁ seq)

postulate impl-pos   : ∀ {Γ} {φ ψ} → Γ ⊢ φ ⇒ ψ
                                   → Γ ⊢  ¬ φ ∨ ψ

postulate impl-equiv : ∀ {Γ} {φ ψ} → Γ ⊢ φ ⇒ ψ
                                   → Γ ⊢ ¬ φ ∨ ψ

postulate impl-neg   : ∀ {Γ} {φ ψ} → Γ ⊢ ¬ (φ ⇒ ψ)
                                   → Γ ⊢ φ ∧ ¬ ψ

-- Translation of Formulas to Negation Normal Form.

postulate contra  : ∀ {Γ} {φ} → Γ ⊢ φ ∧ ¬ φ
                              → Γ ⊢ ⊥

postulate contra₂ : ∀ {Γ} {φ} → Γ ⊢ ¬ φ ∧ φ
                              → Γ ⊢ ⊥

{-
mutual
  positive : Prop → Prop
  positive (Var x) = Var x
  positive ⊤ = ⊤
  positive ⊥ = ⊥
  positive (¬ φ)   = negative φ
  positive (φ ∧ ψ) = (positive φ) ∧ (positive ψ)
  positive (φ ∨ ψ) = (positive φ) ∨ (positive ψ)
  positive (φ ⇒ ψ) = (negative φ) ∨ (positive ψ)
  positive (φ ⇔ ψ) = (positive (φ ⇒ ψ)) ∧ (positive (ψ ⇒ φ))

  negative : Prop → Prop
  negative (Var x) = ¬ (Var x)
  negative ⊤ = ⊥
  negative ⊥ = ⊤
  negative (¬ φ)   = positive φ
  negative (φ ∧ ψ) = (negative φ) ∨ (negative ψ)
  negative (φ ∨ ψ) = (negative φ) ∧ (negative ψ)
  negative (φ ⇒ ψ) = (positive φ) ∧ (negative ψ)
  negative (φ ⇔ ψ) = (negative (φ ⇒ ψ)) ∨ (negative (ψ ⇒ φ))
-}


⇔-free : Prop → Prop
⇔-free (¬ φ)   = ¬ (⇔-free φ)
⇔-free (φ ∧ ψ) = ⇔-free φ ∧ ⇔-free ψ
⇔-free (φ ∨ ψ) = ⇔-free φ ∨ ⇔-free ψ
⇔-free (φ ⇒ ψ) = ⇔-free φ ⇒ ⇔-free ψ
⇔-free (φ ⇔ ψ) = (φ₁ ⇒ ψ₁) ∧ (ψ₁ ⇒ φ₁)
  where
    φ₁ : Prop
    ψ₁ : Prop
    φ₁ = ⇔-free φ
    ψ₁ = ⇔-free ψ
⇔-free φ = φ

⇒-free : Prop → Prop
⇒-free (¬ φ)   = ¬ ⇒-free φ
⇒-free (φ ∧ ψ) = ⇒-free φ ∧ ⇒-free ψ
⇒-free (φ ∨ ψ) = ⇒-free φ ∨ ⇒-free ψ
⇒-free (φ ⇒ ψ) = (¬ ⇒-free φ) ∨ ⇒-free ψ
⇒-free (φ ⇔ ψ) = ⇒-free φ ⇔ ⇒-free ψ
⇒-free φ       = φ


-- thm-⇒-free : ∀ {Γ} {φ} → Γ ⊢ φ → Γ ⊢ ⇒-free φ
-- thm-⇒-free {Γ} {¬ φ}  = atp-step (λ _ → ¬ ⇒-free φ)
-- thm-⇒-free {Γ} {φ ∧ ψ} seq =
--   ∧-intro
--     (thm-⇒-free $ ∧-proj₁ seq)
--     (thm-⇒-free $ ∧-proj₂ seq)
-- thm-⇒-free {Γ} {φ ⇒ ψ} seq =
--   ⇒-elim
--     (⇒-intro
--       (∨-elim {Γ = Γ}
--         (∨-intro₁ (⇒-free ψ)
--           (thm-⇒-free (assume {Γ = Γ} (¬ φ))))
--         (∨-intro₂ (¬ (⇒-free φ))
--           (thm-⇒-free (assume {Γ = Γ} ψ)))))
--     (impl-pos seq)
-- thm-⇒-free {Γ} {φ} = atp-step (λ _ → ⇒-free φ)

-- input φ: a logic formula without implication
-- output: φ': only propositional atoms in φ' are negated and φ'≡ φ
nnf : Prop → Prop
nnf (¬ (¬ φ)) = nnf φ
nnf (φ ∧ ψ) = (nnf φ) ∧ (nnf ψ)
nnf (φ ∨ ψ) = (nnf φ) ∨ (nnf ψ)
nnf (¬ (φ ∧ ψ)) = (nnf (¬ φ)) ∨ (nnf (¬ ψ))
nnf (¬ (φ ∨ ψ)) = (nnf (¬ φ)) ∧ (nnf (¬ ψ))
nnf φ = φ

thm-nnf : ∀ {Γ} {φ} → Γ ⊢ φ → Γ ⊢ nnf φ
thm-nnf {Γ} {¬ (¬ φ)} seq = thm-nnf $ ⇒-elim th244e seq
thm-nnf {Γ} {φ ∧ ψ} seq =
  ∧-intro
    (thm-nnf $ ∧-proj₁ seq)
    (thm-nnf $ ∧-proj₂ seq)

thm-nnf {Γ} {φ ∨ ψ} =
  ⇒-elim
    (⇒-intro
      (∨-elim {Γ = Γ}
        (∨-intro₁ (nnf ψ) $ thm-nnf $ assume {Γ = Γ} φ)
        (∨-intro₂ (nnf φ) $ thm-nnf $ assume {Γ = Γ} ψ)))

thm-nnf {Γ} {¬ (φ ∧ ψ)} seq =
  (⇒-elim
    (⇒-intro $
      ∨-elim {Γ = Γ}
        (∨-intro₁ (nnf (¬ ψ)) $ thm-nnf $ assume {Γ = Γ} (¬ φ))
        (∨-intro₂ (nnf (¬ φ)) $ thm-nnf $ assume {Γ = Γ} (¬ ψ)))
    (⇒-elim {Γ = Γ} ∧-morgan₁ seq))

thm-nnf {Γ} {¬ (φ ∨ ψ)} seq =
  ∧-intro
    (thm-nnf $ ∧-proj₁ $ ⇒-elim ∨-morgan₁ seq)
    (thm-nnf $ ∧-proj₂ $ ⇒-elim ∨-morgan₁ seq)
thm-nnf {Γ} {Var x}      = id
thm-nnf {Γ} {⊤}          = id
thm-nnf {Γ} {⊥}          = id
thm-nnf {Γ} {φ ⇒ φ₁}     = id
thm-nnf {Γ} {φ ⇔ φ₁}     = id
thm-nnf {Γ} {¬ Var x}    = id
thm-nnf {Γ} {¬ ⊤}        = id
thm-nnf {Γ} {¬ ⊥}        = id
thm-nnf {Γ} {¬ (φ ⇒ φ₁)} = id
thm-nnf {Γ} {¬ (φ ⇔ φ₁)} = id

-- input η₁ η₂ : η₁, η₂ are in CNF
-- output φ': φ' is in CNF and φ' ≡ η₁ ∨ η₂
distr : Prop → Prop
distr ((φ ∧ ψ) ∨ ω) = (distr (φ ∨ ω)) ∧ (distr (ψ ∨ ω))
distr (φ ∨ (ψ ∧ ω)) = (distr (φ ∨ ψ)) ∧ (distr (φ ∨ ω))
distr (φ ∨ ψ) = φ ∨ ψ
distr φ = φ


thm-distr : ∀ {Γ} {φ} → Γ ⊢ φ → Γ ⊢ distr φ
thm-distr {Γ} {(φ ∧ ψ) ∨ ω} seq =
  ∧-intro
    (thm-distr (∧-proj₁ (∨-dist₁ seq)))
    (thm-distr (∧-proj₂ (∨-dist₁ seq)))
thm-distr {Γ} {φ ∨ (ψ ∧ ω)} seq = atp-step (λ _ → distr (φ ∨ (ψ ∧ ω))) seq
  -- ∧-intro
  --   (thm-distr (∧-proj₁ (∨-dist₂  seq)))
  --   (thm-distr (∧-proj₂ (∨-dist₂ seq)))
thm-distr {Γ} {Var x} = id
thm-distr {Γ} {⊤} = id
thm-distr {Γ} {⊥} = id
thm-distr {Γ} {φ ∧ φ₁} = id
thm-distr {Γ} {φ ∨ φ₁} = atp-step (λ _ → distr (φ ∨ φ₁))
thm-distr {Γ} {φ ⇒ φ₁} = id
thm-distr {Γ} {φ ⇔ φ₁} = id
thm-distr {Γ} {¬ φ} = id


-- input φ: an NNF formula without implication
-- output φ': φ' is in CNF and φ'≡φ
cnf : Prop → Prop
cnf (φ ∧ ψ) = (cnf φ) ∧ (cnf ψ)
cnf (φ ∨ ψ) = (cnf φ) ∨ (cnf ψ)
cnf φ = φ

clausify : Prop → Prop
clausify φ = cnf $ nnf $ ⇒-free $ ⇔-free φ
