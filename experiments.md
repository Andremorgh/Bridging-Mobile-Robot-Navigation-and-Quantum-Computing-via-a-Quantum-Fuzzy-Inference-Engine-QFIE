---
layout: page
title: "Experiments"
---

## Setup
- Platform: four-wheeled rover
- Environments: simulation + real world
- Metrics: tracking error, collision rate, stability, success rate, etc.

## Offline-to-onboard pipeline
1. Run quantum inference on IBM backend (offline)
2. Fit/construct control surfaces
3. Deploy onboard for closed-loop constraints

## Results snapshot
Add plots/screenshots in `assets/img/`:

![Trajectory example]({{ site.baseurl }}/assets/img/trajectory.png)

## Notes on limitations
- NISQ noise + access overhead
- Low-dimensional instantiation: not claiming wall-clock wins
- Value: engineering pathway + validated integration