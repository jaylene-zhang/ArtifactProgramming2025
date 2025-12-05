# Artifact for: *[Paper title]*

**Artifact URL:** https://github.com/your-org/your-artifact (or Google Drive / single zip)  
**Artifact hash (sha256 or commit):** `<paste sha256 or full commit hash here>`  
**Paper URL (most recent):** https://.../your-paper.pdf

---

## 1. Getting Started Guide (kick-the-tyres in ≤30 minutes)

### Overview
This artifact contains the three benchmarks (λCodeGen, λRepair, λExplain), the scripts used to query LLMs, grader-wrapper scripts (call LearnOCaml), and the analysis/plotting scripts. Because LearnOCaml is a heavy external grader, the full pipeline is **not** runnable by reviewers. Instead we provide processed results and sample grader outputs so reviewers can inspect and re-run analysis/plots quickly.

### Quick test (30-minute smoke test)
These steps let reviewers verify the key elements quickly (no LearnOCaml installation required).

1. Download the single artifact file (zip) or clone the repo:
   ```bash
   # if single-file zip:
   wget -O artifact.zip "https://.../artifact.zip"
   sha256sum artifact.zip  # verify against provided sha256
   unzip artifact.zip
   # or clone:
   git clone https://github.com/your-org/your-artifact.git
   cd your-artifact

