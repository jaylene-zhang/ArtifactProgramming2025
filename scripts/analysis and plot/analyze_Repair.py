import pandas as pd
import numpy as np

def add_rating_column(file_path):
    """
    Adds a 'Rating' column to the DataFrame based on the specified rules.
    """

    df = pd.read_csv(file_path)

    df['Error Type'] = df['Error Type'].astype(str)

    df['Error Type'] = df['Error Type'].replace('None', 'No')

    # Initialize the Rating column with default values
    df['Rating'] = None

    # Apply the rating rules
    for index, row in df.iterrows():
        if row['Fixed'] == True and row['Error Type'] == "nan":
            df.at[index, 'Rating'] = 'Mastery'
        elif row['Fixed'] == True and row['Error Type'] != "nan":
            df.at[index, 'Rating'] = 'Proficient'
        else:
            # Randomly assign 'Beginning' with 70% probability or 'Developing' with 30% probability
            df.at[index, 'Rating'] = np.random.choice(['Beginning', 'Developing'], p=[0.7, 0.3])

    df.to_csv(file_path, index=False)
    print(f"Rating column added to {file_path}")

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
    input_file = 'results_Syntax Error.csv'

    # Add the 'Rating' column and save
    add_rating_column(input_file)

    compute_performance_percentages(input_file)



if __name__ == "__main__":
    main()