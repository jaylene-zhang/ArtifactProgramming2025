# Artifact for: Evaluating LLMs in the Context of Functional Programming: A Comprehensive Study

**Artifact URL:** (https://github.com/jaylene-zhang/ArtifactProgramming2025)

**Artifact hash (sha256 or commit):** <sha256 hash or git commit>

**Paper URL (most recent version):** (https://drive.google.com/file/d/1KTtE4VbsOOSnbPdf3uv9VcE-MCTB3clI/view?usp=sharing)

---

## 1. Getting Started Guide 

### Overview
This artifact contains:
- Benchmarks(with their corresponding metadata and output files from LLMs):
  - `benchmarks/CodeGen/` (homework-style OCaml problems)
  - `benchmarks/Repair/` (OCaml programs with errors)
  - `benchmarks/Explain/` (conceptual questions)
- Scripts:
  - `scripts/API calls/` (LLM query scripts)
  - `scripts/analysis and plot/` (postprocessing, computing percentages, plotting)
  - `scripts/grader_wrapper.py` (wraps LearnOCaml grader; requires LearnOCaml)
- Results:
  - `results/` (both raw and processed results used in the paper)
- Figures:
  - `scripts/figures/` (example PDF outputs)

Because LearnOCaml is complex and LLM outputs are non-deterministic, **the full pipeline cannot be executed by reviewers**. Instead, this artifact allows reviewers to inspect the data and run the plotting/analysis scripts on the processed CSVs.

**Quick usage:**
- Inspect `benchmarks/` to see all problems/questions.
- Review `results/` for raw and processed CSVs that support the paper tables and figures. 
- Run scripts in `scripts/analysis and plot/` to reproduce figures from processed CSVs. 
- Inspect `scripts/grader_wrapper.py` to see how grader outputs were parsed.

> Due to the way the performance was computed, scripts used to produce the tables could take more than 30 minutes. The key “kick-the-tyres” step is simply running analysis/plot scripts on `results/` files, which should execute in under 30 minutes on a modern laptop.

---

## 2. Overview of Claims

### Supported Claims

| Claim | Evidence in Artifact | Paper Section |
|-------|-------------------|---------------|
| LLMs perform around 5% better on syntax/type errors than on logical errors or full code generation | `results/RepairResults/syntax_error_percentages.csv`, `type_error_percentages.csv`, `logical_error_percentages.csv`, `scripts/figures/LLM_weighted.pdf` | Sec 3.2, Table 5-7 |
| All models struggle more with abstract concepts requiring theoretical implementation than basic programming tasks. And model performance gap widens here.| `results/ExplainResults/Explain_percentages.csv`, `scripts/figures/LLM_weighted.pdf` | Sec 3.3, Table 9, Sec 3.5, Figure 6 |
| Top LLMs achieve above 70% correctness on λCodeGen | `results/CodeGenResults/final_grades.csv`, `scripts/analysis and plot/analyze_CodeGen.py` | Sec 3.1, Table 4 |

> Evidence includes processed CSVs, raw grader outputs, and plotting/analysis scripts used to generate figures and tables.

### Unsupported Claims

| Claim | Reason Not Supported in Artifact |
|-------|--------------------------------|
| Exact replication of LLM outputs | Non-deterministic API responses; models may have updated since experiments |
| Full end-to-end grading | Requires LearnOCaml grader environment, which cannot be packaged in this artifact |

### Additional Notes

- **LearnOCaml dependency:** The grader wrappers depend on LearnOCaml. Link:https://github.com/ocaml-sf/learn-ocaml/tree/master. Sample grader logs are included in `results/` for inspection. 
- **LLM API calls:** Scripts in `scripts/API calls/` include placeholder API keys. Keys are not provided.  
- **Data privacy:** Student submissions in λRepair were anonymized. Processed outputs and example logs are provided in the artifact.

---

## 3. Step-by-Step Instructions for Each Claim

### Claim 1: LLMs perform around 5% better on syntax/type errors than on logical errors or full code generation

Paper Section: Sec 3.2, Tables 5–7

**Steps:**

1. Navigate to results:
```bash
cd results/RepairResults/
```

2. Open the CSV files (percentages) to inspect success percentages for each model.

3. To reproduce Figure 5:

**Script:** `scripts/plot_weighted_grade.py`  
**Input:** `../../results/CodeGenResults/final_grades.csv` (hardcoded in script)  
**Output:** `../../scripts/figures/LLM_weighted.pdf`  

**Run:**
```bash
cd scripts/analysis\ and\ plot/
python plot_weighted_grade.py
```
This figure reproduces the visualization shown in the paper (Figure 5). No command-line arguments are required; just run the script as-is.

### Claim 2: Models struggle more with abstract concepts requiring theoretical implementation

Paper Section: Sec 3.5, Figure 6
Files used: results/ExplainResults/Explain_percentages.csv, scripts/figures/mastery_by_level.pdf

**Steps:**

1. Navigate to Explain results:
```bash
cd results/ExplainResults/
```

2. Open Explain_percentages.csv to inspect model correctness by concept/difficulty.

3. To reproduce Figure 6:

**Script:** `scripts/plot_histogram_by_difficulty.py`  
**Input:**  `statistics by difficulty level, generated using analyze_CodeGen.py (hardcoded in script)` 
**Output:** `../../scripts/figures/codegen_histogram.pdf`  

**Run:**
```bash
cd scripts/analysis\ and\ plot/
python plot_histogram_by_difficulty.py
```
This figure reproduces the visualization shown in the paper (Figure 6). No command-line arguments are required; just run the script as-is. 


### Claim 3: Top LLMs achieve above 70% correctness on λCodeGen
Paper Section: Sec 3.1, Table 4  

**Steps:**
1. Open a terminal and activate your Python environment:
   ```bash
   python3 -m venv venv && source venv/bin/activate
   pip install -r requirements.txt
   ```

2. Navigate to the analysis scripts folder:
```bash
cd scripts/analysis\ and\ plot/
```

3. Run the analysis script:
```bash
python analyze_CodeGen.py 
```
No command-line arguments are required; just run the script as-is. The script also contains the preprocessing of raw data and have been commented out for inspection purpose.

4. Open results/CodeGenResults/code_gen.csv to inspect correctness percentages. These values correspond to Table 4 in the paper.

