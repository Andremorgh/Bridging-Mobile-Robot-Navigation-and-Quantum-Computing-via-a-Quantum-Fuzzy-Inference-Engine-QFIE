---
layout: page
title: "Paper Report"
---

# Bridging Mobile Robot Navigation and Quantum Computing via a Quantum Fuzzy Inference Engine

## Abstract
Quantum computing holds the theoretical potential to transcend classical limitations in processing high-dimensional state spaces and solving combinatorial optimisation problems. However, its practical integration into robotics remains challenging, particularly under Noisy Intermediate-Scale Quantum (NISQ) constraints and the conceptual shift imposed by quantum programming models. In this work, we investigate the Quantum Fuzzy Inference Engine (QFIE) as an interpretable and deployment-oriented framework for embedding quantum inference within a mobile-robot navigation stack. QFIE leverages fuzzy logic as a human-readable interface between quantum computation and classical control design, enabling structured policy synthesis while preserving compatibility with existing robotic architectures. Although present wall-clock execution times are dominated by cloud access latency and hardware overhead, QFIE retains a provable exponential advantage in computational complexity over its classical fuzzy inference counterpart. Accordingly, rather than claiming immediate runtime superiority in this low-dimensional instantiation, this work establishes a concrete engineering and validation pathway for complexity-scalable quantum-derived inference. Quantum inference is therefore executed offline on a superconducting IBM backend to characterise the control surfaces, which are subsequently deployed onboard to meet closed-loop actuation constraints.

Simulation and real-world experiments on a four-wheeled rover demonstrate that the resulting controller can be reliably integrated into a physical robotic platform despite current NISQ limitations. To the best of our knowledge, this represents one of the first demonstrations of quantum computations executed on real IBM quantum hardware being experimentally integrated into the control pipeline of a real mobile robot.

---

## What this report covers
- **Problem framing**: why navigation benefits from scalable inference / optimisation
- **QFIE**: fuzzy interface + quantum inference pipeline
- **Integration**: offline quantum → deployed onboard control surfaces
- **Evidence**: simulation + real rover experiments
- **Limits & takeaways**: what is “advantage” here, and what remains NISQ-limited

## Key idea (one paragraph)
QFIE uses **fuzzy logic as an interpretable layer** to define rules and membership functions, but evaluates the inference with a **quantum procedure** (run offline on IBM superconducting hardware), producing **control surfaces** that can be deployed onboard for real-time closed-loop control.

---

## Video demo
### Option A (recommended): YouTube/Vimeo embed
<iframe width="800" height="450"
src="https://www.youtube.com/embed/ID_VIDEO"
title="QFIE Demo"
frameborder="0"
allowfullscreen></iframe>

### Option B: MP4 hosted in the repo (ok for small files)
<!--
<video controls width="800">
  <source src="{{ site.baseurl }}/assets/video/demo.mp4" type="video/mp4">
</video>
-->

---

## Figures
Add your images in `assets/img/` and reference them like this:

![System overview]({{ site.baseurl }}/assets/img/system_overview.png)

![Control surface example]({{ site.baseurl }}/assets/img/control_surface.png)

---

## Repository / Resources
- Code: *(link)*
- Dataset/logs: *(link)*
- Paper PDF: *(link)*