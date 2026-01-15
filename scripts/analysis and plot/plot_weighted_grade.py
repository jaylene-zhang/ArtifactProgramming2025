"""
NOTE: Some intermediate CSVs used in the original pipeline are not included.
These scripts run on processed CSVs provided in results/, producing the figures in the paper.
"""


import csv
import matplotlib.pyplot as plt
import os

# Define file paths
# csv_folder = "tasks"
csv_files = ["CodeGenResults/CodeGen_percentages_Paper.csv",
"RepairResults/logical_error_percentages.csv",
"RepairResults/syntax_error_percentages.csv",
             "RepairResults/type_error_percentages.csv",
"ExplainResults/Explain_percentages_Paper.csv"]

task_names = ["code generation", "logical error repair", "syntax error repair", "type error repair", "conceptual explanation"]
# Collect scores per model per task
# task_scores[i] = dict of model → weighted_score
task_scores = []

for filename in csv_files:
    model_to_score = {}
    with open(os.path.join("../../results", filename), newline='') as f:
        reader = csv.DictReader(f)
        for row in reader:
            model = row["Model"].strip()
            if model == "o1":
                continue
            weighted = float(row["weighted"]) / 10  # Normalize
            model_to_score[model] = weighted
    task_scores.append(model_to_score)

# Get union of all model names across all tasks
all_models = sorted(set().union(*[set(ts.keys()) for ts in task_scores]))

# Prepare data for plotting
model_index = {model: i for i, model in enumerate(all_models)}
x = list(range(len(all_models)))

# Background grade group colors
background_bands = [
    ("Group 1", 7.7, 10, '#d0f0c0'),   # A, A- = light green
    ("Group 2", 6.2, 7.7, '#fffac8'),   # B+, B, B- = light yellow
    ("Group 3", 5.2, 6.2, '#ffd8b1'),   # C+, C = light orange
    ("Group 4", 0.0, 5.2, '#f4cccc'),   # D, F = light red
]

# Grade bands for yticks
grade_bands = [
    ("A",   8.2, 10),
    ("A-",  7.7, 8.2),
    ("B+",  7.2, 7.7),
    ("B",   6.7, 7.2),
    ("B-",  6.2, 6.7),
    ("C+",  5.7, 6.2),
    ("C",   5.2, 5.7),
    ("D",   4.7, 5.2),
    ("F",   1.5, 4.7),
]


###########################################################################
# === Custom y-axis transformation ===
def transform_y(y):
    t = 6.2

    if y < t:
        return y * 0.7
    else:
        return t * 0.7 + (y - t) * 2.25  # continuous transition

# === Plot setup ===
fig, ax = plt.subplots(figsize=(12, 10))
fig.patch.set_facecolor("white")
ax.set_facecolor("white")

# === Background color bands ===
for _, low, high, color in background_bands:
    ax.axhspan(transform_y(low), transform_y(high), color=color, alpha=1.0)

# === Y-ticks: use transformed positions ===
yticks = [low for _, low, _ in grade_bands]
ytick_labels = [label for label, _, _ in grade_bands]
ax.set_yticks([transform_y(y) for y in yticks])
ax.set_yticklabels(ytick_labels)

# === X-axis ===
ax.set_xticks(x)
ax.set_xticklabels(all_models, rotation=45, ha="right", fontsize=9)

# === Plot points with transformed y-values ===
colors = ['red', 'blue', 'green', 'purple', 'orange']
for task_idx, task in enumerate(task_scores):
    xs = []
    ys = []
    for model in all_models:
        if model in task:
            xs.append(model_index[model])
            ys.append(transform_y(task[model]))
    ax.scatter(xs, ys, color=colors[task_idx], label=task_names[task_idx], s=60)

###########################################################################
# Styling
ax.set_ylabel("Letter Grade")
ax.set_title("LLM Weighted Grades Across Tasks")
ax.set_ylim(1, 10)
ax.grid(axis='y', linestyle='--', alpha=0.5)
ax.legend()
plt.tight_layout()
# plt.show()
plt.savefig("../figures/LLM_Weighted.pdf")
print("figure saved to ../figures/LLM_Weighted.pdf")


