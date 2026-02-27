---
layout: default
title: "Home"
nav_order: 1
---

# Bridging Mobile Robot Navigation and Quantum Computing via a Quantum Fuzzy Inference Engine (QFIE)

<div class="prisma-callout">
  <strong>Watch first:</strong> my video walkthrough (method + simulations + real rover).
  <br />
  <a class="btn btn-primary" href="#video-overview">Watch the video</a>
  <a class="btn" href="{{ '/experiments.html' | relative_url }}">Key results</a>
</div>

**Core message:** QFIE integrates *quantum-derived inference* into a mobile-robot navigation stack **without** executing quantum hardware in the closed loop. Quantum inference is run **offline** to characterise **control surfaces**; these are then deployed onboard as **lookup tables (LUTs)** that can be queried in real time.

---

## Video overview (method + simulations + real-robot experiments)
> Replace `ID_VIDEO` with your YouTube (or Vimeo) embed ID/link.

<!-- <iframe width="900" height="506"
src="https://www.youtube.com/embed/ID_VIDEO"
title="QFIE Paper Report – Video Overview"
frameborder="0"
allowfullscreen></iframe> -->

Option B (MP4 stored in the repo — recommended only for small files)
<video controls width="900">
  <source src="{{ '/assets/video/qfie_navigation_sub.mp4' | relative_url }}" type="video/mp4">
    <track label="English" kind="subtitles" srclang="en"
         src="{{ '/assets/video/qfie_navigation.vtt' | relative_url }}" default>
</video>

---

## Abstract (from the paper)
Quantum computing holds the theoretical potential to transcend classical limitations in processing high-dimensional state spaces and solving combinatorial optimisation problems, which are central to many fundamental challenges in robotics. However, its practical integration into robotics remains challenging, particularly under Noisy Intermediate-Scale Quantum (NISQ) constraints and the conceptual shift imposed by quantum programming models. In this work, we investigate the Quantum Fuzzy Inference Engine (QFIE) as an interpretable and deployment-oriented framework for embedding quantum inference within a mobile-robot navigation stack. QFIE leverages fuzzy logic as a human-readable interface between quantum computation and classical control design, enabling structured policy synthesis while preserving compatibility with existing robotic architectures. Although present wall-clock execution times are dominated by cloud access latency and hardware overhead, QFIE retains a provable exponential advantage in computational complexity over its classical fuzzy inference counterpart. Accordingly, rather than claiming immediate runtime superiority in this low-dimensional instantiation, this work establishes a concrete engineering and validation pathway for complexity-scalable quantum-derived inference. Quantum inference is therefore executed offline on a superconducting IBM backend to characterise the control surfaces, which are subsequently deployed onboard to meet closed-loop actuation constraints.

Simulation and real-world experiments on a four-wheeled rover demonstrate that the resulting controller can be reliably integrated into a physical robotic platform despite current NISQ limitations. To the best of our knowledge, this represents one of the first demonstrations of quantum computations executed on real IBM quantum hardware being experimentally integrated into the control pipeline of a real mobile robot.

---

## What this report focuses on (high signal only)
- The **engineering rationale**: why quantum must be offline today, and how LUT deployment preserves real-time control.
- The **minimum method** needed to understand the results (QFIE → surfaces → LUT).
- The **results that matter**: noise impact on surfaces, adaptive sampling savings, simulation success, real-robot validation.
- A candid view of **failure modes** and what would be required to address them.

---

## Results at a glance (key numbers)

| Block | What it demonstrates | Headline result |
|---|---|---|
| Adaptive sampling | Makes LUT acquisition feasible under cloud/NISQ constraints | Dense mapping: **1800** queries vs adaptive: **62** (**−96.5%**) |
| Cloud feasibility | Practical acquisition time under a free-tier quota | **t_query ≈ 6 s**, **T_dense ≈ 180 min** vs **T_opt ≈ 6.2 min** (within **10 min/month**) |
| FakeTorino vs ideal | Quantitative distortion under device-like noise | v: MAE **0.063 m/s** (RMSE 0.068, Max 0.200); ω: MAE **1.397 rad/s** (RMSE 1.488, Max 3.017) |
| Real QPU vs noisy–sparse | Hardware drift while preserving qualitative decisions | ω: MAE **0.244 rad/s** (RMSE 0.293, Max 0.730), **sign coherence 99.31%**; v: MAE **0.020 m/s** (RMSE 0.022, Max 0.0397) |
| Closed-loop simulation | Task-level viability in the full pipeline | **12/14 successful runs = 85.7%** |
| Physical rover experiments | End-to-end integration on real hardware | **4/6** successful static runs (5 cm); **2.5 cm docking** succeeded (~**+15% time**); dynamic obstacle injection stable |

**Interpretation:** the contribution is not “quantum is faster today”, but a validated pathway for deploying a **quantum-derived**, interpretable controller within real-time robotics constraints.

## Links
- Paper PDF: *(add link)*
- Code / artefacts: *(add link)*
- Supplementary video: *(add link)*