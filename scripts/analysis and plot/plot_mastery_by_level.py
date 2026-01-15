"""
NOTE: Some intermediate CSVs used in the original pipeline are not included.
These scripts run on processed CSVs provided in results/, producing the figures in the paper.
"""


import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

# Use seaborn style
sns.set_style("whitegrid")

# Load stats (already computed)
stats = pd.read_csv("../../results/ExplainResults/mastery_rate_by_difficulty_Explain.csv")

# Filter relevant difficulties and remove model 'o1'
filtered = stats[stats['difficulty'].isin([1, 2, 3])]
filtered = filtered[filtered['model'] != 'o1']

models = sorted(filtered['model'].unique())
x = np.arange(len(models))
bar_width = 0.15

fontsizes = 22

# Color schemes
# BM-Explain: warm colors
explain_colors = {1: "#FFD92F", 2: "#FF7F00"}

# BM-CodeGen: cool gradient
codegen_colors = {1: "#4DBBD5", 2: "#377EB8", 3: "#984EA3"}

# Difficulty labels
diff_label_map = {1: 'B', 2: 'AC'}
diff_label_map2 = {1: 'B', 2: 'AP', 3:'PT'}

# Bar offsets
explain_offsets = [-0.2, 0.0, 0.2]
codegen_offsets = [-0.2, 0.0, 0.2]

# BM-Explain subplot
fig, (ax1, ax2) = plt.subplots(nrows=2, ncols=1, figsize=(25, 12), sharex=True)

# Draw BM-Explain bars
for i, difficulty in enumerate([1, 2]):
    y = []
    for model in models:
        row = filtered[(filtered['model'] == model) & (filtered['difficulty'] == difficulty)]
        rate = row['mastery_rate'].values[0] if not row.empty else 0.0
        y.append(rate)
    alpha = 0.7 if difficulty == 1 else (0.85 if difficulty == 2 else 1.0)
    label = f'Mastery ({diff_label_map[difficulty]}) BM-Explain'
    ax1.bar(x + explain_offsets[i], y, bar_width, label=label, color=explain_colors[difficulty], alpha=alpha)

ax1.set_ylabel('Percentage', fontsize=fontsizes)
ax1.set_ylim(0, 1.1)
ax1.tick_params(axis='y', labelsize=18)  # <-- increase y-axis tick labels
ax1.legend(loc='upper center', fontsize=fontsizes)
ax1.set_title("BM-Explain Performance by Model", fontsize=fontsizes)

# BM-CodeGen subplot data (remove o1 data)
# Only 9 models now
new_data_B = [0.87, 0.84, 0.41, 0.47, 0.65, 0.24, 0.79, 0.29, 0.89]  # B
new_data_AP = [0.65, 0.74, 0.23, 0.46, 0.75, 0.1, 0.49, 0.23, 0.74]  # AP
new_data_PT = [0.433, 0.267, 0.067, 0.2, 0.2, 0.0, 0.2, 0.0, 0.4]     # PT;calculated manually

codegen_data = [new_data_B, new_data_AP, new_data_PT]

for i, difficulty in enumerate([1, 2, 3]):
    y = codegen_data[i]
    alpha = 0.7 if difficulty == 1 else (0.85 if difficulty == 2 else 1.0)
    label = f'Mastery ({diff_label_map2[difficulty]}) BM-CodeGen'
    ax2.bar(x + codegen_offsets[i], y, bar_width, label=label, color=codegen_colors[difficulty], alpha=alpha)

ax2.set_ylabel('Percentage', fontsize=fontsizes)
ax2.set_ylim(0, 1.1)
ax2.tick_params(axis='y', labelsize=18)  # <-- increase y-axis tick labels

ax2.legend(loc='best', fontsize=fontsizes)
ax2.set_title("BM-CodeGen Performance by Model", fontsize=fontsizes)

# Shared X-axis
ax2.set_xticks(x)
ax2.set_xticklabels(models, rotation=45, ha='center', fontsize=fontsizes)

plt.tight_layout()
plt.savefig("../figures/mastery_by_level.pdf", dpi=300)
print("figures saved to ../figures/mastery_by_level.pdf")
# plt.show()
