# Artifact for: Evaluating LLMs in the Context of Functional Programming: A Comprehensive Study

**Artifact URL:** (https://github.com/jaylene-zhang/ArtifactProgramming2025)

**Artifact hash:** 1a76bd8e8d5ffd81ff046927f38d4c749e1ffd6c

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
  - `results/` (both raw and processed results used in the paper, omitted some intermediate results)
- Figures:
  - `scripts/figures/` (example PDF outputs)

**Omitted Intermediate Artifacts**

Several scripts in `scripts/analysis and plot/` reference intermediate CSV files (e.g., grading logs or preprocessing outputs) that were used during the original experimental pipeline but are not redistributed in this artifact. These files either depend on external systems (LearnOCaml), manual grading, or on non-deterministic LLM API calls.
For example, `RepairResults/syntax_error_raw.csv` and  `RepairResults/syntax_error_results.csv` will require LearnOCaml grader to produce.

To support artifact evaluation, we include all final computed percentages used to generate the tables and figures in the paper (under `results/`). No runnable script in the kick-the-tyres evaluation depends on omitted intermediate files. Scripts that reference such files are provided for inspection only and are not required for reproducing any reported claim.

**Quick usage:**
- Inspect `benchmarks/` to see all problems/questions and their metadata.
- Review `results/` for both raw and processed CSVs that support the paper tables and figures. 
- Run the following scripts (no command-line arguments required):

| Script                                                                                        | Purpose                                                                       |
|-----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| `scripts/analysis and plot/plot_weighted_grade.py`                                            | Reproduces weighted correctness plots from processed CSVs                     |
| `scripts/analysis and plot/plot_histogram_by_difficulty.py`                                   | Reproduces performance-by-difficulty plots                                    |
| `scripts/analysis and plot/analyze_CodeGen.py`,`scripts/analysis and plot/analyze_Explain.py` | Computes final correctness percentages from processed CodeGen/Explain results |


- All other scripts are provided for inspection only.
> Note: Scripts used in the original experimental pipeline (e.g., LLM querying, LearnOCaml grading, or preprocessing) are **not part of the kick-the-tyres evaluation**. The intended evaluation consists solely of inspecting CSVs under `results/` and running the three scripts listed above, which complete in minutes on a standard laptop.


---

## 2. Overview of Claims

### Supported Claims

| Claim                                                                                                                                                     | Evidence in Artifact | Paper Section |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|---------------|
| LLMs perform around 5% better on syntax/type errors than on logical errors or full code generation                                                        | `results/RepairResults/syntax_error_percentages.csv`, `type_error_percentages.csv`, `logical_error_percentages.csv`, `scripts/figures/LLM_weighted.pdf` | Sec 3.2, Table 5-7 |
| All models struggle more with abstract concepts requiring theoretical implementation than basic programming tasks. And model performance gap widens here. | `results/ExplainResults/Explain_percentages.csv`, `scripts/figures/LLM_weighted.pdf` | Sec 3.3, Table 9, Sec 3.5, Figure 6 |
| Top LLMs can achieve above (or about) 70% correctness on λCodeGen                                                                                         | `results/CodeGenResults/final_grades.csv`, `scripts/analysis and plot/analyze_CodeGen.py` | Sec 3.1, Table 4 |

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
- **o1 data**: ignore any o1 data in the artifact since this model has been removed from the evaluation in the paper.
---

## 3. Step-by-Step Instructions for Each Claim

### Claim 1: LLMs perform around 5% better on syntax/type errors than on logical errors or full code generation

Paper Section: Sec 3.2, Tables 5–7

**Steps:**

1. inspect the RepairResults:
```bash
cd results/RepairResults/
```
Open the CSV files (percentages) to inspect success percentages for each model, which reports correctness percentages corresponding to Table 5-7.
Metadata for λRepair can be found in `benchmarks/Repair/xx_Error_meta.csv`

2. inspect the CodeGenResults:
```bash
cd results/CodeGenResults/
```
Open the CSV files (percentages) to inspect success percentages for each model, which reports correctness percentages corresponding to Table 4. Note that we also separate the results for each difficulty level: *AP*, *B*, *PT* as explained in Section 3 in the paper.
Metadata for λCodeGen can be found in `benchmarks/CodeGen/CodeGen_meta.csv`

3. To reproduce Figure 5:

Open a terminal and activate your Python environment:
   ```bash
   python3 -m venv venv && source venv/bin/activate
   pip install -r requirements.txt
   ```
Navigate to the `scripts/analysis\ and\ plot/` folder and run:

**Script:** `plot_weighted_grade.py`  
**Input:** `../../results/CodeGenResults/CodeGen_percentages.csv`, `../../results/RepairResults/xx_percentages.csv`,`../../results/ExplainResults/Explain_percentages.csv`
**Output:** `scripts/figures/LLM_weighted.pdf`  

```bash
cd scripts/analysis\ and\ plot/
python plot_weighted_grade.py
```
This figure reproduces the visualization shown in the paper (Figure 5). No command-line arguments are required; just run the script as-is.

### Claim 2: The majority of models struggle in λExplain. And model performance gap widens here. All models struggle more with abstract concepts requiring theoretical implementation than basic programming tasks. 

Paper Section: Sec 3.3, Table 9; Sec 3.5, Figure 6

**Steps:**

1. Produce `Explain_perpentages_Artifact.csv`

Navigate to Explain results:
```bash
cd scripts/analysis\ and\ plot/
python analyze_Explain.py
```
Running this script produces a CSV file at
`results/ExplainResults/Explain_percentages_Artifact.csv`.

To inspect the values reported in the paper, open
`results/ExplainResults/Explain_percentages_Paper.csv`, which contains the performance percentages corresponding to Table 9.

Minor discrepancies between these two CSV files are expected. They arise because some λExplain responses were re-graded manually after the paper submission.
These changes affect individual percentages but do not alter the overall performance trends, and the results consistently support the claim that most models struggle on λExplain tasks and that performance gaps widen for more abstract questions.

2. To reproduce Figure 6:

**Script:** `scripts/analysis\ and\ plot/plot_histogram_by_difficulty.py`  
**Input:**  statistics of λExplain and λCodeGen by difficulty level

`CodeGenResults/difficulty_rating_stats_x.csv` and `ExplainResults/mastery_rate_by_difficulty_Explain.csv` 

**Output:** `scripts/figures/mastery_by_level.pdf`  

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
   (Note: The script includes functions from the original preprocessing pipeline, which are commented out. The executed portion computes final correctness percentages exclusively from processed CSVs in `results/CodeGenResults/`.
)
4. 
```bash
python analyze_CodeGen.py 
```

The script produces a CSV file at `results/CodeGenResults/CodeGen_percentages_Artifact.csv`.

To inspect the values reported in the paper, open `results/CodeGenResults/CodeGen_percentages_Paper.csv`, which contains the performance percentages corresponding to Table 4.

Same as in the `Explain_percentages`, minor discrepancies between these two CSV files are expected due to refined manual grading performed after paper submission. 
In particular, for GPT-4o-mini, some model outputs that are syntactically valid but incomplete are now consistently classified as Non-gradable, leading to a redistribution across grading categories.
This update does not affect any supported claim in the paper, as GPT-4o-mini is not among the top-performing models used to justify the reported ~70% Mastery rate on λCodeGen. The overall trends and conclusions remain unchanged.