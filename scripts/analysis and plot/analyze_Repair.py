"""
INSPECTION-ONLY SCRIPT

This script reflects the original experimental pipeline.
It depends on intermediate CSV files that are not redistributed
 and is provided for transparency only.

Key results used in the paper are available in:
results/RepairResults/
"""
import pandas as pd
import numpy as np



def compute_performance_percentages(file):
    """
    Computes the percentage of each performance level for each model.

    """
    df = pd.read_csv(file)
    # List of all possible ratings
    ratings = ['Mastery', 'Proficient', 'Developing', 'Beginning']

    # Group by Model and Rating, then count occurrences
    performance_counts = df.groupby(['Model', 'Rating']).size().unstack(fill_value=0)

    # Calculate the total number of attempts for each model
    performance_counts['Total'] = performance_counts.sum(axis=1)

    # Calculate percentages for each rating
    for rating in ratings:
        performance_counts[f'{rating} %'] = round((performance_counts[rating] / performance_counts['Total']) * 100, 2)

    # Calculate Non-gradable percentage
    performance_counts['Non-gradable %'] = round(100 - performance_counts[[f'{rating} %' for rating in ratings]].sum(axis=1))

    # Keep only percentage columns
    performance_counts = performance_counts[[f'{rating} %' for rating in ratings] + ['Non-gradable %']]

    # Reset index to make Model a column
    performance_counts = performance_counts.reset_index()

    performance_counts.to_csv(f'{file[:-4]}_performance_percentages.csv', index=False)

    print(f"Performance percentages saved to {file[:-4]}_performance_percentages.csv")



def main():
    # File paths
    input_file = '../../results/RepairResults/syntax_error_results.csv'

    # Add the 'Rating' column and save
    # add_rating_column(input_file)

    compute_performance_percentages(input_file)



if __name__ == "__main__":
    main()