---
layout: default
title: "Method (QFIE)"
nav_order: 2
---

## 1) System overview (what runs where)
This work proposes a **hybrid deployment**:

- **Offline (cloud + QPU):** run the Quantum Fuzzy Inference Engine (QFIE) to *characterise* the controller, i.e. to generate **control surfaces** for linear and angular velocity.
- **Online (onboard rover):** query those surfaces as **lookup tables (LUTs)** (with interpolation), so the closed-loop controller stays real time.

This design is the key engineering choice: it avoids NISQ/cloud latency in the control loop while still enabling a **quantum-derived** policy to be deployed on a physical robot.

![Pipeline overview]({{ '/assets/img/pipeline.png' | relative_url }})

---

## 2) Compact state for navigation (why only a few inputs)
Rather than feeding high-dimensional sensor data directly into inference, the navigation state is **compressed** into a small set of interpretable variables suitable for fuzzy rules and for quantum encoding.

A typical instantiation uses three inputs (conceptually):
- **Heading error** (angular deviation from the desired direction),
- **Goal distance error** (distance-to-goal or a related measure),
- **Obstacle cue** derived from LiDAR (a compact “proximity / blockage” indicator).

This is deliberate: the paper’s focus is not high-dimensional perception, but **control policy synthesis** and **deployment**.

---

## 3) QFIE in one page (only the essential mechanics)
QFIE keeps fuzzy logic as the *human-readable interface* and uses quantum computation to execute the inference step.

### 3.1 Fuzzy layer (interpretable interface)
- Define **linguistic variables** for each input (e.g. *small/medium/large*, *left/centre/right*).
- Specify a **rule base** (IF–THEN rules) mapping inputs to outputs (linear speed `v` and angular speed `ω`).
- Choose membership functions and a defuzzification method consistent with classical fuzzy control practice.

### 3.2 Quantum inference step (where the “quantum” lives)
At a high level:
1. Inputs are **fuzzified** to membership degrees.
2. Membership degrees are **encoded** into quantum registers.
3. A quantum circuit acts as an **inference oracle** that couples antecedents to consequents.
4. Measurements estimate output probabilities/activations.
5. Final **aggregation + defuzzification** produce continuous outputs.

**Important framing:** the paper does *not* claim wall-clock superiority today; the value is the path to **complexity-scalable** inference while retaining an interpretable fuzzy interface.

---

## 4) From quantum outputs to deployable control surfaces
Because QPU access is slow and intermittent, the controller is represented as **control surfaces**:
- one surface for `v(·)` and one for `ω(·)` over the compact state space.

These surfaces are then stored onboard as LUTs. During navigation:
- the controller queries the LUT at each timestep, typically using **bilinear interpolation** between neighbouring grid points.
- this keeps the computational load low and deterministic.

![Real-QPU control surfaces (adaptive sampling)]({{ '/assets/img/real_qpu_surfaces.png' | relative_url }})

---

## 5) Adaptive sampling (the practical enabler)
Dense surface mapping is expensive: the naïve approach evaluates the QFIE on a full grid (e.g. 30×30 points per surface), which becomes infeasible under real QPU/cloud constraints.

The paper therefore uses **adaptive sampling**:
- start with a sparse set of “anchor points”,
- detect regions of high variation / switching boundaries,
- refine sampling only where the surface needs it.

Net effect: you get a faithful approximation of the surface with **orders-of-magnitude fewer** QPU evaluations, making the offline characterisation feasible under tight time/budget constraints.

---

## 6) Onboard integration (what the robot actually executes)
On the rover, the runtime stack is conventional:
- compute the compact state (goal direction + obstacle cue),
- query `v` and `ω` from the LUT surfaces,
- send commands to the low-level controller at the required control rate.

This is why the paper is an engineering contribution: it demonstrates an end-to-end path from **real IBM quantum hardware** to a **stable closed-loop controller** on a physical platform, under NISQ-era constraints.

---

## 7) What to look for in the results
If you only remember one method-related takeaway, it should be this:

> **Offline QFIE → control surfaces → onboard LUT** is the architectural move that makes quantum inference compatible with real-time mobile-robot control today.

For the quantitative outcomes (noise impact, adaptive sampling savings, simulation success rate, real-robot runs), see **Experiments**.

➡️ Go to: [Experiments]({{ '/experiments.html' | relative_url }})