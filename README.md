# DevOps-Portfolio - Static, Fast, Measurable


| **Cloudflare status**  |  [![Live Site](https://img.shields.io/badge/Cloudflare_Pages-Live-orange?logo=cloudflare)](https://devops-portfolio-zk9.pages.dev/) |
|---|---|
| **Deploy status**  |  [![Cloudflare Pages Deploy](https://github.com/SYimleang/DevOps-Portfolio/actions/workflows/deploy.yml/badge.svg)](https://github.com/SYimleang/DevOps-Portfolio/actions/workflows/deploy.yml) |
<!-- | Availability | ![Availability](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/SYimleang/DevOps-Portfolio/main/status/slo.json) | -->

This repository contains my personal DevOps portfolio website.
The site is intentionally designed as a production-style static system, prioritizing:

- Performance
- Stability
- Deterministic builds
- Observability
- Minimal operational complexity

It reflects how I approach real-world systems rather than showcasing UI effects or heavy frameworks.

## Design Goals

| Goal                 | Rationale                |
| -------------------- | ------------------------ |
| Static-first         | Zero runtime failures    |
| Fast by default      | Performance is a feature |
| Minimal dependencies | Fewer failure modes      |
| Deterministic builds | Reproducibility          |
| Measured outcomes    | No assumptions           |

This site deliberately avoids JavaScript frameworks, runtime compilation, and server-side rendering.

## Architecture Overview

Browser
↓
CDN (Cloudflare)
↓
Static Host (S3 / GitHub Pages)

CI/CD → Immutable Build → Cache-first Delivery

### Key Characteristics

- No application server
- No Node.js runtime in production
- No databases
- No background services

## Technology Stack

### Frontend

- HTML5
- Modern CSS (Grid / Flexbox)
- System fonts (no external font CDN)
- Zero runtime JavaScript

### CI/CD

 - GitHub Actions
 - Deterministic build scripts
 - Immutable deployment artifacts

## Repository Structure

src/ # Source files
README.md

## Performance Budget

This project enforces explicit performance budgets.
Changes that violate these budgets are considered regressions.

### Core Web Performance Targets

| Metric                         | Budget |
| ------------------------------ | ------ |
| Lighthouse Performance         | ≥ 95   |
| First Contentful Paint (FCP)   | ≤ 1.0s |
| Largest Contentful Paint (LCP) | ≤ 1.2s |
| Total Blocking Time (TBT)      | ≤ 100ms|
| Cumulative Layout Shift (CLS)  | 0      |
| Speed Index                    | ≤ 1.0s |

### Asset Budgets

| Asset Type | Budget                      |
| ---------- | --------------------------- |
| Total JS   | ≤ 30 KB (current: **0 KB**) |
| Total CSS  | ≤ 50 KB                     |
| Fonts      | System fonts preferred      |
| Images     | Optimized, lazy-loaded      |
| Requests   | Minimal, deterministic      |

### Performance Enforcement

This project enforces performance budgets using Lighthouse CI.
Pull requests or commits that violate performance thresholds will fail the CI pipeline and block deployment.
Performance is treated as a **release requirement**, not an optimization task.

### Critical Path Constraints

- No render-blocking JavaScript
- CSS minimized and scoped
- Critical CSS inlined
- Non-critical styles deferred
- Fonts preloaded or system-native

## Current Performance Results

Measured using Lighthouse (Desktop):
| Metric | Result |
| ----------- | ------- |
| Performance | **100** |
| FCP | 0.2s |
| LCP | 0.4s |
| TBT | 0 ms |
| CLS | 0 |
| Speed Index | 0.2s |

## CI/CD Pipeline
git push
  → build
  → optimize
  → deploy
  → verify
  
### Pipeline Characteristics
 - Fully automated
 - No manual deployment steps
 - Rollback via Git history
 - Immutable artifacts

## Availability & SLO

This service is continuously monitored via automated uptime checks every 5 minutes.

**Service Level Objective (SLO):
 - Availability target: **99.9%**
 - Measurement window: 30 days
 - Error budget: 43.2 minutes/month

Availability is calculated from real HTTP checks and published automatically.

## Contact

- GitHub: [SYimleang](https://github.com/SYimleang)
- LinkedIn: [Sasawat Yimleang](https://www.linkedin.com/in/sasawat-yimleang-564620155/)
- Email: framilly.eng@gmail.com
