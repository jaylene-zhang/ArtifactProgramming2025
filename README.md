# Artifact for: <Paper Title>

**Artifact URL:** <link to your hosted repo or zip>
**Artifact hash (sha256 or commit):** <sha256 hash or git commit>
**Paper URL (most recent version):** <link to latest paper PDF>

---

## 1. Getting Started Guide (kick-the-tyres in ≤30 minutes)

### Overview
This artifact contains:
- Benchmarks:
  - `benchmarks/CodeGen/` (homework-style OCaml problems)
  - `benchmarks/Repair/` (OCaml programs with errors)
  - `benchmarks/Explain/` (conceptual questions)
- Scripts:
  - `scripts/API calls/` (LLM query scripts)
  - `scripts/analysis and plot/` (postprocessing, computing percentages, plotting)
  - `scripts/grader_wrapper.py` (wraps LearnOCaml grader; requires LearnOCaml)
- Results:
  - `results/` (processed results used in the paper)
- Figures:
  - `scripts/figures/` (example PDF outputs)

Because LearnOCaml is complex and LLM outputs are non-deterministic, **the full pipeline cannot be executed by reviewers**. Instead, this artifact allows reviewers to inspect the data and run the plotting/analysis scripts on the processed CSVs.

**Quick usage:**
- Inspect `benchmarks/` to see all problems/questions.
- Review `results/` for raw and processed CSVs that support the paper tables and figures.
- Run scripts in `scripts/analysis and plot/` to reproduce figures from processed CSVs.
- Inspect `scripts/grader_wrapper.py` to see how grader outputs were parsed.

> The key “kick-the-tyres” step is simply running analysis/plot scripts on `results/` files, which should execute in under 30 minutes on a modern laptop.

---

## 2. Overview of Claims

### Supported Claims

| Claim | Description | Evidence in Artifact | Paper Section |
|-------|------------|-------------------|---------------|
| Top LLMs achieve above 75% correctness on λCodeGen | Quantitative results for CodeGen problems | `results/CodeGenResults/final_grades.csv`, `scripts/analysis and plot/analyze_CodeGen.py` | Sec 3.1, Table 2 |
| LLMs can fix syntax/type errors | Quantitative success rates for λRepair | `results/RepairResults/syntax_error_percentages.csv`, `type_error_percentages.csv`, `logical_error_percentages.csv`, `scripts/analysis and plot/analyze_Repair.py` | Sec 4.4, Figures 3–5 |
| LLMs answer conceptual questions effectively | Quantitative percentages for λExplain | `results/ExplainResults/Explain_percentages.csv`, `scripts/analysis and plot/analyze_Explain.py` | Sec 4.3, Table 3 |

> Evidence includes processed CSVs, raw grader outputs, and plotting/analysis scripts used to generate figures and tables.

