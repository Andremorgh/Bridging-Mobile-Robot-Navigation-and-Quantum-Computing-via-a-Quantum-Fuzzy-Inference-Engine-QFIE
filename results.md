---
layout: page
title: "Discussion & Key Results"
---

## 1) What the paper proves (and what it does not)
### What is established
- A **quantum-derived**, interpretable navigation controller can be **integrated end-to-end** into a real mobile robot by running quantum inference **offline** and deploying **control surfaces as LUTs** onboard.
- With careful surface reconstruction (notably **adaptive sampling**), the approach is **practically feasible** under present-day NISQ/cloud access constraints.

### What is explicitly *not* claimed
- The paper does **not** claim wall-clock runtime superiority for the low-dimensional instantiation tested; current end-to-end time is dominated by **cloud latency** and **hardware overhead**.

---

## 2) The “headline results” (high signal only)

### A) Adaptive sampling: the deployment enabler
Dense mapping of both control channels at 30×30 resolution would require:
- **1800** quantum queries (2 surfaces × 30 × 30).

Adaptive sampling reduces this to:
- **62** total queries (≈ **−96.5%**).

**Why it matters:** this is the difference between an infeasible surface acquisition campaign and a practical offline procedure compatible with tight time/budget limits.

---

### B) Noise impact: distortion is measurable, but structure often persists
On dense surfaces (30×30), device-like noise (FakeTorino) produces non-trivial deviations from the ideal reference:
- **v**: MAE **0.063 m/s** (RMSE 0.068, Max |Δ| 0.200)
- **ω**: MAE **1.397 rad/s** (RMSE 1.488, Max |Δ| 3.017)

**Interpretation:** amplitude drift can be significant (particularly in ω), yet the surfaces can retain qualitative structure useful for closed-loop control.

---

### C) Real QPU surfaces: small drift relative to noisy–sparse reference
Comparing real QPU (IBM torino) surfaces to the noisy–sparse reference:
- **ω**: MAE **0.244 rad/s**, RMSE **0.293**, Max |Δ| **0.730**, **sign coherence 99.31%**
- **v**: MAE **0.020 m/s**, RMSE **0.022**, Max |Δ| **0.0397 m/s**

**Interpretation:** on real hardware, angular control exhibits the larger drift, but the policy remains strongly coherent in sign/qualitative behaviour.

---

### D) Closed-loop simulation: task-level viability
Across **14** simulated episodes:
- success rate: **85.7%**

Two principal failure modes are highlighted:
- **Goal–obstacle conflict** (goal very near an obstacle → oscillatory compromise)
- **Corner entrapment** (sharp concavity → local inconsistency / stalled progress)

**Interpretation:** these are actionable design targets (state/rule refinements), not just noise artefacts.

---

### E) Real rover: end-to-end integration works (with caveats)
In a laboratory arena:
- **4/6** static runs completed successfully (5 cm criterion).

Stress tests:
- **2.5 cm docking** succeeded but took ~**15%** longer than nominal runs.
- **Dynamic obstacle injection** remained stable.

**Interpretation:** the controller is deployable and stable; fine manoeuvres near the goal benefit from specialised state/rules (e.g., a docking mode).

---

## 3) The key engineering insight (why this paper is useful)
The work’s real contribution is an **integration blueprint**:

> Run quantum inference where it is currently viable (offline), then deploy the resulting policy representation (control surfaces) in a form compatible with classical real-time robotics (LUT + interpolation).

This makes the approach **architecture-compatible** with standard robotics stacks and creates a path to exploit potential complexity advantages as problem dimensionality grows.

---

## 4) Suggested “what I would improve next” (optional, concise)
If you want a short forward-looking section (useful in a report/presentation), keep it to 4 bullets:

- **State enrichment**: add features that disambiguate corners and near-goal docking.
- **Rule-base augmentation**: introduce explicit modes (e.g., *docking*, *corner escape*).
- **Surface validation**: quantify robustness under sensor noise and actuator saturation.
- **Scaling study**: push to higher-dimensional inputs where complexity-scaling claims become more testable (even if still offline).

---

## Figures (optional placement)
If you include figures on this page, I recommend:
- one “noise vs ideal” surface comparison,
- one real-QPU surface snapshot,
- one physical run telemetry/path.

![Noise vs ideal surfaces]({{ '/assets/img/noisy_vs_ideal.png' | relative_url }})

![Real-QPU surfaces]({{ '/assets/img/real_qpu_surfaces.png' | relative_url }})

![Physical run telemetry]({{ '/assets/img/physical_telemetry.png' | relative_url }})