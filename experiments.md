---
layout: default
title: "Simulations and Experiments"
nav_order: 3
---

<h2 id="simulation-gallery">Simulation gallery (looping clips)</h2>

<div class="sim-grid">
  <figure class="sim-item">
    <video class="sim-vid" autoplay muted loop playsinline controls preload="metadata">
      <source src="{{ '/assets/video/qfie_navigation_sub.mp4' | relative_url }}" type="video/mp4">
    </video>
    <figcaption>Scenario 01</figcaption>
  </figure>

  <figure class="sim-item">
    <video class="sim-vid" autoplay muted loop playsinline controls preload="metadata">
      <source src="{{ '/assets/video/qfie_navigation_sub.mp4' | relative_url }}" type="video/mp4">
    </video>
    <figcaption>Scenario 02</figcaption>
  </figure>

  <!-- …repeat up to sim14… -->

  <figure class="sim-item">
    <video class="sim-vid" autoplay muted loop playsinline controls preload="metadata">
      <source src="{{ '/assets/video/qfie_navigation_sub.mp4' | relative_url }}" type="video/mp4">
    </video>
    <figcaption>Scenario 14</figcaption>
  </figure>
</div>


<!-- ## Overview (evaluation ladder)
The paper validates QFIE progressively:

1. **Control-surface characterisation** (ideal vs device-like noise; then real QPU surfaces).
2. **Deployment feasibility** via **adaptive sampling** (reducing the number of quantum queries).
3. **Closed-loop simulation** using LUTs derived from real-QPU surfaces.
4. **Real-world rover experiments** (static and stress-test scenarios).

> If you prefer the full narrative, watch the video on the homepage and use this page as the “numbers + interpretation” companion.

---

## 1) Control surfaces under NISQ-like noise (FakeTorino vs ideal)
To quantify the effect of device-calibrated noise, the paper compares dense (30×30) control surfaces produced by an **ideal** pipeline versus a **device-like noisy simulator** (“FakeTorino”).

### Pointwise deviations (dense 30×30 grid)
| Channel | MAE | RMSE | Max \|Δ\| |
|---|---:|---:|---:|
| **v** (m/s) | 0.063 | 0.068 | 0.200 |
| **ω** (rad/s) | 1.397 | 1.488 | 3.017 |

**Interpretation:** noise primarily distorts **amplitude** (often a “flattening/range contraction” effect), while preserving much of the **qualitative structure** (e.g., switching regions) that matters for policy shape.

![Device-like noise vs ideal (example visualisation)]({{ '/assets/img/noisy_vs_ideal.png' | relative_url }})

---

## 2) Adaptive sampling (making QPU characterisation practical)
A naïve dense mapping of both control channels on 30×30 grids requires:

- **N_dense = 2 × 30 × 30 = 1800** quantum queries.

The adaptive strategy instead selects sparse “anchor points”, focusing evaluations where the surface changes most:

- **N_v = 20**, **N_ω = 42** → **62 total** queries (≈ **−96.5%**).

### Practical timing (headline feasibility)
Using the paper’s representative **t_query ≈ 6 s**:
- Dense mapping: ~180 minutes.
- Adaptive mapping: ~6.2 minutes — compatible with a tight monthly cloud quota.

**Interpretation:** adaptive sampling is the *deployment enabler* under NISQ/cloud constraints; without it, offline surface acquisition becomes impractical.

![Adaptive sampling anchor points]({{ '/assets/img/adaptive_anchor_points.png' | relative_url }})

---

## 3) Real QPU (IBM torino) surfaces vs noisy–sparse reference
The paper runs quantum inference on a real superconducting IBM backend (torino) to generate control surfaces, then compares them to surfaces obtained via the device-like noisy simulator (with sparse sampling).

### Real-QPU vs noisy–sparse deviations
- **Angular channel (ω):** MAE **0.244 rad/s**, RMSE **0.293 rad/s**, Max \|Δ\| **0.730 rad/s**  
  Global **sign coherence = 99.31%** (with only a small number of critical sign inversions).
- **Linear channel (v):** MAE **0.020 m/s**, RMSE **0.022 m/s**, Max \|Δ\| **0.0397 m/s**

**Interpretation:** real hardware induces measurable drift (especially in ω), but the controller retains strong qualitative consistency, supporting the “offline QPU → onboard LUT” approach.

![Real-QPU control surfaces (deployed as LUTs)]({{ '/assets/img/real_qpu_surfaces.png' | relative_url }})

---

## 4) Closed-loop simulation (LUTs from real QPU)
### Setup (high-level)
The evaluation uses a bounded simulated arena (10 m × 10 m) with multiple navigation scenarios and waypoint configurations.

### Success rate
Across **14 episodes**, the controller achieves a success rate of **85.7%**.

### Failure modes (what breaks, and why it matters)
The paper identifies two recurring corner cases:
- **Goal–obstacle conflict:** when the goal lies too close to an obstacle, the rule base may oscillate between “goal-seeking” and “avoidance” behaviours.
- **Corner entrapment:** in sharp concavities, gradients can vanish or become locally inconsistent, causing the rover to get trapped.

**Interpretation:** these failures are *controller-structure* issues (rule-base/state design), not merely noise artefacts — useful guidance for how to extend QFIE controllers.

![Simulation trajectories (representative episodes)]({{ '/assets/img/sim_trajectories.png' | relative_url }})

---

## 5) Physical rover experiments (real-world integration)
### Static-obstacle trials (laboratory)
In a **30 m²** lab arena, the authors executed **six** static-obstacle episodes:
- **4/6 runs** completed successfully under the nominal **5 cm** waypoint acquisition criterion.

Two failures are discussed in terms of the controller’s behaviour near goal/obstacle boundary conditions.

### Precision “docking” stress test
The waypoint acquisition threshold was tightened:
- from **5 cm** to **2.5 cm**.
- The rover successfully docked in both trials, but the final approach required ~**15% more time** than nominal runs.

**Interpretation:** the controller remains stable under tighter tolerances, but exhibits mild oscillations near the target — suggesting a missing “close-quarters docking” state or rule refinement.

### Dynamic obstacle injection (stress test)
A dynamic obstacle is introduced during the run; the behaviour remains stable and the rover adapts without catastrophic divergence.

![Physical run: telemetry and reconstructed path]({{ '/assets/img/physical_telemetry.png' | relative_url }})

---

## Takeaways (what the results actually establish)
- **Feasibility:** QPU-derived inference can be integrated into a real mobile robot **today** via offline surface characterisation and onboard LUT execution.
- **Robustness:** noise affects amplitude, but qualitative decision structure can remain highly coherent (especially when using adaptive sampling and careful deployment).
- **Limitations:** corner cases highlight the need for richer state variables and/or additional rule states (e.g., dedicated docking behaviour, corner handling).

---

## Where to go next
- For the pipeline and why the offline–online split is essential, see:  
  ➡️ [Method (QFIE)]({{ '/method.html' | relative_url }})
- For a guided narrative with visuals, start from the video on the homepage. -->