"""
INSPECTION-ONLY SCRIPT

This script reflects the original experimental pipeline.
It depends on intermediate CSV files that are not redistributed
 and is provided for transparency only.

"""

import pandas as pd



def compute_by_categ(metadata, results, level):
    # Merge on index to get difficulty for each result
    merged = pd.merge(results, metadata[['index', 'difficulty']], on='index')

    # Group by model and difficulty
    grouped = merged.groupby(['model', 'difficulty'])

    # Aggregate total, mastery, and proficient counts
    stats = grouped['performance'].agg(
        total_attempts='count',
        mastery_count=lambda x: (x == 'Mastery').sum(),
        proficient_count=lambda x: (x == 'Proficient').sum()
    )

    # Compute rates
    stats['mastery_rate'] = (stats['mastery_count'] / stats['total_attempts']).round(2)
    stats['proficient_rate'] = (stats['proficient_count'] / stats['total_attempts']).round(2)

    # Reset index for saving to CSV
    stats = stats.reset_index()

    # Save to CSV
    stats.to_csv("mastery_proficient_rate_by_difficulty.csv", index=False)


# Load CSVs
metadata = pd.read_csv("./exam_questions/conceptual_qs_meta.csv")
results = pd.read_csv("exam_results.csv")
compute_by_categ(metadata, results, "Mastery")