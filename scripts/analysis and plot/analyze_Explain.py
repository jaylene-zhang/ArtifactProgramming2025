import pandas as pd

# Load the CSV file into a DataFrame
# input_file = 'conceptual_results.csv'  # Replace with your actual file name
input_file = 'exam_results.csv'
df = pd.read_csv(input_file)

# Define the classification function
def classify_performance(score):
    if score == 4.0:
        return "Mastery"
    elif 3.0 <= score < 4.0:
        return "Proficient"
    elif 2.0 <= score < 3.0:
        return "Developing"
    elif 1.0 <= score < 2.0:
        return "Beginning"
    else:
        return "Non-gradable"

# Apply the classification to the 'overall' column
# df['performance_level'] = df['overall'].apply(classify_performance)

# Group by model and performance level, then compute percentages
performance_counts = df.groupby(['model', 'performance']).size().unstack(fill_value=0)
total_attempts = df.groupby('model').size()
performance_percentages = round(performance_counts.div(total_attempts, axis=0) * 100, 2)

# Add a column for each performance level (even if no data exists)
for level in ["Mastery", "Proficient", "Developing", "Beginning", "Non-gradable"]:
    if level not in performance_percentages.columns:
        performance_percentages[level] = 0.0

# Reorder columns to match the desired output
performance_percentages = performance_percentages[["Mastery", "Proficient", "Developing", "Beginning", "Non-gradable"]]

# Reset index to make 'model' a column
performance_percentages.reset_index(inplace=True)

# Rename columns for clarity
performance_percentages.columns = ["Model", "Mastery %", "Proficient %", "Developing %", "Beginning %", "Non-gradable %"]

# Save the results to a new CSV file
output_file = 'answer_gen_percentages.csv'
performance_percentages.to_csv(output_file, index=False)

print(f"Model performance percentages saved to {output_file}")