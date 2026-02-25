---
layout: page
title: "Method (QFIE)"
---

## Architecture
Describe the navigation stack and where QFIE sits:
1. Inputs / state variables
2. Fuzzification (membership functions)
3. Quantum fuzzy inference (offline execution)
4. Control-surface extraction
5. Onboard deployment (fast lookup / interpolation)

## Fuzzy interface (interpretable layer)
- Linguistic variables:
  - e.g., distance to obstacle, heading error, etc.
- Rule base:
  - e.g., IF distance is *close* AND heading error is *large* THEN angular velocity is *high*, etc.

## Quantum inference (NISQ constraints)
- Execution is dominated by:
  - cloud latency + hardware overhead
- But complexity claims focus on:
  - scaling behaviour vs classical fuzzy inference

## Output: control surfaces
![Control surface]({{ site.baseurl }}/assets/img/control_surface.png)